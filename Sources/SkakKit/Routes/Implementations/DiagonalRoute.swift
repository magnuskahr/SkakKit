//
//  DiagonalRoute.swift
//  
//
//  Created by Magnus Jensen on 27/06/2019.
//

import Foundation

struct DiagonalRoute: Route {
    func satisfies(move: Move) -> Bool {
        move.isDiagonal
    }
}
