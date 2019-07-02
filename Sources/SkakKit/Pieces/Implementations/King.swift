//
//  King.swift
//  
//
//  Created by Magnus Jensen on 27/06/2019.
//

import Foundation

struct King: Piece {
    
    var representation = "k"
    var color: Color
    var routes = [Route]()
    
    func reachablePositions(from position: Position, on board: Board) -> [Position] {
        return []
    }
}
