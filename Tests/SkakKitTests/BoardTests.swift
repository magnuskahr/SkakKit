//
//  BoardTests.swift
//  
//
//  Created by Magnus Jensen on 27/06/2019.
//

import XCTest
@testable import SkakKit

class BoardTests: XCTestCase {
    
    let builder = BoardBuilderStub()
    var board: Board!
    
    override func setUp() {
        board = Board()
        
        let wpawn = Piece.whitePawn
        board.place(piece: wpawn, at: Positions.wPawn)
    }
    
    // - MARK: Get pieces
    
    func testGetsPieceAtPosition() {
        let piece = board.piece(at: Positions.wPawn)!
        XCTAssertEqual(piece.color, .white)
        XCTAssertEqual(piece.identifier, .pawn)
    }
    
    func testGetsNoPieceAtEmptyPosition() {
        let piece = board.piece(at: Positions.empty)
        XCTAssertNil(piece)
    }
    
    // - MARK: Clear positions
    
    func testClearsPosition() {
        XCTAssertNotNil(board.piece(at: Positions.wPawn))
        board.clear(at: Positions.wPawn)
        XCTAssertNil(board.piece(at: Positions.wPawn))
    }
    
    // - MARK: Place piece
    
    func testPlacePieceOnEmptyPosition() {
        let piece = Piece.whiteQueen
        board.place(piece: piece, at: Positions.empty)
        
        let placed = board.piece(at: Positions.empty)
        XCTAssertNotNil(placed)
        XCTAssertEqual(placed?.identifier, .queen)
        XCTAssertEqual(placed?.color, .white)
    }
    
    func testPlacePieceOnOccupiedPositionDoesNotClearIt() {
        let piece = Piece.whiteQueen
        board.place(piece: piece, at: Positions.bPawn)
        
        let amountPlacedOnBoards = board.bitboards
            .filter { $0.value.occupied(at: Positions.bPawn) }
            .count
        
        XCTAssertEqual(amountPlacedOnBoards, 2)
    }
    
    // - MARK: Move pieces
    
    func testMoveFailesFromEmptyPosition() {
        let move = Move(from: Positions.empty, to: Positions.bPawn)
        let result = board.perform(move: move)
        XCTAssertFalse(result)
    }
    
    func testMoveRemovesMovingPiece() {
        let move = Move(from: Positions.wPawn, to: Positions.empty)
        let _ = board.perform(move: move)
        let empty = board.piece(at: Positions.wPawn)
        XCTAssertNil(empty)
    }
    
    func testMovesPiece() {
        let move = Move(from: Positions.wPawn, to: Positions.empty)
        let _ = board.perform(move: move)
        
        let piece = board.piece(at: Positions.empty)
        XCTAssertEqual(piece!, .whitePawn)
    }
    
    func testMoveOverwritesPiece() {

        var board = Board(bitboards: [
            .whitePawn: 0x4, // C1
            .blackPawn: 0x800 // D2
        ])

        let white = Position(file: .C, rank: .one)
        let black = Position(file: .D, rank: .two)

        let move = Move(from: white, to: black)
        XCTAssertTrue(board.perform(move: move))

        let piece = board.piece(at: black)
        XCTAssertEqual(piece!, .whitePawn)

    }
}

// - MARK: Stubs
struct Positions {
    static let wPawn = Position(file: .A, rank: .two)
    static let bPawn = Position(file: .B, rank: .seven)
    static let empty = Position(file: .B, rank: .three)
}

struct BoardBuilderStub: BoardBuilder {
    func construct() -> [Position : Piece] {
        return [
            Positions.wPawn: Piece.whitePawn,
            Positions.bPawn: Piece.whitePawn
        ]
    }
}
