//
//  Game.swift
//  
//
//  Created by Magnus Jensen on 28/06/2019.
//

import Foundation

/// Game contains all logic
struct Game {
    
    private(set) var playerInTurn: Color = .white
    let board: Board

    func perform(move: Move, promoter: Promoter? = nil) -> Result<Void, MoveError> {
        
        guard let piece = board.piece(at: move.from) else {
            return .failure(.empty)
        }
        
        guard piece.color == playerInTurn else {
            return .failure(.wrongColor)
        }
        
        guard attackability(of: move.to) else {
            return .failure(.illegal)
        }
        
//        guard piece.allows(move: move, on: board) else {
//            return .failure(.illegal)
//        }
        
//        if let promotable = piece as? Promoteable,
//            shouldPromote(candidate: piece, on: move.to),
//            let promoter = promoter {
//
//            let promotions = promotable.promotions()
//            let promotion = promoter.choose(between: promotions)
//        }
        
        return .success(())
    }
    
    /// Decides whether a piece is able to be promoted or not.
    /// A white piece can be promoted at rank 8, and a white piece can be promoted at rank 1.
    /// A piece can be promoted if it is promotable. In chess, only the pawn is promotable.
    /// - Parameter candidate: the candidate to promote
    /// - Parameter destination: the destination to promote on
    internal func shouldPromote(candidate: Piece, on destination: Position) -> Bool {
        guard candidate is Promoteable else {
            return false
        }
        
        switch candidate.color {
        case .black: return destination.rank == .one
        case .white: return destination.rank == .eight
        }
    }
    
    /// Check the attackability of a position.
    /// A position is attackable, if its either free or occupied by the other player
    /// - Parameter position: position to check attackability for
    internal func attackability(of position: Position) -> Bool {
        guard let piece = board.piece(at: position) else {
            return true
        }
        
        return piece.color != playerInTurn
    }
}

extension Game {
    enum MoveError: Error {
        case empty
        case wrongColor
        case illegal
    }
}
