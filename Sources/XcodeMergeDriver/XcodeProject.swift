//
//  File.swift
//  
//
//  Created by Istvan Balogh on 15.10.22.
//

import Foundation

@available(macOS 10.15, *)
struct XcodeProject {
    
    let content: String
    var pbxBuildFile: PBXBuildFile
    var hasConflict: Bool {
        content.contains("<<<<<<<")
    }
    
    private let PBXBuildFileSectionSeparator = (begin: "/* Begin PBXBuildFile section */", end: "/* End PBXBuildFile section */")
    
    init(content: String) throws {
        self.content = content
        let PBXBuildFileContent = content.slice(from: PBXBuildFileSectionSeparator.begin, to: PBXBuildFileSectionSeparator.end)
        self.pbxBuildFile = try PBXBuildFile(content: PBXBuildFileContent)
        if content.contains("<<<<<<<") && !pbxBuildFile.hasConflict {
            throw MergeError.unsupported
        }
    }
    
    mutating func mergeChanges(from base: XcodeProject, to other: XcodeProject, merged: XcodeProject) throws {
        if merged.pbxBuildFile.hasConflict {
            let difference = other.pbxBuildFile.difference(from: base.pbxBuildFile)
            try pbxBuildFile.applying(difference)
        }
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
