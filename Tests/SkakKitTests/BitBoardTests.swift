//
//  BitBoardTests.swift
//  
//
//  Created by Magnus Jensen on 02/07/2019.
//

import XCTest
@testable import SkakKit

class BitBoardTests: XCTestCase {
    
    var bitboard: Bitboard!
    
    override func setUp() {
        bitboard = Bitboard()
    }
    
    func testBitboardStartsUnmarked() {
        XCTAssertEqual(bitboard, 0)
    }
    
    func testBitboardMarksA1() {
        let marked = Bitboard(marked: Position(file: .A, rank: .one))
        XCTAssertEqual(marked, 1)
    }
    
    func testBitboardMarksB1() {
        let marked = Bitboard(marked: Position(file: .B, rank: .one))
        XCTAssertEqual(marked, 0b10)
        // 2 as binary is 10
    }
    
    func testBitboardMarksA2() {
        let marked = Bitboard(marked: Position(file: .A, rank: .two))
        XCTAssertEqual(marked, 0b100000000)
    }
    
    func testBitboardMarksB2() {
        let marked = Bitboard(marked: Position(file: .B, rank: .two))
        XCTAssertEqual(marked, 0b1000000000)
    }
    
    func testMarksPositionA1() {
        let marks = bitboard.mark(Position(file: .A, rank: .one))
        XCTAssertTrue(marks)
        XCTAssertEqual(bitboard, 0b1)
    }
    
    func testMarksPositionB1() {
        let marks = bitboard.mark(Position(file: .B, rank: .one))
        XCTAssertTrue(marks)
        XCTAssertEqual(bitboard, 0b10)
    }
    
    func testDontMarkOccupiedPosition() {
        var board = Bitboard(marked: Position(file: .A, rank: .one))
        let marks = board.mark(Position(file: .A, rank: .one))
        XCTAssertFalse(marks)
    }
    
    func testCanHaveMultipleMarks() {
        bitboard.mark(Position(file: .A, rank: .one))
        bitboard.mark(Position(file: .B, rank: .one))
        XCTAssertEqual(bitboard, 0b11)
    }
    
    func testClearsPositionOnSingleMarkedBoard() {
        let position = Position(file: .A, rank: .one)
        var marked = Bitboard(marked: position)
        marked.clear(position)
        XCTAssertEqual(marked, 0)
    }
    
    func testClearsPositionOnMultipleMarkedBoard() {
        let position = Position(file: .A, rank: .one)
        var marked = Bitboard(marked: position)
        marked.mark(Position(file: .B, rank: .one))
        marked.clear(position)
        XCTAssertEqual(marked, 0b10)
    }
    
    func testDontClearEmptyPosition() {
        var board = Bitboard()
        let clears = board.clear(Position(file: .A, rank: .one))
        XCTAssertFalse(clears)
    }
    
    // - MARK: bitwise operations
    
    // This may seem odd at first, but remember '<<' ussually results in higher numbers, and a chess board gets bigger as we read it from A1, B1, C1 .... F8, G8, H8.
    func testShiftsBitboardLeftOnePosition() {
        let b1 = Bitboard(marked: Position(file: .B, rank: .one))
        let c1 = b1 << 1
        XCTAssertEqual(c1, 0b100)
    }
    
    func testShiftsBitboardLeftTwoPositions() {
        let a1 = Bitboard(marked: Position(file: .A, rank: .one))
        let c1 = a1 << 2
        XCTAssertEqual(c1, 0b100)
    }
    
    func testShiftsBitboardLeftCrossingRank() {
        let h1 = Bitboard(marked: Position(file: .H, rank: .one))
        let a2 = h1 << 1
        XCTAssertEqual(a2, 0b100000000)
    }
    
    func testShiftsBitboardRightOnePosition() {
        let b1 = Bitboard(marked: Position(file: .B, rank: .one))
        let a1 = b1 >> 1
        XCTAssertEqual(a1, 0b1)
    }
    
    func testShiftsBitboardRightTwoPositions() {
        let c1 = Bitboard(marked: Position(file: .C, rank: .one))
        let a1 = c1 >> 2
        XCTAssertEqual(a1, 0b1)
    }
    
    func testShiftsBitboardRightCrossingRank() {
        let a2 = Bitboard(marked: Position(file: .A, rank: .two))
        let h1 = a2 >> 1
        XCTAssertEqual(h1, 0b10000000)
    }
    
    func testShiftCurrentBoardLeft() {
        var a1 = Bitboard(marked: Position(file: .A, rank: .one))
        a1 <<= 1
        XCTAssertEqual(a1, 0b10)
    }
    
    func testShiftCurrentBoardRight() {
        var b1 = Bitboard(marked: Position(file: .B, rank: .one))
        b1 >>= 1
        XCTAssertEqual(b1, 0b1)
    }
    
    func testBitboardAND() {
        let board1 = Bitboard(rawValue: 0b101)
        let board2 = Bitboard(rawValue: 0b111)
        let ANDed = board1 & board2
        XCTAssertEqual(ANDed, 0b101)
    }
    
    func testBitboardOR() {
        let board1 = Bitboard(rawValue: 0b1010)
        let board2 = Bitboard(rawValue: 0b1100)
        let ORed = board1 | board2
        XCTAssertEqual(ORed, 0b1110)
    }
    
    func testBitboardXOR() {
        let board1 = Bitboard(rawValue: 0b1010)
        let board2 = Bitboard(rawValue: 0b1100)
        let XORed = board1 ^ board2
        XCTAssertEqual(XORed, 0b0110)
    }
    
    func testBitboardBiggerThan() {
        let lesser = Bitboard(rawValue: 0b1)
        let bigger = Bitboard(rawValue: 0b10)
        XCTAssertTrue(bigger > lesser)
    }
    
    func testBitboardLesserThan() {
        let lesser = Bitboard(rawValue: 0b1)
        let bigger = Bitboard(rawValue: 0b10)
        XCTAssertTrue(lesser < bigger)
    }
}
