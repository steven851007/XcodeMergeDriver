//
//  File.swift
//  
//
//  Created by Istvan Balogh on 15.10.22.
//

import Foundation

struct XcodeProject {
    
    let content: String
    let pbxBuildFile: PBXBuildFile
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
}

struct PBXBuildFile {
    
    let content: String
    let lines: [PBXBuildFileLine]
    var hasConflict: Bool {
        content.contains("<<<<<<<")
    }
    
    init(content: String?) throws {
        guard let content else {
            throw PBXBuildFileError.missingContent
        }
        self.content = content
        self.lines = content.split(separator: "\n").map { PBXBuildFileLine(lineString: String($0)) }
    }
}

struct PBXBuildFileLine {
    
    let lineString: String
    
    init(lineString: String) {
        self.lineString = lineString
    }
}


enum PBXBuildFileError: Error {
    case missingContent
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
