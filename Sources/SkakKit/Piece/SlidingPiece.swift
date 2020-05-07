//
//  File.swift
//  
//
//  Created by Magnus Jensen on 11/08/2019.
//

protocol SlidingPieceMechanics: PieceMechanics { }

extension SlidingPieceMechanics {
    /// Returns a bitboard with the possible slidings to the right from a isolated bitboard. If the provided isolation does not represent a isolated piece, nil will be returned.
    func rightSlidings(on board: Bitboard, from isolated: Bitboard) -> Bitboard? {
        guard isolated.pieceCount == 1 else {
            return nil
        }
        
        let occupiens = board & ~Bitboard(rawValue: isolated.rawValue * 2)
        let attack = board ^ occupiens
        
        return attack
    }
    
    /// Find the possible attacks on a rank.
    ///
    /// So given the following board, where R is the white rook and ? is some undefined piece:
    /// ```
    /// 00000000
    /// 00000000
    /// 00000000
    /// 000R00?0
    /// 00000000
    /// 00000000
    /// 00000000
    /// 00000000
    /// ```
    /// The possible attacks will be given on a board:
    /// ```
    /// 00000000
    /// 00000000
    /// 00000000
    /// 11101110
    /// 00000000
    /// 00000000
    /// 00000000
    /// 00000000
    /// ```
    /// Take notice that:
    /// * the R is 0 as its not a valid move,
    /// * the ? is 1 as it can possible be attacked, you have to manage yourself if its the same color or not
    /// * To the right of the ? is not reachable
    ///
    /// - Parameters:
    ///   - occupied: bitboard with occupiens
    ///   - attackers: bitboard with attackers
    /// - Returns: bitboard with sliding rank attacks
    func rankAttacks(occupied: Bitboard, attackers: Bitboard) -> Bitboard {
        let left = hyperbola(occupied: occupied, attackers: attackers)
        
        // Hyperbola works only to the left, so we use horizontal mirrored boards
        let right = hyperbola(
            occupied: occupied.horizontalMirrored(),
            attackers: attackers.horizontalMirrored())
            .horizontalMirrored()
        
        return left | right
    }
    
    func fileAttacks(occupied: Bitboard, attackers: Bitboard, mask: Bitboard) -> Bitboard {
        return 0
    }
    
    func diagonalAttacks(occupied: Bitboard, attackers: Bitboard, mask: Bitboard) -> Bitboard {
        let isolated = attackers.isolatedPieces()
        return 0
    }
    
    /// Hyperbola Quintessence
    /// Returns bitboard with reachable + attacking squares to the left by sliding
    ///
    /// Based on https://www.chessprogramming.org/Hyperbola_Quintessence#Generalized_Set-wise_Attacks
    ///
    /// - Parameters:
    ///   - occupied: the board with pieces that can be captured
    ///   - attackers: the board to find attacking squares of
    /// - Returns: A bitboard with reachable squares to the left of the attackers limited by the occupiers
    func hyperbola(occupied: Bitboard, attackers: Bitboard) -> Bitboard {
        let mask = Bitboard.Masks.fileA
        let upto = attackers << 1
        let overflowProtectedBoard = occupied | mask
        let gapfilled = overflowProtectedBoard.rawValue - upto.rawValue
        let attack = (occupied ^ Bitboard(rawValue: gapfilled)) & ~mask
        return attack
    }
}
