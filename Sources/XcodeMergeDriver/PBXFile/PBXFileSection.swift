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
    
    func difference(from base: PBXFileSection) -> CollectionDifference<PBXFileLine> {
        let difference = lines.difference(from: base.lines) { $0 == $1 }
        return difference
    }
    
    @discardableResult
    mutating func applying(_ difference: CollectionDifference<PBXFileLine>) throws -> String {
        guard let changedLines = lines.applying(difference) else {
            throw MergeError.unsupported
        }
        let oldContent = content
        lines = changedLines
        content = lines.map { $0.lineString }.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
        return oldContent
    }
    
    init(content: String?, type: PBXFileType) throws {
        guard let content else {
            throw MergeError.parsingError
        }
        self.content = content.trimmingCharacters(in: .whitespacesAndNewlines)
        self.lines = self.content.split(separator: "\n").map { PBXFileLine(lineString: String($0), type: type) }
    }
}
