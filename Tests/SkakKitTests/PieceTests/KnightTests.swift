//
//  KnightTests.swift
//  
//
//  Created by Magnus Jensen on 04/07/2019.
//

import XCTest
@testable import SkakKit

class KnightTests: XCTestCase {
    
    let knight = BBKnight()
    var board: Bitboard!
    
    override func setUp() {
        board = Bitboard()
    }
    
    func testKnightMove() {
        board.mark(Position(file: .C, rank: .three))
        let attacks = knight.attacks(on: board, with: .white)
        let expected: Bitboard = 0b10100_0010001_00000000_00010001_00001010
        XCTAssertEqual(attacks, expected)
    }
    
    func testKnightMoveNoRolloverToH() {
        board.mark(Position(file: .B, rank: .three))
        let attacks = knight.attacks(on: board, with: .white)
        let empty = attacks & Bitboard.Masks.fileH
        XCTAssertEqual(empty, 0)
    }
    
    func testKnightMoveNoRolloverToG() {
        board.mark(Position(file: .A, rank: .three))
        let attacks = knight.attacks(on: board, with: .white)
        let empty = attacks & Bitboard.Masks.fileG
        XCTAssertEqual(empty, 0)
    }
    
    func testKnightMoveNoRolloverToA() {
        board.mark(Position(file: .G, rank: .three))
        let attacks = knight.attacks(on: board, with: .white)
        let empty = attacks & Bitboard.Masks.fileA
        XCTAssertEqual(empty, 0)
    }
    
    func testKnightMoveNoRolloverToB() {
        board.mark(Position(file: .H, rank: .three))
        let attacks = knight.attacks(on: board, with: .white)
        let empty = attacks & Bitboard.Masks.fileB
        XCTAssertEqual(empty, 0)
    }
    
}
