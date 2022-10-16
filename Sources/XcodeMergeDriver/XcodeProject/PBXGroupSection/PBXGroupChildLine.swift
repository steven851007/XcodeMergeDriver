//
//  PBXGroupChildLine.swift
//  
//
//  Created by Istvan Balogh on 15.10.22.
//

import Foundation

class PBXGroupChildLine: Equatable {
    let content: String
    let fileName: String
    private let nameSeparator = Separator(begin: " /* ", end: " */,")
    
    init(content: String?) throws {
        guard let content else { throw MergeError.parsingError }
        self.content = content
        self.fileName = String(content.sliceBetween(nameSeparator) ?? "")
    }
    
    static func == (lhs: PBXGroupChildLine, rhs: PBXGroupChildLine) -> Bool {
        lhs.fileName == rhs.fileName
    }
}

