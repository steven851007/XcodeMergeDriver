//
//  PBXFileLine.swift
//  
//
//  Created by Istvan Balogh on 15.10.22.
//

import Foundation

enum PBXFileType {
    case build, reference
    
    var valueSeparator: Separator {
        switch self {
        case .build:
            return Separator(begin: " /* ", end: " in ")
        case .reference:
            return Separator(begin: " /* ", end: " */ ")
        }
    }
}

struct PBXFileLine: Equatable {
    
    let lineString: String
    let comparableValue: String
    
    init(lineString: String, type: PBXFileType = .build) {
        self.lineString = lineString
        self.comparableValue = String(lineString.sliceBetween(type.valueSeparator) ?? "")
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.comparableValue == rhs.comparableValue
    }
}
