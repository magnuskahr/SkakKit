import XCTest
@testable import SkakKit

class KingTests: XCTestCase {
    
    let king = KingMechanics()
    var board: Bitboard!
    
    override func setUp() {
        board = Bitboard()
    }
    
    func testSpots() {
        board.mark(Position(file: .B, rank: .two))
        let spots = king.reachingSquares(from: board, occupiers: 0, color: .black)
        XCTAssertEqual(spots, 0b00000111_00000101_00000111)
    }
    
    func testSpotsDontOverflowToH() {
        board.mark(Position(file: .A, rank: .two))
        let spots = king.reachingSquares(from: board, occupiers: 0, color: .black)
        let empty = spots & Bitboard.Masks.fileH
        XCTAssertEqual(empty, 0)
    }
    
    func testSpotsDontOverflowToA() {
        board.mark(Position(file: .H, rank: .eight))
        let spots = king.reachingSquares(from: board, occupiers: 0, color: .black)
        let empty = spots & Bitboard.Masks.fileA
        XCTAssertEqual(empty, 0)
    }
}
