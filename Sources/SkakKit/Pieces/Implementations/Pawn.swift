//
//  Pawn.swift
//  
//
//  Created by Magnus Jensen on 27/06/2019.
//

import Foundation

struct Pawn: Piece {
    
    var routes: [Route] = [
        VerticalRoute(),
        DiagonalRoute()
    ]
    
    var representation = "p"
    var color: Color
    
    func reachablePositions(from position: Position, on board: Board) -> [Position] {
        return []
    }
    
    func allows(move: Move, on board: Board) -> Bool {
        return move.isVertical
    }
    
}

extension Pawn: Promoteable {
    func promotions() -> [Piece] {
        return [
            Queen(color: color),
            Bishop(color: color),
            Knight(color: color),
            Rook(color: color)
        ]
    }
}
