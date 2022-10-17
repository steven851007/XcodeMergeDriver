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
    private(set) var files: [String]
    
    var hasConflict: Bool {
        content.contains("<<<<<<<")
    }
    
    private let filesSeparator = Separator(begin: "files = (\n", end: ");\n")
    
    init(content: String) throws {
        self.content = content
        self.files = self.content
            .sliceBetween(filesSeparator)?
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n") ?? []
    }
    
    func difference(from base: PBXSourcesBuildPhase) -> CollectionDifference<String> {
        let difference = files.difference(from: base.files) { $0 == $1 }
        return difference
    }
    
    @discardableResult
    func applying(_ difference: CollectionDifference<String>) -> String {
        let oldContent = content
        let oldFiles = files.map { $0 }.joined(separator: "\n")
        files = files.equalityApplying(difference)
        let newFiles = files.map { $0 }.joined(separator: "\n")
        content = content.replacingOccurrences(of: oldFiles, with: newFiles)
        return oldContent
    }
    
    static func == (lhs: PBXSourcesBuildPhase, rhs: PBXSourcesBuildPhase) -> Bool {
        lhs.content == rhs.content
    }
}
