//
//  VerticalRouteTests.swift
//  
//
//  Created by Magnus Jensen on 28/06/2019.
//

import XCTest
@testable import SkakKit

class VerticalRouteTests: XCTestCase {
    
    let route = VerticalRoute()
    
    func testAllowVerticalMove() {
        
        let from = Position(file: .C, rank: .three)
        let up = Position(file: .C, rank: .four)
        let down = Position(file: .C, rank: .two)
        
        let moveUp = Move(from: from, to: up)
        let moveDown = Move(from: from, to: down)
        
        XCTAssertTrue(route.satisfies(move: moveUp))
        XCTAssertTrue(route.satisfies(move: moveDown))
    }
    
    func testDownAllowsHorizontalMove() {
        let A1 = Position(file: .A, rank: .one)
        let B1 = Position(file: .B, rank: .one)
        let C1 = Position(file: .C, rank: .one)
        
        let right = Move(from: B1, to: C1)
        let left = Move(from: B1, to: A1)
        
        XCTAssertFalse(route.satisfies(move: right))
        XCTAssertFalse(route.satisfies(move: left))
    }
}
