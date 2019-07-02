//
//  Rook.swift
//  
//
//  Created by Magnus Jensen on 27/06/2019.
//

import Foundation

struct Rook: Piece {
    
    var representation = "r"
    var color: Color
    var routes = [Route]()
    
    func reachablePositions(from position: Position, on board: Board) -> [Position] {
        return []
    }
}
