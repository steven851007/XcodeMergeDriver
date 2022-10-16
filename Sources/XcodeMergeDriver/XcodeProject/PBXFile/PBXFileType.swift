//
//  PBXFileType.swift
//  
//
//  Created by Istvan Balogh on 16.10.22.
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

