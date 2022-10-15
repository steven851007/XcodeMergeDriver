//
//  PBXGroup.swift
//  
//
//  Created by Istvan Balogh on 15.10.22.
//

import Foundation

@available(macOS 10.15, *)
class PBXGroup: Equatable {
    
    private(set) var content: String
    private(set) var children: [PBXGroupChildLine]
    let name: String
    var hasConflict: Bool {
        content.contains("<<<<<<<")
    }
    
    private let childrenSeparator = (begin: "children = (\n", end: ");\n")
    
    init(content: String) throws {
        self.content = content.trimmingCharacters(in: .whitespacesAndNewlines)
        let children = self.content
            .slice(from: childrenSeparator.begin, to: childrenSeparator.end)?
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n") ?? []
        self.children = try children.map { try PBXGroupChildLine(content: $0) }
        self.name = self.content.slice(from: " /* ", to: " */ = {") ?? "Main"
    }
    
    func difference(from base: PBXGroup) -> CollectionDifference<PBXGroupChildLine> {
        let difference = children.difference(from: base.children) { $0 == $1 }
        return difference
    }

    @discardableResult
    func applying(_ difference: CollectionDifference<PBXGroupChildLine>) throws -> String {
        let oldContent = content
        let oldChildren = children.map { $0.content }.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
        guard let changedChildren = children.applying(difference) else {
            throw MergeError.unsupported
        }
        children = changedChildren
        let newChildren = children.map { $0.content }.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
        content = content.replacingOccurrences(of: oldChildren, with: newChildren)
        return oldContent
    }
    
    static func == (lhs: PBXGroup, rhs: PBXGroup) -> Bool {
        lhs.content == rhs.content
    }
}
