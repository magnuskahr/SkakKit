import Foundation

struct CrossMechanics: SlidingPieceMechanics {
    func reachingSquares(from origins: Bitboard, occupiers: Bitboard, color: Color) -> Bitboard {
        let fileAttacks = fileAttacks(occupied: occupiers, attackers: origins)
        let rankAttacks = rankAttacks(occupied: occupiers, attackers: origins)
        return fileAttacks | rankAttacks
    }
}
