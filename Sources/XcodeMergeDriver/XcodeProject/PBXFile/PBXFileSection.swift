//
//  File.swift
//  
//
//  Created by Istvan Balogh on 15.10.22.
//

import Foundation

@available(macOS 10.15, *)
struct PBXFileSection: Equatable {
    
    private(set) var content: String
    private(set) var lines: [PBXFileLine]
    var hasConflict: Bool {
        content.contains("<<<<<<<")
    }
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
    
    func difference(from base: PBXFileSection) -> CollectionDifference<PBXFileLine> {
        let difference = lines.difference(from: base.lines) { $0 == $1 }
        return difference
    }
    
    mutating func applying(_ difference: CollectionDifference<PBXFileLine>) throws{
        guard let changedLines = lines.applying(difference) else {
            throw MergeError.unsupported
        }
        lines = changedLines
        content = lines.map { $0.lineString }.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    init(content: String?, type: PBXFileType) throws {
        guard let content = content?.sliceBetween(Self.separator(for: type)) else {
            throw MergeError.parsingError
        }
        self.content = content.trimmingCharacters(in: .whitespacesAndNewlines)
        self.lines = self.content.split(separator: "\n").map { PBXFileLine(lineString: String($0), type: type) }
    }
}
