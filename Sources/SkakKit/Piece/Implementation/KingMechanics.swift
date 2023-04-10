import Foundation

struct KingMechanics: PieceMechanics {
    
    /// We denote the attacks by the king as following:
    /// 1   2   3
    /// 8   K   4
    /// 7   6   5

    func reachingSquares(from origins: Bitboard, occupiers: Bitboard, color: Color) -> Bitboard {
        
        let spot1 = origins << 7 & ~Bitboard.Masks.fileH
        let spot2 = origins << 8
        let spot3 = origins << 9 & ~Bitboard.Masks.fileA
        let spot4 = origins << 1 & ~Bitboard.Masks.fileA
        
        let spot5 = origins >> 7 & ~Bitboard.Masks.fileA
        let spot6 = origins >> 8
        let spot7 = origins >> 9 & ~Bitboard.Masks.fileH
        let spot8 = origins >> 1 & ~Bitboard.Masks.fileH
        
        return spot1 | spot2 | spot3 | spot4 | spot5 | spot6 | spot7 | spot8
        
    }
}
