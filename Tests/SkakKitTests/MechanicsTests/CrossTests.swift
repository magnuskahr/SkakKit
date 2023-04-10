import XCTest
@testable import SkakKit

class CrossTests: XCTestCase {

    let cross = CrossMechanics()
    var board: Bitboard!

    override func setUp() {
        board = Bitboard()
    }

    func testSingleCross() {
        board.mark(Position(file: .D, rank: .four))
        let spots = cross.reachingSquares(from: board, occupiers: 0, color: .black)
        XCTAssertEqual(spots, 0x8080808F7080808)
    }

    func testSingleCrossWithIncreasingOccupiers() {
        board.mark(Position(file: .D, rank: .four))

        var occupiers = Bitboard()

        occupiers.mark(.init(file: .D, rank: .two))
        XCTAssertEqual(cross.reachingSquares(from: board, occupiers: occupiers, color: .black), 0x8080808F7080800)

        occupiers.mark(.init(file: .B, rank: .four))
        XCTAssertEqual(cross.reachingSquares(from: board, occupiers: occupiers, color: .black), 0x8080808F6080800)

        occupiers.mark(.init(file: .D, rank: .seven))
        XCTAssertEqual(cross.reachingSquares(from: board, occupiers: occupiers, color: .black), 0x80808F6080800)

        occupiers.mark(.init(file: .G, rank: .four))
        XCTAssertEqual(cross.reachingSquares(from: board, occupiers: occupiers, color: .black), 0x8080876080800)
    }

    func testDoubleCross() {
        board.mark(Position(file: .C, rank: .three))
        board.mark(Position(file: .F, rank: .six))
        let spots = cross.reachingSquares(from: board, occupiers: 0, color: .black)
        XCTAssertEqual(spots, 0x2424DF2424FB2424)
    }
}
