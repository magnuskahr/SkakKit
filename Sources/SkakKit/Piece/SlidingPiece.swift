//
//  File.swift
//  
//
//  Created by Magnus Jensen on 11/08/2019.
//

protocol SlidingPiece: Piece { }

extension SlidingPiece {
    /// Returns a bitboard with the possible slidings to the right from a isolated bitboard. If the provided isolation does not represent a isolated piece, nil will be returned.
    func rightSlidings(on board: Bitboard, from isolated: Bitboard) -> Bitboard? {
        guard isolated.pieceCount == 1 else {
            return nil
        }
        
        let occupiens = board & ~Bitboard(rawValue: isolated.rawValue * 2)
        let attack = board ^ occupiens
        
        return attack
    }
    
    func rankAttacks(occupied: Bitboard, attackers: Bitboard, mask: Bitboard) -> Bitboard {
        let left = hyperbola(occupied: occupied, attackers: attackers, mask: Bitboard.Masks.fileA)
        let right = hyperbola(occupied: occupied, attackers: attackers, mask: Bitboard.Masks.fileA)
        return left | right
    }
    
    func fileAttacks(occupied: Bitboard, attackers: Bitboard, mask: Bitboard) -> Bitboard {
        return 0
    }
    
    func diagonalAttacks(occupied: Bitboard, attackers: Bitboard, mask: Bitboard) -> Bitboard {
        let isolated = attackers.isolatedPieces()
        return 0
    }
    
    /// https://www.chessprogramming.org/Hyperbola_Quintessence#Generalized_Set-wise_Attacks
    /// const u64 right = 0x0101010101010101ULL;
    /// u64 leftAttacks = ((o ^ ((o | right) - 2*r) & ~right);
    func hyperbola(occupied: Bitboard, attackers: Bitboard, mask: Bitboard) -> Bitboard {
        let upto = attackers << 1
        let overflowProtectedBoard = occupied | mask
        let gapfilled = overflowProtectedBoard.rawValue - upto.rawValue
        let attack = (occupied ^ Bitboard(rawValue: gapfilled)) & ~mask
        return attack
    }
}
