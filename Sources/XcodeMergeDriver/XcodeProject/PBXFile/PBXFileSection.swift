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
    private(set) var lines: [PBXFileLine]
    var hasConflict: Bool {
        content.contains("<<<<<<<")
    }
    
    init(content: String?, type: PBXFileType) throws {
        guard let content = content?.sliceBetween(Self.separator(for: type)) else {
            throw MergeError.parsingError
        }
        self.content = content.trimmingCharacters(in: .whitespacesAndNewlines)
        self.lines = self.content.split(separator: "\n").map { PBXFileLine(lineString: String($0)) }
    }
    
    func difference(from base: PBXFileSection) -> CollectionDifference<PBXFileLine> {
        let difference = lines.difference(from: base.lines) { $0 == $1 }
        return difference
    }
    
    mutating func applying(_ difference: CollectionDifference<PBXFileLine>) {
        difference.forEach { change in
            switch change {
              case let .remove(_, element, _):
                if let index = lines.firstIndex(of: element) {
                    lines.remove(at: index)
                }
              case let .insert(offset, newElement, _):
                let index = offset > lines.endIndex ? lines.endIndex : offset
                lines.insert(newElement, at: index)
              }
        }
        content = lines.map { $0.lineString }.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        Set(lhs.lines).symmetricDifference(Set(rhs.lines)).isEmpty
    }
}
