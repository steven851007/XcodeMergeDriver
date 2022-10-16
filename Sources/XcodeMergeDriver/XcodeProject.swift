//
//  File.swift
//  
//
//  Created by Istvan Balogh on 15.10.22.
//

import Foundation

@available(macOS 10.15, *)
class XcodeProject: Equatable {
    
    private(set) var content: String
    var pbxBuildFile: PBXFileSection
    var pbxfileReference: PBXFileSection
    var pbxGroupSection: PBXGroupSection
    var hasConflict: Bool {
        content.contains("<<<<<<<")
    }
    
    private let PBXBuildFileSectionSeparator = (begin: "/* Begin PBXBuildFile section */", end: "/* End PBXBuildFile section */")
    private let PBXFileReferenceSectionSeparator = (begin: "/* Begin PBXFileReference section */", end: "/* End PBXFileReference section */")
    private let PBXGroupSectionSeparator = (begin: "/* Begin PBXGroup section */", end: "/* End PBXGroup section */")
    
    init(content: String) throws {
        self.content = content
        let PBXBuildFileContent = content.slice(from: PBXBuildFileSectionSeparator.begin, to: PBXBuildFileSectionSeparator.end)?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.pbxBuildFile = try PBXFileSection(content: PBXBuildFileContent, type: .build)
        let PBXFileReferenceContent = content.slice(from: PBXFileReferenceSectionSeparator.begin, to: PBXFileReferenceSectionSeparator.end)?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.pbxfileReference = try PBXFileSection(content: PBXFileReferenceContent, type: .reference)
        let PBXGroupSectionContent = content.slice(from: PBXGroupSectionSeparator.begin, to: PBXGroupSectionSeparator.end)?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.pbxGroupSection = try PBXGroupSection(content: PBXGroupSectionContent)
    }
    
    func updatePbxBuildFileContent(with pbxBuildFile: PBXFileSection) {
        let PBXBuildFileContent = content.slice(from: PBXBuildFileSectionSeparator.begin, to: PBXBuildFileSectionSeparator.end)!.trimmingCharacters(in: .whitespacesAndNewlines)
        content = content.replacingOccurrences(of: PBXBuildFileContent, with: pbxBuildFile.content)
    }
    
    func updatePbxFileReferenceContent(with pbxfileReference: PBXFileSection) {
        let PBXFileReferenceContent = content.slice(from: PBXFileReferenceSectionSeparator.begin, to: PBXFileReferenceSectionSeparator.end)!.trimmingCharacters(in: .whitespacesAndNewlines)
        content = content.replacingOccurrences(of: PBXFileReferenceContent, with: pbxfileReference.content)
    }
    
    func updatePbxGroupSectionContent(with pbxGroupSection: PBXGroupSection) {
        let PBXGroupSectionContent = content.slice(from: PBXGroupSectionSeparator.begin, to: PBXGroupSectionSeparator.end)!.trimmingCharacters(in: .whitespacesAndNewlines)
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
    
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
