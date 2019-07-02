//
//  File.swift
//  
//
//  Created by Magnus Jensen on 28/06/2019.
//

import XCTest
@testable import SkakKit

class LRouteTests: XCTestCase {
    
    let route = LRoute()
    let from = Position(file: .D, rank: .four)
    
    func testJumpMove() {
        
        XCTAssertTrue(allowes(.E, .six))
        XCTAssertTrue(allowes(.C, .six))
        
        XCTAssertTrue(allowes(.F, .five))
        XCTAssertTrue(allowes(.B, .five))
        
        XCTAssertTrue(allowes(.F, .three))
        XCTAssertTrue(allowes(.B, .three))
        
        XCTAssertTrue(allowes(.E, .two))
        XCTAssertTrue(allowes(.C, .two))
        
        XCTAssertFalse(allowes(.H, .three))
        
    }
    
    func allowes(_ file: File, _ rank: Rank) -> Bool {
        let to = Position(file: file, rank: rank)
        let move = Move(from: from, to: to)
        return route.satisfies(move: move)
    }
}
