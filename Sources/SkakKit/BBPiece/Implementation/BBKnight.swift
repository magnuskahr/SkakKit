//
//  BBKnight.swift
//  
//
//  Created by Magnus Jensen on 04/07/2019.
//

import Foundation

struct BBKnight: BBPiece {
    
    /// We denote the attacks by the knight as following:
    ///    2       3
    ///  1                4
    ///      K
    ///  8                5
    ///    7       6
    
    
    func attacks(on board: Bitboard, with color: Color) -> Bitboard {
        
        let maskAB = Bitboard.Masks.fileA | Bitboard.Masks.fileB
        let maskGH = Bitboard.Masks.fileG | Bitboard.Masks.fileH
        
        let spot1 = board << 6 & ~maskGH
        let spot2 = board << 15 & ~maskGH
        let spot3 = board << 17 & ~maskAB
        let spot4 = board << 10 & ~maskAB
        
        let spot5 = board >> 6 & ~maskAB
        let spot6 = board >> 15 & ~maskAB
        let spot7 = board >> 17 & ~maskGH
        let spot8 = board >> 10 & ~maskGH
        
        return spot1 | spot2 | spot3 | spot4 | spot5 | spot6 | spot7 | spot8
    }
}
