//
//  BBPiece.swift
//  
//
//  Created by Magnus Jensen on 04/07/2019.
//

protocol BBPiece {
    func attacks(on board: Bitboard,  with color: Color) -> Bitboard
}
