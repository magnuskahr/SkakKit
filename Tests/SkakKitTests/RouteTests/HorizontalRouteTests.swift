//
//  HorizontalRouteTests.swift
//  
//
//  Created by Magnus Jensen on 28/06/2019.
//

import XCTest
@testable import SkakKit

class HorizontalRouteTests: XCTestCase {
    
    let route = HorizontalRoute()
    
    func testDontAllowVerticalMove() {
        
        let from = Position(file: .C, rank: .three)
        let up = Position(file: .C, rank: .four)
        let down = Position(file: .C, rank: .two)
        
        let moveUp = Move(from: from, to: up)
        let moveDown = Move(from: from, to: down)
        
        XCTAssertFalse(route.satisfies(move: moveUp))
        XCTAssertFalse(route.satisfies(move: moveDown))
    }
    
    func testAllowsHorizontalMove() {
        let A1 = Position(file: .A, rank: .one)
        let B1 = Position(file: .B, rank: .one)
        let C1 = Position(file: .C, rank: .one)
        
        let right = Move(from: B1, to: C1)
        let left = Move(from: B1, to: A1)
        
        XCTAssertTrue(route.satisfies(move: right))
        XCTAssertTrue(route.satisfies(move: left))
    }
}

