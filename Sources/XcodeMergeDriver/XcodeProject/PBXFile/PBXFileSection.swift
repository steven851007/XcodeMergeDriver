//
//  File.swift
//  
//
//  Created by Istvan Balogh on 15.10.22.
//

import Foundation

@available(macOS 10.15, *)
struct PBXFileSection: Equatable {
    
    static let buildFileSectionSeparator = Separator(begin: "/* Begin PBXBuildFile section */", end: "/* End PBXBuildFile section */")
    static let fileReferenceSectionSeparator = Separator(begin: "/* Begin PBXFileReference section */", end: "/* End PBXFileReference section */")
    static func separator(for type: PBXFileType) -> Separator {
        switch type {
        case .build:
            return buildFileSectionSeparator
        case .reference:
            return fileReferenceSectionSeparator
        }
    }
    
    private(set) var content: String
    private(set) var lines: [String]
    var hasConflict: Bool {
        content.contains("<<<<<<<")
    }
    
    init(content: String?, type: PBXFileType) throws {
        guard let content = content?.sliceBetween(Self.separator(for: type)) else {
            throw MergeError.parsingError
        }
        self.content = content.trimmingCharacters(in: .newlines)
        self.lines = self.content.split(separator: "\n").map { String($0) }
    }
    
    mutating func applyingDifference(between base: PBXFileSection, other: PBXFileSection) {
        let difference = other.lines.difference(from: base.lines) { $0 == $1 }
        lines = lines.equalityApplying(difference).uniqued()
        content = lines.map { $0 }.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        Set(lhs.lines).symmetricDifference(Set(rhs.lines)).isEmpty
    }
}
