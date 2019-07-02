//
//  File 2.swift
//  
//
//  Created by Magnus Jensen on 27/06/2019.
//

import Foundation

struct StandartBoardBuilder: BoardBuilder {
    func construct() -> [Position: Piece] {
        var pieces = [Position: Piece]()
        for position in zip(File.allCases, Rank.allCases).map(Position.init) {
            pieces[position] = Pawn(color: .white)
        }
        return pieces
    }
}
