//
//  File.swift
//  
//
//  Created by Magnus Jensen on 27/06/2019.
//

import Foundation

public struct Position {
    let file: File
    let rank: Rank
    
    public init(file: File, rank: Rank) {
        self.file = file
        self.rank = rank
    }
}

extension Position: Equatable { }
extension Position: Hashable { }
