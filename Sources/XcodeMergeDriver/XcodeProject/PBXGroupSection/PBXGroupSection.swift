//
//  PBXGroupSection.swift
//  
//
//  Created by Istvan Balogh on 15.10.22.
//

import Foundation

@available(macOS 10.15, *)
class PBXGroupSection: Equatable {
    private(set) var content: String
    private(set) var groups: [PBXGroup]
    
    var hasConflict: Bool {
        content.contains("<<<<<<<")
    }
    
    init(content: String?) throws {
        guard let content else { throw MergeError.parsingError }
        self.content = content.trimmingCharacters(in: .whitespacesAndNewlines)
        self.groups = try self.content.components(separatedBy: "};\n").map { try PBXGroup(content: $0) }
    }
    
    func mergeChanges(from base: PBXGroupSection, to other: PBXGroupSection, merged: PBXGroupSection) throws {
        try merged.groups.forEach { conflictGroup in
            if conflictGroup.hasConflict,
               let sameBaseGroup = base.groupWithName(conflictGroup.name),
               let sameOtherGroup = other.groupWithName(conflictGroup.name),
               let sameCurrentGroup = groupWithName(conflictGroup.name)
            {
                let difference = sameOtherGroup.difference(from: sameBaseGroup)
                let oldGroupContent = try sameCurrentGroup.applying(difference)
                content = content.replacingOccurrences(of: oldGroupContent, with: sameCurrentGroup.content)
            }
        }
    }
    
    func groupWithName(_ name: String) -> PBXGroup? {
        groups.first { $0.name == name }
    }
    
    static func == (lhs: PBXGroupSection, rhs: PBXGroupSection) -> Bool {
        lhs.content == rhs.content
    }
}
