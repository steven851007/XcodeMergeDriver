//
//  File.swift
//  
//
//  Created by Istvan Balogh on 15.10.22.
//

import Foundation

@available(macOS 10.15, *)
struct XcodeProject: Equatable {
    
    private(set) var content: String
    var pbxBuildFile: PBXBuildFile
    var hasConflict: Bool {
        content.contains("<<<<<<<")
    }
    
    private let PBXBuildFileSectionSeparator = (begin: "/* Begin PBXBuildFile section */", end: "/* End PBXBuildFile section */")
    
    init(content: String) throws {
        self.content = content
        let PBXBuildFileContent = content.slice(from: PBXBuildFileSectionSeparator.begin, to: PBXBuildFileSectionSeparator.end)?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.pbxBuildFile = try PBXBuildFile(content: PBXBuildFileContent)
    }
    
    mutating func mergeChanges(from base: XcodeProject, to other: XcodeProject, merged: () throws -> XcodeProject) throws {
        var merged = try merged()
        if merged.pbxBuildFile.hasConflict {
            let difference = other.pbxBuildFile.difference(from: base.pbxBuildFile)
            let oldPbxContent = try pbxBuildFile.applying(difference)
            content = content.replacingOccurrences(of: oldPbxContent, with: pbxBuildFile.content)
            merged.pbxBuildFile = pbxBuildFile
        }
        
        if merged.hasConflict {
            throw MergeError.unsupported // File still has conflicts
        }
    }
    
    static func == (lhs: XcodeProject, rhs: XcodeProject) -> Bool {
        lhs.content == rhs.content && lhs.pbxBuildFile == rhs.pbxBuildFile
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
