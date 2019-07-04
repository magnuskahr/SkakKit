//
//  KingTests.swift
//  
//
//  Created by Magnus Jensen on 04/07/2019.
//

import XCTest
@testable import SkakKit

class KingTests: XCTestCase {
    
    let king = BBKing()
    var board: Bitboard!
    
    override func setUp() {
        board = Bitboard()
    }
    
    func testSpots() {
        board.mark(Position(file: .B, rank: .two))
        let spots = king.spots(on: board)
        XCTAssertEqual(spots, 0b00000111_00000101_00000111)
    }
    
    func testSpotsDontOverflowToH() {
        board.mark(Position(file: .A, rank: .two))
        let spots = king.spots(on: board)
        let empty = spots & Bitboard.Masks.fileH
        XCTAssertEqual(empty, 0)
    }
    
    func testSpotsDontOverflowToA() {
        board.mark(Position(file: .H, rank: .eight))
        let spots = king.spots(on: board)
        let empty = spots & Bitboard.Masks.fileA
        XCTAssertEqual(empty, 0)
    }
}
