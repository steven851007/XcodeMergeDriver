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
    private(set) var pbxBuildFile: PBXFileSection
    private(set) var pbxfileReference: PBXFileSection
    private(set) var pbxGroupSection: PBXGroupSection
    private(set) var pbxSourcesBuildPhaseSection: PBXSourcesBuildPhaseSection
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
    
    func mergeChanges(from base: XcodeProject, to other: XcodeProject, merged: () throws -> XcodeProject) throws -> Bool {
        let merged = try merged()
        if merged.pbxBuildFile.hasConflict {
            pbxBuildFile.applyingDifference(between: base.pbxBuildFile, other: other.pbxBuildFile)
            merged.updatePbxBuildFileContent(with: pbxBuildFile)
        }
        
        if merged.pbxfileReference.hasConflict {
            pbxfileReference.applyingDifference(between: base.pbxfileReference, other: other.pbxfileReference)
            merged.updatePbxFileReferenceContent(with: pbxfileReference)
        }
        
        if merged.pbxGroupSection.hasConflict {
            pbxGroupSection.mergeChanges(from: base.pbxGroupSection, to: other.pbxGroupSection, merged: merged.pbxGroupSection)
            merged.updatePbxGroupSectionContent(with: pbxGroupSection)
        }
        
        if merged.pbxSourcesBuildPhaseSection.hasConflict {
            try pbxSourcesBuildPhaseSection.mergeChanges(from: base.pbxSourcesBuildPhaseSection, to: other.pbxSourcesBuildPhaseSection, merged: merged.pbxSourcesBuildPhaseSection)
            merged.updatePbxSourcesBuildPhaseSectionContent(with: pbxSourcesBuildPhaseSection)
        }
        
        if merged.hasConflict {
            print("Resolved conflicts, but couldn't resolve all. Please check!")
        } else {
            print("All conflicts resolved")
        }
        
        content = merged.content
        return merged.hasConflict
    }
    
    static func == (lhs: XcodeProject, rhs: XcodeProject) -> Bool {
        lhs.content == rhs.content
    }
}

@available(macOS 10.15, *)
private extension XcodeProject {
    
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

@available(macOS 10.15, *)
extension Array where Element: Equatable {
 
    func equalityApplying(_ difference: CollectionDifference<Element>) -> Array<Element> {
        var array = self
        difference.forEach { change in
            switch change {
              case let .remove(_, element, _):
                if let index = array.firstIndex(of: element) {
                    array.remove(at: index)
                }
              case let .insert(offset, newElement, _):
                let index = offset > array.endIndex ? array.endIndex : offset
                array.insert(newElement, at: index)
              }
        }
        return array
    }
}
