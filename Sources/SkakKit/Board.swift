//
//  File.swift
//  
//
//  Created by Magnus Jensen on 27/06/2019.
//

import Foundation

/// A board is a representation  of a game state, it does not contain any game logic and should be used visely
struct Board {
    
    private var bitboards: [Piece: Bitboard] = [
        .whitePawn: 0xFF00,
        .blackPawn: 0xFF000000000000,
        
        .whiteRook: 0x81,
        .blackRook: 0x8100000000000000,
        
        .whiteKnight: 0x42,
        .blackKnight: 0x4200000000000000,
        
        .whiteBishop: 0x24,
        .blackBishop: 0x2400000000000000,
        
        .whiteQueen: 0x10,
        .blackQueen: 0x1000000000000000,
        
        .whiteKing: 0x8,
        .blackKing: 0x800000000000000
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
        .map(\.key)
        .first
    }
    
    internal mutating func clear(at position: Position) {
        for key in bitboards.keys {
            bitboards[key]?.clear(position)
        }
    }
    
    internal mutating func place(piece: Piece, at position: Position) {
        bitboards[piece]?.mark(position)
    }
    
    internal mutating func place(piece: PieceIdentifier, as color: Color, at position: Position) {
        if let key = key(of: piece, as: color) {
            place(piece: key, at: position)
        }
    }
    
    internal mutating func key(of identifier: PieceIdentifier, as color: Color) -> Piece? {
        bitboards.keys.filter {
            $0.identifier == identifier && $0.color == color
        }
        .first
    }
    
    var ascii: String {
        var board = String()
        
        for rank in Rank.allCases.reversed() {
            for file in File.allCases {
                let position = Position(file: file, rank: rank)
                let representation = bitboards
                    .filter { $0.value.occupied(at: position) }
                    .map(\.key.representation)
                    .first ?? " "
                
                board += representation
            }
            board += "\n"
        }
        
        return board
    }
    
}
