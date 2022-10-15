//
//  PBXFileLine.swift
//  
//
//  Created by Istvan Balogh on 15.10.22.
//

import Foundation

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
