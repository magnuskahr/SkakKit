struct Piece {

    private let mechanics: PieceMechanics
    
    let color: Color
    let identifier: PieceIdentifier
    
    private init(color: Color, mechanics: PieceMechanics, identifier: PieceIdentifier) {
        self.color = color
        self.mechanics = mechanics
        self.identifier = identifier
    }

    func reachingSquares(from origins: Bitboard, occupiers: Bitboard) -> Bitboard {
        mechanics.reachingSquares(from: origins, occupiers: occupiers, color: color)
    }
    
    static let whitePawn = Piece(color: .white, mechanics: PawnMechanics(), identifier: .pawn)
    static let blackPawn = Piece(color: .black, mechanics: PawnMechanics(), identifier: .pawn)
    
    static let whiteRook = Piece(color: .white, mechanics: CrossMechanics(), identifier: .rook)
    static let blackRook = Piece(color: .black, mechanics: CrossMechanics(), identifier: .rook)
    
    static let whiteBishop = Piece(color: .white, mechanics: PawnMechanics(), identifier: .bishop)
    static let blackBishop = Piece(color: .black, mechanics: PawnMechanics(), identifier: .bishop)
    
    static let whiteKnight = Piece(color: .white, mechanics: PawnMechanics(), identifier: .knight)
    static let blackKnight = Piece(color: .black, mechanics: PawnMechanics(), identifier: .knight)
    
    static let whiteQueen = Piece(color: .white, mechanics: PawnMechanics(), identifier: .queen)
    static let blackQueen = Piece(color: .black, mechanics: PawnMechanics(), identifier: .queen)
    
    static let whiteKing = Piece(color: .white, mechanics: KingMechanics(), identifier: .king)
    static let blackKing = Piece(color: .black, mechanics: KingMechanics(), identifier: .king)
}

extension Piece: Equatable {
    static func == (lhs: Piece, rhs: Piece) -> Bool {
        lhs.color == rhs.color && lhs.identifier == rhs.identifier
    }
}

extension Piece: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(color)
        hasher.combine(identifier)
    }
}

extension Piece  {
    var representation: String {
        get {
            switch color {
            case .black: return identifier.representation.lowercased()
            case .white: return identifier.representation.uppercased()
            }
        }
    }
}

extension Piece: CustomStringConvertible {
    var description: String {
        "\(color) \(identifier)"
    }
}
