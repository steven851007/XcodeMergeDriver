//
//  File.swift
//  
//
//  Created by Istvan Balogh on 15.10.22.
//

import Foundation

@available(macOS 10.15, *)
struct PBXBuildFile {
    
    let content: String
    private(set) var lines: [PBXBuildFileLine]
    var hasConflict: Bool {
        content.contains("<<<<<<<")
    }
    
    func difference(from base: PBXBuildFile) -> CollectionDifference<PBXBuildFileLine> {
        let difference =  lines.difference(from: base.lines) { $0 == $1 }
        return difference
    }
    
    mutating func applying(_ difference: CollectionDifference<PBXBuildFileLine>) throws {
        guard let changedLines =  lines.applying(difference) else {
            throw MergeError.unsupported
        }
        lines = changedLines
    }
    
    init(content: String?) throws {
        guard let content else {
            throw PBXBuildFileError.missingContent
        }
        self.content = content
        self.lines = content.split(separator: "\n").map { PBXBuildFileLine(lineString: String($0)) }
    }
}


struct PBXBuildFileLine: Equatable {
    
    let lineString: String
    private let comparableValue: String?
    
    init(lineString: String) {
        self.lineString = lineString
        self.comparableValue = lineString.slice(from: " /* ", to: " in ")
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.comparableValue == rhs.comparableValue
    }
}


enum PBXBuildFileError: Error {
    case missingContent
}
