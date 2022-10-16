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
    private let childrenSeparator = Separator(begin: "children = (\n", end: ");\n")
    private let nameSeparator = Separator(begin: " /* ", end: " */ = {")
    
    init(content: String) throws {
        self.content = content
        let children = self.content
            .sliceBetween(childrenSeparator)?
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n") ?? []
        self.children = try children.map { try PBXGroupChildLine(content: $0) }
        self.name = String(self.content.sliceBetween(nameSeparator) ?? "")
    }
    
    func difference(from base: PBXGroup) -> CollectionDifference<PBXGroupChildLine> {
        let difference = children.difference(from: base.children) { $0 == $1 }
        return difference
    }

    @discardableResult
    func applying(_ difference: CollectionDifference<PBXGroupChildLine>) -> String {
        let oldContent = content
        let oldChildren = children.map { $0.content }.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
        difference.forEach { change in
            switch change {
              case let .remove(_, element, _):
                if let index = children.firstIndex(of: element) {
                    children.remove(at: index)
                }
              case let .insert(offset, newElement, _):
                children.insert(newElement, at: offset)
              }
        }
        let newChildren = children.map { $0.content }.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
        content = content.replacingOccurrences(of: oldChildren, with: newChildren)
        return oldContent
    }
    
    static func == (lhs: PBXGroup, rhs: PBXGroup) -> Bool {
        lhs.content == rhs.content
    }
}
