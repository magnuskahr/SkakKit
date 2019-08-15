//
//  File.swift
//  
//
//  Created by Magnus Jensen on 11/08/2019.
//

import Foundation

struct Rook: SlidingPiece {
    
    var representation = "r"
    var color: Color
    
    func attacks(on board: Bitboard, with color: Color) -> Bitboard {
        return 0
    }
}
