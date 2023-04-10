import Foundation

struct PawnMechanics: PieceMechanics {

    func reachingSquares(from origins: Bitboard, occupiers: Bitboard, color: Color) -> Bitboard {
        switch color {
        case .black: return attacksDown(on: origins)
        case .white: return attacksUp(on: origins)
        }
    }
    
    func attacksUp(on board: Bitboard) -> Bitboard {
        let rightAttack = board << 9 & ~Bitboard.Masks.fileA
        let leftAttack = board << 7 & ~Bitboard.Masks.fileH
        
        return leftAttack | rightAttack
    }
    
    func attacksDown(on board: Bitboard) -> Bitboard {
        let rightAttack = board >> 9 & ~Bitboard.Masks.fileH
        let leftAttack = board >> 7 & ~Bitboard.Masks.fileA
        
        return leftAttack | rightAttack
    }
}

extension PawnMechanics: Promoteable {
    var promotions: [PieceIdentifier] {
        [.rook, .bishop, .knight, .queen]
    }
}
