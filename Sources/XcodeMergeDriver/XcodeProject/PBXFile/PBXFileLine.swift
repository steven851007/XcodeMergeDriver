//
//  PBXFileLine.swift
//  
//
//  Created by Istvan Balogh on 15.10.22.
//

import Foundation

struct PBXFileLine: Equatable, Hashable {
    
    let lineString: String
    
    init(lineString: String) {
        self.lineString = lineString
    }
}
