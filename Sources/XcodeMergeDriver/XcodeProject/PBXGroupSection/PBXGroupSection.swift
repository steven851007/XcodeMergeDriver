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
    
    func mergeChanges(from base: PBXGroupSection, to other: PBXGroupSection, merged: PBXGroupSection) throws {
        let allGroups = try applyGroupDifference(between: base, other: other)
        
        for group in allGroups {
            guard
                let baseGroup = base.groupMatching(group),
                let otherGroup = other.groupMatching(group),
                let currentGroup = groupMatching(group) else {
                continue
            }
            let oldGroupContent = currentGroup.content
            currentGroup.applyingDifference(between: baseGroup, other: otherGroup)
            content = content.replacingOccurrences(of: oldGroupContent, with: currentGroup.content)
        }
    }
    
    static func == (lhs: PBXGroupSection, rhs: PBXGroupSection) -> Bool {
        Set(lhs.groups).symmetricDifference(Set(rhs.groups)).isEmpty
    }
}

@available(macOS 10.15, *)
private extension PBXGroupSection {

    func applyGroupDifference(between base: PBXGroupSection, other: PBXGroupSection) throws -> [PBXGroup] {
        let difference = other.groups.difference(from: base.groups) { $0.name == $1.name && $0.identifier == $1.identifier }
        guard let compbinedGroups = groups.applying(difference) else {
            throw MergeError.unsupported
        }
        
        content = compbinedGroups.map { $0.content }.joined(separator: "};").appending("};")
        return compbinedGroups
    }
    
    func groupMatching(_ group: PBXGroup) -> PBXGroup? {
        groups.first { $0.identifier == group.identifier && $0.name == group.name }
    }
}
