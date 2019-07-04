//
//  PawnTests.swift
//  
//
//  Created by Magnus Jensen on 04/07/2019.
//

import XCTest
@testable import SkakKit

class PawnTests: XCTestCase {
    
    let pawn = BBPawn()
    var board: Bitboard!
    
    override func setUp() {
        board = Bitboard()
    }
    
    // - MARK: Attack up
    
    func testAttackUpLeftRight() {
        board.mark(Position(file: .C, rank: .one))
        let attacks = pawn.attacksUp(on: board)
        XCTAssertEqual(attacks, 0b1010_00000000)
    }
    
    func testAttackUpOnlyRightWhenFileA() {
        board.mark(Position(file: .A, rank: .one))
        let attacks = pawn.attacksUp(on: board)
        XCTAssertEqual(attacks, 0b10_00000000)
    }
    
    func testAttackUpOnlyLeftWhenFileH() {
        board.mark(Position(file: .H, rank: .one))
        let attacks = pawn.attacksUp(on: board)
        XCTAssertEqual(attacks, 0b1000000_00000000)
    }
    
    func testNoAttackUpFromRank8() {
        board.mark(Position(file: .H, rank: .eight))
        let attacks = pawn.attacksUp(on: board)
        XCTAssertEqual(attacks, 0)
    }
    
    // - MARK: Attack down
    
    func testAttackDownLeftRight() {
        board.mark(Position(file: .C, rank: .eight))
        let attacks = pawn.attacksDown(on: board)
        
        var expected = Bitboard()
        expected.mark(Position(file: .B, rank: .seven))
        expected.mark(Position(file: .D, rank: .seven))
        
        XCTAssertEqual(attacks, expected)
    }
    
    func testAttackDownOnlyRightWhenFileA() {
        board.mark(Position(file: .A, rank: .eight))
        let attacks = pawn.attacksDown(on: board)
        let expected = Bitboard(marked: Position(file: .B, rank: .seven))
        XCTAssertEqual(attacks, expected)
    }
    
    func testAttackDownOnlyLeftWhenFileH() {
        board.mark(Position(file: .H, rank: .eight))
        let attacks = pawn.attacksDown(on: board)
        let expected = Bitboard(marked: Position(file: .G, rank: .seven))
        XCTAssertEqual(attacks, expected)
    }
    
    func testNoAttackDownFromRank8() {
        board.mark(Position(file: .H, rank: .one))
        let attacks = pawn.attacksDown(on: board)
        XCTAssertEqual(attacks, 0)
    }
    
    // - MARK: Color depended attack
    
    func testWhiteAttacksUp() {
        board.mark(Position(file: .C, rank: .one))
        let attacks = pawn.attacks(on: board, with: .white)
        XCTAssertEqual(attacks, 0b1010_00000000)
    }
    
    func testBlackAttacksDown() {
        board.mark(Position(file: .C, rank: .eight))
        let attacks = pawn.attacks(on: board, with: .black)
        
        var expected = Bitboard()
        expected.mark(Position(file: .B, rank: .seven))
        expected.mark(Position(file: .D, rank: .seven))
        
        XCTAssertEqual(attacks, expected)
    }
    
}
