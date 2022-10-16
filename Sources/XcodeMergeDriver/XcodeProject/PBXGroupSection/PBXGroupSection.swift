//
//  PBXGroupSection.swift
//  
//
//  Created by Istvan Balogh on 15.10.22.
//

import Foundation

@available(macOS 10.15, *)
class PBXGroupSection: Equatable {
    
    static let groupSectionSeparator = Separator(begin: "/* Begin PBXGroup section */", end: "/* End PBXGroup section */")
    
    private(set) var content: String
    private(set) var groups: [PBXGroup]
    
    var hasConflict: Bool {
        content.contains("<<<<<<<")
    }
    
    init(content: String?) throws {
        guard let content = content?.sliceBetween(PBXGroupSection.groupSectionSeparator)?.trimmingCharacters(in: .whitespacesAndNewlines) else { throw MergeError.parsingError }
        self.content = content
        self.groups = try self.content
            .components(separatedBy: "};")
            .filter { !$0.isEmpty }
            .map { try PBXGroup(content: $0) }
    }
    
    func applyGroupDifference(_ difference: CollectionDifference<PBXGroup>) throws -> [PBXGroup] {
        guard let compbinedGroups = groups.applying(difference) else {
            throw MergeError.unsupported
        }
        
        content = compbinedGroups.map { $0.content }.joined(separator: "};").appending("};")
        return compbinedGroups
    }
    
    func mergeChanges(from base: PBXGroupSection, to other: PBXGroupSection, merged: PBXGroupSection) throws {
        let difference = other.groups.difference(from: base.groups) { $0.name == $1.name }
        let compbinedGroups = try applyGroupDifference(difference)
        
        compbinedGroups.forEach { conflictGroup in
            if
               let sameBaseGroup = base.groupWithName(conflictGroup.name),
               let sameOtherGroup = other.groupWithName(conflictGroup.name),
               let sameCurrentGroup = groupWithName(conflictGroup.name)
            {
                let difference = sameOtherGroup.difference(from: sameBaseGroup)
                if !difference.isEmpty {
                    let oldGroupContent = sameCurrentGroup.applying(difference)
                    content = content.replacingOccurrences(of: oldGroupContent, with: sameCurrentGroup.content)
                }
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
