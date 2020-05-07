//
//  SlidingMechanicsTests.swift
//  
//
//  Created by Magnus Jensen on 07/05/2020.
//

import XCTest
@testable import SkakKit

class SlidingMechanicsTests: XCTestCase {
    struct Stub: SlidingPieceMechanics {
        func attacks(on board: Bitboard, as color: Color) -> Bitboard {
            return 0
        }
    }
    
    func testT() {
        let board: Bitboard = 0x100000080000
        let stub = Stub()
        let attacks = stub.rankAttacks(occupied: 0, attackers: board)
        print(attacks.ascii)
    }
}
