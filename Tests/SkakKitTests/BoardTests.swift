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
        board = Board(with: builder)
    }
    
    // - MARK: Get pieces
    
    func testGetsPieceAtPosition() {
        let piece = board.piece(at: Positions.wPawn)!
        XCTAssertEqual(piece.color, .white)
        XCTAssertTrue(piece is Pawn)
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
        let piece = Queen(color: .white)
        board.place(piece: piece, at: Positions.empty)
        
        let placed = board.piece(at: Positions.empty)
        XCTAssertNotNil(placed)
        XCTAssertTrue(placed is Queen)
        XCTAssertEqual(placed?.color, .white)
    }
    
    func testPlacePieceOnOccupiedPosition() {
        let piece = Queen(color: .white)
        board.place(piece: piece, at: Positions.bPawn)
        
        let placed = board.piece(at: Positions.bPawn)
        XCTAssertNotNil(placed)
        XCTAssertTrue(placed is Queen)
        XCTAssertEqual(placed?.color, .white)
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
        XCTAssertNotNil(piece)
        XCTAssertTrue(piece is Pawn)
        XCTAssertEqual(piece?.color, .white)
    }
    
    func testMoveOverwritesPiece() {
        let move = Move(from: Positions.wPawn, to: Positions.bPawn)
        let _ = board.perform(move: move)
        let piece = board.piece(at: Positions.bPawn)
        XCTAssertNotNil(piece)
        XCTAssertTrue(piece is Pawn)
        XCTAssertEqual(piece?.color, .white)
    }
}

// - MARK: Stubs
struct Positions {
    static let wPawn = Position(file: .A, rank: .one)
    static let bPawn = Position(file: .B, rank: .two)
    static let empty = Position(file: .B, rank: .one)
}

struct BoardBuilderStub: BoardBuilder {
    func construct() -> [Position : Piece] {
        return [
            Positions.wPawn: Pawn(color: .white),
            Positions.bPawn: Pawn(color: .black)
        ]
    }
}
