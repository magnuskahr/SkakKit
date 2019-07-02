//
//  BitBoardTests.swift
//  
//
//  Created by Magnus Jensen on 02/07/2019.
//

import XCTest
@testable import SkakKit

class BitBoardTests: XCTestCase {
    
    func test(){
        var board = Bitboard(color: .black, piece: .pawn)
        
        let mark = board.mark(file: .A, rank: .one)
        let occupied = board.mark(file: .A, rank: .one)
        
        XCTAssertTrue(mark)
        XCTAssertFalse(occupied)
        
        let mark2 = board.mark(file: .B, rank: .one)
        XCTAssertTrue(mark2)
    }
    
}
