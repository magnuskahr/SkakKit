//
//  BBKing.swift
//  
//
//  Created by Magnus Jensen on 04/07/2019.
//

import Foundation

struct King: Piece {
    
    let representation = "k"
    let color: Color
    
    /// We denote the attacks by the king as following:
    /// 1   2   3
    /// 8   K   4
    /// 7   6   5
    
    func attacks(on board: Bitboard, with color: Color) -> Bitboard {
        return 0
    }
    
    internal func spots(on board: Bitboard) -> Bitboard {
        
        let spot1 = board << 7 & ~Bitboard.Masks.fileH
        let spot2 = board << 8
        let spot3 = board << 9 & ~Bitboard.Masks.fileA
        let spot4 = board << 1 & ~Bitboard.Masks.fileA
        
        let spot5 = board >> 7 & ~Bitboard.Masks.fileA
        let spot6 = board >> 8
        let spot7 = board >> 9 & ~Bitboard.Masks.fileH
        let spot8 = board >> 1 & ~Bitboard.Masks.fileH
        
        return spot1 | spot2 | spot3 | spot4 | spot5 | spot6 | spot7 | spot8
        
    }
}
