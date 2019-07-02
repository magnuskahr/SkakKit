//
//  DiagonalRouteTests.swift
//  
//
//  Created by Magnus Jensen on 28/06/2019.
//

import XCTest
@testable import SkakKit

class DiagonalRouteTests: XCTestCase {
    
    let route = DiagonalRoute()
    
    func testDontAllowEastMove() {
        let from = Position(file: .A, rank: .one)
        let to = Position(file: .B, rank: .one)
        let move = Move(from: from, to: to)
        
        XCTAssertFalse(route.satisfies(move: move))
    }
    
    func testDontAllowWestMove() {
        let from = Position(file: .B, rank: .one)
        let to = Position(file: .A, rank: .one)
        let move = Move(from: from, to: to)
        
        XCTAssertFalse(route.satisfies(move: move))
    }
    
    func testDontAllowNorthMove() {
        let from = Position(file: .A, rank: .one)
        let to = Position(file: .A, rank: .two)
        let move = Move(from: from, to: to)
        
        XCTAssertFalse(route.satisfies(move: move))
    }
    
    func testDontAllowSouthMove() {
        let from = Position(file: .B, rank: .one)
        let to = Position(file: .A, rank: .one)
        let move = Move(from: from, to: to)
        
        XCTAssertFalse(route.satisfies(move: move))
    }
    
    func testAllowNorthEastMove() {
        let from = Position(file: .A, rank: .one)
        let to = Position(file: .B, rank: .two)
        let move = Move(from: from, to: to)
        
        XCTAssertTrue(route.satisfies(move: move))
    }

    func testAllowSouthEastMove() {
        let from = Position(file: .A, rank: .two)
        let to = Position(file: .B, rank: .one)
        let move = Move(from: from, to: to)
        
        XCTAssertTrue(route.satisfies(move: move))
    }
    
    func testAllowNorthWestMove() {
        let from = Position(file: .B, rank: .one)
        let to = Position(file: .A, rank: .two)
        let move = Move(from: from, to: to)
        
        XCTAssertTrue(route.satisfies(move: move))
    }
    
    func testAllowSouthWestMove() {
        let from = Position(file: .B, rank: .two)
        let to = Position(file: .A, rank: .one)
        let move = Move(from: from, to: to)
        
        XCTAssertTrue(route.satisfies(move: move))
    }
}
