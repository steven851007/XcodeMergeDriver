//
//  PBXGroupChildLine.swift
//  
//
//  Created by Istvan Balogh on 15.10.22.
//

import Foundation

class PBXGroupChildLine: Equatable {
    let content: String
    let comparableValue: String?
    
    init(content: String?) throws {
        guard let content else { throw MergeError.parsingError }
        self.content = content
        self.comparableValue = content.slice(from: " /* ", to: " */,")
    }
    
    static func == (lhs: PBXGroupChildLine, rhs: PBXGroupChildLine) -> Bool {
        lhs.comparableValue == rhs.comparableValue
    }
}

