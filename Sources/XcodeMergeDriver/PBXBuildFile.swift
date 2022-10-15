//
//  File.swift
//  
//
//  Created by Istvan Balogh on 15.10.22.
//

import Foundation

@available(macOS 10.15, *)
struct PBXBuildFile: Equatable {
    
    private(set) var content: String
    private(set) var lines: [PBXFileLine]
    var hasConflict: Bool {
        content.contains("<<<<<<<")
    }
    
    func difference(from base: PBXBuildFile) -> CollectionDifference<PBXFileLine> {
        let difference =  lines.difference(from: base.lines) { $0 == $1 }
        return difference
    }
    
    @discardableResult
    mutating func applying(_ difference: CollectionDifference<PBXFileLine>) throws -> String {
        guard let changedLines =  lines.applying(difference) else {
            throw MergeError.unsupported
        }
        let oldContent = content
        lines = changedLines
        content = lines.map { $0.lineString }.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
        return oldContent
    }
    
    init(content: String?, type: PBXFileType) throws {
        guard let content else {
            throw PBXBuildFileError.missingContent
        }
        self.content = content.trimmingCharacters(in: .whitespacesAndNewlines)
        self.lines = content.split(separator: "\n").map { PBXFileLine(lineString: String($0), type: type) }
    }
}

enum PBXFileType {
    case build, reference
    
    var valueSeparator: (begin: String, end: String) {
        switch self {
        case .build:
            return (begin: " /* ", end: " in ")
        case .reference:
            return (begin: " /* ", end: " */ ")
        }
    }
}

struct PBXFileLine: Equatable {
    
    let lineString: String
    let comparableValue: String?
    
    init(lineString: String, type: PBXFileType = .build) {
        self.lineString = lineString
        self.comparableValue = lineString.slice(from: type.valueSeparator.begin, to: type.valueSeparator.end)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.comparableValue == rhs.comparableValue
    }
}


enum PBXBuildFileError: Error {
    case missingContent
}
