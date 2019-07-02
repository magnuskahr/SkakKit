//
//  File.swift
//  
//
//  Created by Magnus Jensen on 27/06/2019.
//

import Foundation

protocol Piece: CustomStringConvertible {
    
    var routes: [Route] { get }
    var representation: String { get }
    var color: Color { get }
    
    func reachablePositions(from position: Position, on board: Board) -> [Position]
    func allows(move: Move, on board: Board) -> Bool
    
}

extension Piece {
    
    /// Default implementation, overwrite if move and attacking doesnt follow same strategies
    func allows(move: Move, on board: Board) -> Bool {
        return routes.contains { $0.satisfies(move: move) }
    }
}

extension Piece  {
    var description: String {
        get {
            switch color {
            case .black: return representation.lowercased()
            case .white: return representation.uppercased()
            }
        }
    }
}
