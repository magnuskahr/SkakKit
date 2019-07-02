//
//  MoveTests.swift
//  
//
//  Created by Magnus Jensen on 27/06/2019.
//

import XCTest
@testable import SkakKit

class MoveTests: XCTestCase {
    
    func testIsDiagonal() {
        let A1 = Position(file: .A, rank: .one)
        let H8 = Position(file: .H, rank: .eight)
        let right = Move(from: A1, to: H8)
        XCTAssertTrue(right.isDiagonal)
        XCTAssertFalse(right.isHorizontal)
        XCTAssertFalse(right.isVertical)
        
        let H1 = Position(file: .H, rank: .one)
        let A8 = Position(file: .A, rank: .eight)
        let left = Move(from: H1, to: A8)
        XCTAssertTrue(left.isDiagonal)
        XCTAssertFalse(left.isHorizontal)
        XCTAssertFalse(left.isVertical)
    }
    
    func testIsNotDiagonal() {
        let A1 = Position(file: .A, rank: .one)
        let H7 = Position(file: .H, rank: .seven)
        let right = Move(from: A1, to: H7)
        XCTAssertFalse(right.isDiagonal)
        
        let H1 = Position(file: .H, rank: .one)
        let A7 = Position(file: .A, rank: .seven)
        let left = Move(from: H1, to: A7)
        XCTAssertFalse(left.isDiagonal)
    }
    
    func testIsHorizontal() {
        let A1 = Position(file: .A, rank: .one)
        let B1 = Position(file: .B, rank: .one)
        let C1 = Position(file: .C, rank: .one)
        
        let right = Move(from: B1, to: C1)
        XCTAssertTrue(right.isHorizontal)
        XCTAssertFalse(right.isDiagonal)
        XCTAssertFalse(right.isVertical)
        
        let left = Move(from: B1, to: A1)
        XCTAssertTrue(left.isHorizontal)
        XCTAssertFalse(left.isDiagonal)
        XCTAssertFalse(left.isVertical)
    }
    
    func testIsNotHorizontal() {
        let A1 = Position(file: .A, rank: .one)
        let A2 = Position(file: .A, rank: .two)
        let A3 = Position(file: .A, rank: .three)
        
        let up = Move(from: A2, to: A3)
        XCTAssertFalse(up.isHorizontal)
        
        let down = Move(from: A2, to: A1)
        XCTAssertFalse(down.isHorizontal)
    }
    
    func testIsVertical() {
        let A1 = Position(file: .A, rank: .one)
        let A2 = Position(file: .A, rank: .two)
        let A3 = Position(file: .A, rank: .three)
        
        let up = Move(from: A2, to: A3)
        XCTAssertTrue(up.isVertical)
        XCTAssertFalse(up.isDiagonal)
        XCTAssertFalse(up.isHorizontal)
        
        let down = Move(from: A2, to: A1)
        XCTAssertTrue(down.isVertical)
        XCTAssertFalse(down.isDiagonal)
        XCTAssertFalse(down.isHorizontal)
    }
    
    func testIsNotVertical() {
        let A1 = Position(file: .A, rank: .one)
        let B1 = Position(file: .B, rank: .one)
        let C1 = Position(file: .C, rank: .one)
        
        let right = Move(from: B1, to: C1)
        XCTAssertFalse(right.isVertical)
        
        let left = Move(from: B1, to: A1)
        XCTAssertFalse(left.isVertical)
    }
}
