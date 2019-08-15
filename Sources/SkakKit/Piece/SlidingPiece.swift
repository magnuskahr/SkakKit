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
}
