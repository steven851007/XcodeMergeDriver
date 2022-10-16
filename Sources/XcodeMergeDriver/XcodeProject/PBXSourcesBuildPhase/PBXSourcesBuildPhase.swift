//
//  File.swift
//  
//
//  Created by Istvan Balogh on 16.10.22.
//

import Foundation

@available(macOS 10.15, *)
class PBXSourcesBuildPhase: Equatable {
    
    private(set) var content: String
    private(set) var files: [PBXGroupChildLine]
    
    var hasConflict: Bool {
        content.contains("<<<<<<<")
    }
    
    private let filesSeparator = Separator(begin: "files = (\n", end: ");\n")
    
    init(content: String) throws {
        self.content = content
        let files = self.content
            .sliceBetween(filesSeparator)?
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n") ?? []
        self.files = try files.map { try PBXGroupChildLine(content: $0) }
    }
    
    func difference(from base: PBXSourcesBuildPhase) -> CollectionDifference<PBXGroupChildLine> {
        let difference = files.difference(from: base.files) { $0 == $1 }
        return difference
    }
    
    @discardableResult
    func applying(_ difference: CollectionDifference<PBXGroupChildLine>) throws -> String {
        let oldContent = content
        let oldFiles = files.map { $0.content }.joined(separator: "\n")
        guard let changedFiles = files.applying(difference) else {
            throw MergeError.unsupported
        }
        files = changedFiles
        let newFiles = files.map { $0.content }.joined(separator: "\n")
        content = content.replacingOccurrences(of: oldFiles, with: newFiles)
        return oldContent
    }
    
    static func == (lhs: PBXSourcesBuildPhase, rhs: PBXSourcesBuildPhase) -> Bool {
        lhs.content == rhs.content
    }
}
