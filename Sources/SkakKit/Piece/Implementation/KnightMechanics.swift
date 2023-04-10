import Foundation

struct KnightMechanics: PieceMechanics {
    
    /// We denote the attacks by the knight as following:
    ///    2       3
    ///  1                4
    ///      K
    ///  8                5
    ///    7       6
    func reachingSquares(from origins: Bitboard, occupiers: Bitboard, color: Color) -> Bitboard {
        
        let maskAB = Bitboard.Masks.fileA | Bitboard.Masks.fileB
        let maskGH = Bitboard.Masks.fileG | Bitboard.Masks.fileH
        
        let spot1 = origins << 6 & ~maskGH
        let spot2 = origins << 15 & ~Bitboard.Masks.fileH
        let spot3 = origins << 17 & ~Bitboard.Masks.fileA
        let spot4 = origins << 10 & ~maskAB
        
        let spot5 = origins >> 6 & ~maskAB
        let spot6 = origins >> 15 & ~Bitboard.Masks.fileA
        let spot7 = origins >> 17 & ~Bitboard.Masks.fileH
        let spot8 = origins >> 10 & ~maskGH
        
        return spot1 | spot2 | spot3 | spot4 | spot5 | spot6 | spot7 | spot8
    }
}
