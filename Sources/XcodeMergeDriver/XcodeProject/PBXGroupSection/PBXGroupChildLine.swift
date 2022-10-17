//
//  PBXGroupChildLine.swift
//  
//
//  Created by Istvan Balogh on 15.10.22.
//

import Foundation

class PBXGroupChildLine: Equatable, Hashable {
    let content: String
    
    init(content: String?) throws {
        guard let content else { throw MergeError.parsingError }
        self.content = content
    }
    
    static func == (lhs: PBXGroupChildLine, rhs: PBXGroupChildLine) -> Bool {
        lhs.content == rhs.content
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(content)
    }
}

