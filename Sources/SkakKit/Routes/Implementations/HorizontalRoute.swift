//
//  File.swift
//  
//
//  Created by Magnus Jensen on 28/06/2019.
//

import Foundation

struct HorizontalRoute: Route {
    func satisfies(move: Move) -> Bool {
        move.isHorizontal
    }
}
