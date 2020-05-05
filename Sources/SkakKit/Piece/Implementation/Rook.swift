//
//  File.swift
//  
//
//  Created by Magnus Jensen on 11/08/2019.
//

import Foundation

struct Rook: SlidingPiece {
    
    let representation = "r"
    let color: Color
    
    func attacks(on board: Bitboard, with color: Color) -> Bitboard {
        return 0
    }
}
