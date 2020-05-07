//
//  File.swift
//  
//
//  Created by Magnus Jensen on 04/07/2019.
//

import Foundation

struct PawnMechanics: PieceMechanics {
    
    func attacks(on board: Bitboard, as color: Color) -> Bitboard {
        switch color {
        case .black: return attacksDown(on: board)
        case .white: return attacksUp(on: board)
        }
    }
    
    internal func attacksUp(on board: Bitboard) -> Bitboard {
        let rightAttack = board << 9 & ~Bitboard.Masks.fileA
        let leftAttack = board << 7 & ~Bitboard.Masks.fileH
        
        return leftAttack | rightAttack
    }
    
    internal func attacksDown(on board: Bitboard) -> Bitboard {
        let rightAttack = board >> 9 & ~Bitboard.Masks.fileH
        let leftAttack = board >> 7 & ~Bitboard.Masks.fileA
        
        return leftAttack | rightAttack
    }
    
}

extension PawnMechanics: Promoteable {
    var promotions: [PieceIdentifier] {
        [.rook, .bishop, .knight, .queen]
    }
}
