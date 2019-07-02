//
//  File.swift
//  
//
//  Created by Magnus Jensen on 27/06/2019.
//

import Foundation

struct Position {
    
    let file: File
    let rank: Rank
    
}

extension Position: Equatable { }
extension Position: Hashable { }
