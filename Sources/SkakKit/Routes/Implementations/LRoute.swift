//
//  File.swift
//  
//
//  Created by Magnus Jensen on 28/06/2019.
//

import Foundation

struct LRoute: Route {
    func satisfies(move: Move) -> Bool {
        let dFile = abs(move.from.file.rawValue - move.to.file.rawValue)
        let dRank = abs(move.from.rank.rawValue - move.to.rank.rawValue)
        return dFile * dRank == 2
    }
}
