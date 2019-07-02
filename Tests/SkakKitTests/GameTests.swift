//
//  GameTests.swift
//  
//
//  Created by Magnus Jensen on 28/06/2019.
//

import XCTest
@testable import SkakKit

class GameTests: XCTestCase {
    
    var game: Game!
    
    override func setUp() {
        let board = Board(with: BoardBuilderStub())
        game = Game(board: board)
    }
    
    // - MARK: Setup
    
    func testStartingColor() {
        let startingColor = game.playerInTurn
        XCTAssertEqual(startingColor, .white)
    }
    
    // - MARK: Attackability
    
    func testEmptyPositionIsAttackable() {
        let attackable = game.attackability(of: Positions.empty)
        XCTAssertTrue(attackable)
    }
    
    func testActiveColorNotAttackable() {
        let attackable = game.attackability(of: Positions.wPawn)
        XCTAssertFalse(attackable)
    }
    
    func testOtherColorIsAttackable() {
        let attackable = game.attackability(of: Positions.bPawn)
        XCTAssertTrue(attackable)
    }
    
    // - MARK: Promoteable tests
    
    func testOnlyPromotePromoteables() {
        let queen = Queen(color: .white)
        let result = game.shouldPromote(candidate: queen, on: Positions.empty)
        XCTAssertFalse(result)
    }
    
    func testPromotePromotable() {
        let pawn = Pawn(color: .white)
        let position = Position(file: .A, rank: .eight)
        let result = game.shouldPromote(candidate: pawn, on: position)
        XCTAssertTrue(result)
    }
    
    func testShouldOnlyPromoteWhiteAtRankEight() {
        let pawn = Pawn(color: .white)
        for rank in [Rank.one, .two, .three, .four, .five, .six, .seven] {
            let position = Position(file: .A, rank: rank)
            let result = game.shouldPromote(candidate: pawn, on: position)
            XCTAssertFalse(result)
        }
        
        let position = Position(file: .A, rank: .eight)
        let result = game.shouldPromote(candidate: pawn, on: position)
        XCTAssertTrue(result)
    }
    
    
    func testShouldOnlyPromoteBlackAtRankOne() {
        let pawn = Pawn(color: .black)
        for rank in [Rank.two, .three, .four, .five, .six, .seven, .eight] {
            let position = Position(file: .A, rank: rank)
            let result = game.shouldPromote(candidate: pawn, on: position)
            XCTAssertFalse(result)
        }
        
        let position = Position(file: .A, rank: .one)
        let result = game.shouldPromote(candidate: pawn, on: position)
        XCTAssertTrue(result)
    }
    
    // - MARK: Move tests
    
    func testMoveFailesFromEmptyPosition() {
        let move = Move(from: Positions.empty, to: Positions.bPawn)
        let result = game.perform(move: move)
        switch result {
        case .failure(let error) where error != .empty: XCTFail("Wrong error, should be .empty")
        case .success(_): XCTFail("Should not be able to start a move from empty position")
        default: break
        }
    }
    
    func testMovesPiece() {
        let move = Move(from: Positions.wPawn, to: Positions.empty)
        let result = game.perform(move: move)
        
        switch result {
        case .failure(_): XCTFail()
        default: break
        }
    }
    
    func testCantMoveWrongColor() {
        let move = Move(from: Positions.bPawn, to: Positions.empty)
        let result = game.perform(move: move)
        
        switch result {
        case .success(_): XCTFail("Not allowed to move wrong color")
        case .failure(let error) where error != .wrongColor: XCTFail("Wrong error, should be .wrongColor")
        default: break
        }
    }
    
    func testMoveNeedsDistance() {
        let move = Move(from: Positions.wPawn, to: Positions.wPawn)
        let result = game.perform(move: move)
        
        switch result {
        case .success(_): XCTFail("Not allowed to perform a move without distance")
        case .failure(let error) where error != .illegal: XCTFail("Wrong error, should be .illegal")
        default: break
        }
    }
    
    
}
