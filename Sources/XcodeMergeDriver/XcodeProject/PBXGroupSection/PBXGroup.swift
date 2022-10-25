//
//  PBXGroup.swift
//  
//
//  Created by Istvan Balogh on 15.10.22.
//

import Foundation

@available(macOS 10.15, *)
class PBXGroup: Equatable, Hashable {
    
    private(set) var content: String
    private(set) var children: [String]
    let identifier: String
    let name: String
    var hasConflict: Bool {
        content.contains("<<<<<<<")
    }
    private let childrenSeparator = Separator(begin: "children = (\n", end: ");\n")
    private let nameSeparator = Separator(begin: " /* ", end: " */ = {")
    
    init(content: String) throws {
        self.content = content
        let children = self.content
            .sliceBetween(childrenSeparator)?
            .components(separatedBy: "\n") ?? []
        self.children = children
            .filter({ !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty })
        self.name = String(self.content.sliceBetween(nameSeparator) ?? "")
        self.identifier = self.content.components(separatedBy: " /*").first!.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func applyingDifference(between base: PBXGroup, other: PBXGroup) {
        let difference = other.children.difference(from: base.children) { $0 == $1 }
        children = children.equalityApplying(difference).uniqued()
        updateChildrenContent()
    }
    
    private func updateChildrenContent() {
        let oldChildrenContent = content.sliceBetween(childrenSeparator)!.trimmingCharacters(in: .whitespacesAndNewlines)
        let newChildrenContent = children.map { $0 }.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
        content = content.replacingOccurrences(of: oldChildrenContent, with: newChildrenContent)
    }
    
    static func == (lhs: PBXGroup, rhs: PBXGroup) -> Bool {
        lhs.name == rhs.name &&
        lhs.identifier == rhs.identifier &&
        Set(lhs.children).symmetricDifference(Set(rhs.children)).isEmpty
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(identifier)
    }
}
