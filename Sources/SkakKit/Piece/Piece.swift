//
//  BBPiece.swift
//  
//
//  Created by Magnus Jensen on 04/07/2019.
//

protocol Piece {
    
    var representation: String { get }
    var color: Color { get }
    
    func attacks(on board: Bitboard,  with color: Color) -> Bitboard
}

extension Piece  {
    var description: String {
        get {
            switch color {
            case .black: return representation.lowercased()
            case .white: return representation.uppercased()
            }
        }
    }
}
