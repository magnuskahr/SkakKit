//
//  KnightTests.swift
//  
//
//  Created by Magnus Jensen on 04/07/2019.
//

import XCTest
@testable import SkakKit

class KnightTests: XCTestCase {
    
    let knight = KnightMechanics()
    var board: Bitboard!
    
    override func setUp() {
        board = Bitboard()
    }
    
    func testKnightMove() {
        board.mark(Position(file: .C, rank: .three))
        let attacks = knight.reachingSquares(from: board, occupiers: 0, color: .white)
        let expected: Bitboard = 0b10100_0010001_00000000_00010001_00001010
        XCTAssertEqual(attacks, expected)
    }
    
    func testKnightMoveNoRolloverToH() {
        board.mark(Position(file: .B, rank: .three))
        let attacks = knight.reachingSquares(from: board, occupiers: 0, color: .white)
        let empty = attacks & Bitboard.Masks.fileH
        XCTAssertEqual(empty, 0)
    }
    
    func testKnightMoveNoRolloverToG() {
        board.mark(Position(file: .A, rank: .three))
        let attacks = knight.reachingSquares(from: board, occupiers: 0, color: .white)
        let empty = attacks & Bitboard.Masks.fileG
        XCTAssertEqual(empty, 0)
    }
    
    func testKnightMoveNoRolloverToA() {
        board.mark(Position(file: .G, rank: .three))
        let attacks = knight.reachingSquares(from: board, occupiers: 0, color: .white)
        let empty = attacks & Bitboard.Masks.fileA
        XCTAssertEqual(empty, 0)
    }
    
    func testKnightMoveNoRolloverToB() {
        board.mark(Position(file: .H, rank: .three))
        let attacks = knight.reachingSquares(from: board, occupiers: 0, color: .white)
        let empty = attacks & Bitboard.Masks.fileB
        XCTAssertEqual(empty, 0)
    }
    
    func testKnightMoveFromHFile() {
        board.mark(Position(file: .H, rank: .three))
        
        let attacks = knight.reachingSquares(from: board, occupiers: 0, color: .white)
        let expectedAttacks: Bitboard = 0x4020002040
        
        XCTAssertEqual(attacks, expectedAttacks)
    }
    
    func testKnightMoveFromAFile() {
        board.mark(Position(file: .A, rank: .three))
        
        let attacks = knight.reachingSquares(from: board, occupiers: 0, color: .white)
        let expectedAttacks: Bitboard = 0x204000402
        
        XCTAssertEqual(attacks, expectedAttacks)
    }
}
