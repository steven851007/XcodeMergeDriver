//
//  File.swift
//  
//
//  Created by Istvan Balogh on 16.10.22.
//

import Foundation

@available(macOS 10.15, *)
class PBXSourcesBuildPhaseSection: Equatable {
    
    static let sourcesBuildPhaseSeparator = Separator(begin: "/* Begin PBXSourcesBuildPhase section */\n", end: "\n/* End PBXSourcesBuildPhase section */")
    
    private(set) var content: String
    let buildPhases: [PBXSourcesBuildPhase]
    
    var hasConflict: Bool {
        content.contains("<<<<<<<")
    }
    
    init(content: String?) throws {
        guard let content = content?.sliceBetween(Self.sourcesBuildPhaseSeparator)?.trimmingCharacters(in: .whitespacesAndNewlines) else { throw MergeError.parsingError }
        self.content = content
        self.buildPhases = try self.content.components(separatedBy: "};\n").map { try PBXSourcesBuildPhase(content: $0) }
    }
    
    func mergeChanges(from base: PBXSourcesBuildPhaseSection, to other: PBXSourcesBuildPhaseSection, merged: PBXSourcesBuildPhaseSection) throws {
        try merged.buildPhases.enumerated().forEach { conflictGroupSequence in
            if conflictGroupSequence.element.hasConflict {
                let sameBaseGroup = base.buildPhases[conflictGroupSequence.offset]
                let sameOtherGroup = other.buildPhases[conflictGroupSequence.offset]
                let sameCurrentGroup = buildPhases[conflictGroupSequence.offset]
                let difference = sameOtherGroup.difference(from: sameBaseGroup)
                let oldGroupContent = try sameCurrentGroup.applying(difference)
                content = content.replacingOccurrences(of: oldGroupContent, with: sameCurrentGroup.content)
            }
        }
    }
    
    static func == (lhs: PBXSourcesBuildPhaseSection, rhs: PBXSourcesBuildPhaseSection) -> Bool {
        lhs.content == rhs.content
    }
}
