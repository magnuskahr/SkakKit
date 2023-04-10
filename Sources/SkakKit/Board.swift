import Foundation

extension [Piece : Bitboard] {
    static var classical: Self {
        [
            .whitePawn: 0xFF00,
            .blackPawn: 0xFF000000000000,

                .whiteRook: 0x81,
            .blackRook: 0x8100000000000000,

                .whiteKnight: 0x42,
            .blackKnight: 0x4200000000000000,

                .whiteBishop: 0x24,
            .blackBishop: 0x2400000000000000,

                .whiteQueen: 0x10,
            .blackQueen: 0x1000000000000000,

                .whiteKing: 0x8,
            .blackKing: 0x800000000000000
        ]
    }
}

/// A board is a representation  of a game state, it does not contain any game logic and should be used visely
struct Board {
    
    private(set) var bitboards: [Piece: Bitboard]

    init(bitboards: [Piece : Bitboard] = .classical) {
        self.bitboards = bitboards
    }
    
    mutating func perform(move: Move) -> Bool {
        
        guard let piece = piece(at: move.from) else {
            return false
        }
        
        clear(at: move.from)
        clear(at: move.to)
        
        place(piece: piece, at: move.to)
        
        return true
    }
    
    func piece(at position: Position) -> Piece? {
        bitboards.first {
            $0.value.occupied(at: position)
        }
        .map(\.key)
    }
    
    mutating func clear(at position: Position) {
        for key in bitboards.keys {
            bitboards[key]?.clear(position)
        }
    }
    
    /// Places the piece at the position
    ///
    /// Marks the bitboard, representing to the piece, at the given position at being occupied.
    /// This will not clear other bitboards of this position, and should therefor be used visely
    ///
    /// - Parameters:
    ///   - piece: piece to be placed
    ///   - position: position to place
    mutating func place(piece: Piece, at position: Position) {
        bitboards[piece]?.mark(position)
    }
    
    mutating func place(piece: PieceIdentifier, as color: Color, at position: Position) {
        if let key = key(of: piece, as: color) {
            place(piece: key, at: position)
        }
    }
    
    mutating func key(of identifier: PieceIdentifier, as color: Color) -> Piece? {
        bitboards.keys.first {
            $0.identifier == identifier && $0.color == color
        }
    }
    
    var ascii: String {
        var board = String()
        
        for rank in Rank.allCases.reversed() {
            for file in File.allCases {
                let position = Position(file: file, rank: rank)
                let representation = bitboards
                    .filter { $0.value.occupied(at: position) }
                    .map(\.key.representation)
                    .first ?? " "
                
                board += representation
            }
            board += "\n"
        }
        
        return board
    }
    
}
