//
//  PieceMechanics.swift
//  
//
//  Created by Magnus Jensen on 06/05/2020.
//

protocol PieceMechanics {
    func attacks(on board: Bitboard, as color: Color) -> Bitboard
}
