//
//  PawnTests.swift
//  
//
//  Created by Magnus Jensen on 27/06/2019.
//

import XCTest
@testable import SkakKit

class old_PawnTests: XCTestCase {
    func testPromotions() {
        let pawn = Pawn(color: .white)
        var promotions = pawn.promotions()
        XCTAssertEqual(promotions.count, 4)
        
        promotions.removeAll(where: { $0 is Queen })
        XCTAssertEqual(promotions.count, 3)
        
        promotions.removeAll(where: { $0 is Bishop })
        XCTAssertEqual(promotions.count, 2)
        
        promotions.removeAll(where: { $0 is Rook })
        XCTAssertEqual(promotions.count, 1)
        
        promotions.removeAll(where: { $0 is Knight })
        XCTAssertEqual(promotions.count, 0)
    }
}
