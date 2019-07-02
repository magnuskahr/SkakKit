//
//  File.swift
//  
//
//  Created by Magnus Jensen on 27/06/2019.
//

import Foundation

/// A board is a representation  of a game state, i does not contain any game logic and should be used visely
struct Board {
    
    private var pieces: [Position: Piece]
    
    init(with builder: BoardBuilder = StandartBoardBuilder()) {
        pieces = builder.construct()
    }
    
    mutating func perform(move: Move) -> Bool {
        
        guard let piece = piece(at: move.from) else {
            return false
        }
        
        clear(at: move.from)
        place(piece: piece, at: move.to)
        
        return true
    }
    
    func piece(at position: Position) -> Piece? {
        return pieces[position]
    }
    
    internal mutating func clear(at position: Position) {
        pieces[position] = nil
    }
    
    internal mutating func place(piece: Piece, at position: Position) {
        pieces[position] = piece
    }
    
}
