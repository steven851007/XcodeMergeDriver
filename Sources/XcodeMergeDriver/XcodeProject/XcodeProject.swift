//
//  File.swift
//  
//
//  Created by Istvan Balogh on 15.10.22.
//

import Foundation

struct Separator {
    let begin: String
    let end: String
}

@available(macOS 10.15, *)
class XcodeProject: Equatable {
    
    private(set) var content: String
    var pbxBuildFile: PBXFileSection
    var pbxfileReference: PBXFileSection
    var pbxGroupSection: PBXGroupSection
    var pbxSourcesBuildPhaseSection: PBXSourcesBuildPhaseSection
    var hasConflict: Bool {
        content.contains("<<<<<<<")
    }
    
    init(content: String) throws {
        self.content = content
        self.pbxBuildFile = try PBXFileSection(content: self.content, type: .build)
        self.pbxfileReference = try PBXFileSection(content: self.content, type: .reference)
        self.pbxGroupSection = try PBXGroupSection(content: self.content)
        self.pbxSourcesBuildPhaseSection = try PBXSourcesBuildPhaseSection(content: self.content)
    }
    
    func updatePbxBuildFileContent(with pbxBuildFile: PBXFileSection) {
        let PBXBuildFileContent = content.sliceBetween(PBXFileSection.buildFileSectionSeparator)!.trimmingCharacters(in: .whitespacesAndNewlines)
        content = content.replacingOccurrences(of: PBXBuildFileContent, with: pbxBuildFile.content)
    }
    
    func updatePbxFileReferenceContent(with pbxfileReference: PBXFileSection) {
        let PBXFileReferenceContent = content.sliceBetween(PBXFileSection.fileReferenceSectionSeparator)!.trimmingCharacters(in: .whitespacesAndNewlines)
        content = content.replacingOccurrences(of: PBXFileReferenceContent, with: pbxfileReference.content)
    }
    
    func updatePbxGroupSectionContent(with pbxGroupSection: PBXGroupSection) {
        let PBXGroupSectionContent = content.sliceBetween(PBXGroupSection.groupSectionSeparator)!.trimmingCharacters(in: .whitespacesAndNewlines)
        content = content.replacingOccurrences(of: PBXGroupSectionContent, with: pbxGroupSection.content)
    }
    
    func updatePbxSourcesBuildPhaseSectionContent(with pbxSourcesBuildPhaseSection: PBXSourcesBuildPhaseSection) {
        let PBXSourcesBuildPhaseSectionContent = content.sliceBetween(PBXSourcesBuildPhaseSection.sourcesBuildPhaseSeparator)!.trimmingCharacters(in: .whitespacesAndNewlines)
        content = content.replacingOccurrences(of: PBXSourcesBuildPhaseSectionContent, with: pbxSourcesBuildPhaseSection.content)
    }
    
    func mergeChanges(from base: XcodeProject, to other: XcodeProject, merged: () throws -> XcodeProject) throws {
        let merged = try merged()
        if merged.pbxBuildFile.hasConflict {
            let difference = other.pbxBuildFile.difference(from: base.pbxBuildFile)
            pbxBuildFile.applying(difference)
            merged.updatePbxBuildFileContent(with: pbxBuildFile)
        }
        
        if merged.pbxfileReference.hasConflict {
            let difference = other.pbxfileReference.difference(from: base.pbxfileReference)
            pbxfileReference.applying(difference)
            merged.updatePbxFileReferenceContent(with: pbxfileReference)
        }
        
        if merged.pbxGroupSection.hasConflict {
            try pbxGroupSection.mergeChanges(from: base.pbxGroupSection, to: other.pbxGroupSection, merged: merged.pbxGroupSection)
            merged.updatePbxGroupSectionContent(with: pbxGroupSection)
        }
        
        if merged.pbxSourcesBuildPhaseSection.hasConflict {
            try pbxSourcesBuildPhaseSection.mergeChanges(from: base.pbxSourcesBuildPhaseSection, to: other.pbxSourcesBuildPhaseSection, merged: merged.pbxSourcesBuildPhaseSection)
            merged.updatePbxSourcesBuildPhaseSectionContent(with: pbxSourcesBuildPhaseSection)
        }
        
        if merged.hasConflict {
            throw MergeError.unsupported // File still has conflicts
        }
        
        content = merged.content
    }
    
    static func == (lhs: XcodeProject, rhs: XcodeProject) -> Bool {
        lhs.content == rhs.content
    }
}


extension String {
    
    func sliceBetween(_ separator: Separator) -> Substring? {
        return (range(of: separator.begin)?.upperBound).flatMap { substringFrom in
            (range(of: separator.end, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                self[substringFrom..<substringTo]
            }
        }
    }
}
