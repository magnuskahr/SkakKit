//
//  PieceIdentifier.swift
//  
//
//  Created by Magnus Jensen on 06/05/2020.
//

enum PieceIdentifier: Hashable {
    case pawn, rook, bishop, knight, king, queen
    
    var representation: String {
        switch self {
        case .bishop: return "b"
        case .rook: return "r"
        case .pawn: return "p"
        case .knight: return "n"
        case .queen: return "q"
        case .king: return "k"
        }
    }
}
