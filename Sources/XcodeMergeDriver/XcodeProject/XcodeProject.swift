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
    var hasConflict: Bool {
        content.contains("<<<<<<<")
    }
    
    init(content: String) throws {
        self.content = content
        self.pbxBuildFile = try PBXFileSection(content: self.content, type: .build)
        self.pbxfileReference = try PBXFileSection(content: self.content, type: .reference)
        self.pbxGroupSection = try PBXGroupSection(content: self.content)
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
    
    func mergeChanges(from base: XcodeProject, to other: XcodeProject, merged: () throws -> XcodeProject) throws {
        let merged = try merged()
        if merged.pbxBuildFile.hasConflict {
            let difference = other.pbxBuildFile.difference(from: base.pbxBuildFile)
            try pbxBuildFile.applying(difference)
            updatePbxBuildFileContent(with: pbxBuildFile)
            merged.updatePbxBuildFileContent(with: pbxBuildFile)
        }
        
        if merged.pbxfileReference.hasConflict {
            let difference = other.pbxfileReference.difference(from: base.pbxfileReference)
            try pbxfileReference.applying(difference)
            updatePbxFileReferenceContent(with: pbxfileReference)
            merged.updatePbxFileReferenceContent(with: pbxfileReference)
        }
        
        if merged.pbxGroupSection.hasConflict {
            try pbxGroupSection.mergeChanges(from: base.pbxGroupSection, to: other.pbxGroupSection, merged: merged.pbxGroupSection)
            updatePbxGroupSectionContent(with: pbxGroupSection)
            merged.updatePbxGroupSectionContent(with: pbxGroupSection)
        }
        
        if merged.hasConflict {
            throw MergeError.unsupported // File still has conflicts
        }
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
