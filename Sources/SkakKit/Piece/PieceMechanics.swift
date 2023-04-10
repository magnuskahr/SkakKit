protocol PieceMechanics {
    func reachingSquares(from origins: Bitboard, occupiers: Bitboard, color: Color) -> Bitboard
}
