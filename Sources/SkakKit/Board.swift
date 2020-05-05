//
//  File.swift
//  
//
//  Created by Magnus Jensen on 27/06/2019.
//

import Foundation

struct IdentifiedPiece: Hashable {
    
    let piece: Piece
    
    static func == (lhs: IdentifiedPiece, rhs: IdentifiedPiece) -> Bool {
        lhs.piece.identifier == rhs.piece.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(piece.color)
        hasher.combine(piece.representation)
    }
    
}

/// A board is a representation  of a game state, i does not contain any game logic and should be used visely
struct Board {
    
    private var bitboards: [IdentifiedPiece: Bitboard] = [
        IdentifiedPiece(piece: Pawn(color: .white)) : 0xFF00
    ]
    
    mutating func perform(move: Move) -> Bool {
        
        guard let piece = piece(at: move.from) else {
            return false
        }
        
        clear(at: move.from)
        place(piece: piece, at: move.to)
        
        return true
    }
    
    func piece(at position: Position) -> Piece? {
        bitboards.filter {
            $0.value.occupied(at: position)
        }
        .map(\.key.piece)
        .first
    }
    
    internal mutating func clear(at position: Position) {
        for key in bitboards.keys {
            bitboards[key]?.clear(position)
        }
    }
    
    internal mutating func place(piece: Piece, at position: Position) {
        let key = IdentifiedPiece(piece: piece)
        bitboards[key]?.mark(position)
    }
    
}
