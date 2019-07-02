//
//  Route.swift
//  
//
//  Created by Magnus Jensen on 27/06/2019.
//

import Foundation

protocol Route {
    func satisfies(move: Move) -> Bool
}
