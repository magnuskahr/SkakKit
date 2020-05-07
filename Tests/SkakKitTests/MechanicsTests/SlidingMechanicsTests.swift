//
//  SlidingMechanicsTests.swift
//  
//
//  Created by Magnus Jensen on 07/05/2020.
//

import XCTest
@testable import SkakKit

class SlidingMechanicsTests: XCTestCase {
    
    let stub = BasicStub()
    let empty: Bitboard = 0
    
    func testIsolatedPieceAttacksWholeRank() {
        let board: Bitboard = 0x10
        let attacks = stub.rankAttacks(occupied: empty, attackers: board)
        
        let expectedAttacks: Bitboard = 0xEF
        XCTAssertEqual(attacks, expectedAttacks)
    }
    
    func testIsolatedPieceExtremeLeftAttacksWholeRank() {
        let board: Bitboard = 0x1
        let attacks = stub.rankAttacks(occupied: empty, attackers: board)
        
        let expectedAttacks: Bitboard = 0xFE
        XCTAssertEqual(attacks, expectedAttacks)
    }
    
    func testIsolatedPieceExtremeRightAttacksWholeRank() {
        let board: Bitboard = 0x80
        let attacks = stub.rankAttacks(occupied: empty, attackers: board)
        
        let expectedAttacks: Bitboard = 0x7F
        XCTAssertEqual(attacks, expectedAttacks)
    }
    
    func testWholeFileAttacksAllRanks() {
        let attackers: Bitboard = 0x1010101010101010
        let attacks = stub.rankAttacks(occupied: empty, attackers: attackers)
        
        let expected: Bitboard = 0xEFEFEFEFEFEFEFEF
        XCTAssertEqual(attacks, expected)
    }
 
    // MARK: - hyperbola tests
    
    func testHyperbolaAtEightRankMidFile() {
        let attacker: Bitboard = 0x1000000000000000
        let attacks = stub.hyperbola(occupied: empty, attackers: attacker)
        
        let expected: Bitboard = 0xE000000000000000
        XCTAssertEqual(attacks, expected)
    }
    
    func testHyperbolaAtSevenRankMidFile() {
        let attacker: Bitboard = 0x10000000000000 // 00001000
        let attacks = stub.hyperbola(occupied: empty, attackers: attacker)

        let expected: Bitboard = 0xE0000000000000 // 00000111, remember hyperbola goes to the right on the board
        XCTAssertEqual(attacks, expected)
    }
    
    func testHyperbolaAtEigthRankMidFileWithOccupent() {
        let attacker: Bitboard = 0x1000000000000000 // 00001000
        let defender: Bitboard = 0x8000000000000000 // 00000001
        let attacks = stub.hyperbola(occupied: defender, attackers: attacker)
        
        let expected: Bitboard = 0xE000000000000000 // 00000111, remember hyperbola goes to the right on the board
        XCTAssertEqual(attacks, expected)
    }
    
    func testHyperbolaAtA8() {
        let attacker: Bitboard = 0x100000000000000 //8: 100000000
        let attacks = stub.hyperbola(occupied: empty, attackers: attacker)
        
        print(attacks.ascii)
        
        let expected: Bitboard = 0xFE00000000000000 // 01111111, remember hyperbola goes to the right on the board
        XCTAssertEqual(attacks, expected)
    }
    
    func testHyperbolaAtH8() {
        let attacker: Bitboard = 0x8000000000000000 // 100000000
        let defender: Bitboard = 0
        let attacks = stub.hyperbola(occupied: defender, attackers: attacker)
        
        let expected: Bitboard = 0
        XCTAssertEqual(attacks, expected)
    }
    
    func testRankSevenAndSixMiddle() {
        //7: 00001000
        //6: 00001000
        let attacker: Bitboard = 0x10100000000000
        print(attacker.ascii)
        
        let attacks = stub.hyperbola(occupied: empty, attackers: attacker)
        print(attacks.ascii)
        let expected: Bitboard = 0xE0E00000000000
        XCTAssertEqual(attacks, expected)
        
        
    }
    
    func testRankEightAndSevenMiddle() {
        //8: 00001000
        //7: 00001000
        let attacker: Bitboard = 0x1010000000000000
        
        let attacks = stub.hyperbola(occupied: attacker, attackers: attacker)
        print(attacks.ascii)
        
        //8: 00000111
        //7: 00000111
        let expected: Bitboard = 0xE0E0000000000000
        XCTAssertEqual(attacks, expected)
    }
    
    func testRankEightAndSixMiddle() {
        //8: 00000100
        //6: 00000100
        let attackers: Bitboard = 0x2000200000000000
        let attacks = stub.hyperbola(occupied: empty, attackers: attackers)
        
        //8: 00000011
        //6: 00000011
        let expected: Bitboard = 0xC000C00000000000
        XCTAssertEqual(attacks, expected)
    }
    
    func testHyperbolaWithOccupier() {
        let attackers: Bitboard = 0x10 // 00001000
        let defender: Bitboard = 0x50  // 00001010
        
        let attacks = stub.hyperbola(occupied: defender, attackers: attackers)
        let expectation: Bitboard = 0x60
        
        XCTAssertEqual(attacks, expectation)
    }
    
    func testHyperbolaMultiRankWithOccupier() {
        let attackers: Bitboard = 0x100010 // 00001000
        let defender: Bitboard = 0x500050  // 00001010
        
        let attacks = stub.hyperbola(occupied: defender, attackers: attackers)
        let expectation: Bitboard = 0x600060
        
        XCTAssertEqual(attacks, expectation)
    }
    
    func testHyperbolaWithOccupierEightRank() {
        let attackers: Bitboard = 0x1000000000000000 // 00001000
        let defender: Bitboard = 0x5000000000000000  // 00001010
        
        let attacks = stub.hyperbola(occupied: defender, attackers: attackers)
        let expectation: Bitboard = 0x6000000000000000
        
        XCTAssertEqual(attacks, expectation)
    }
    
    func testHyperbolaEightRankWithOccupierOnH() {
        let attackers: Bitboard = 0x1000000000000000 // 00001000
        let defender: Bitboard = 0x9000000000000000  // 00001010
        
        let attacks = stub.hyperbola(occupied: defender, attackers: attackers)
        let expectation: Bitboard = 0xE000000000000000
        
        XCTAssertEqual(attacks, expectation)
    }
    
    func testHyperbolaMultiOnOneRank() {
        let attackers: Bitboard = 0x12 // 01001000
        let defender: Bitboard = 0x12  // 01011000
        
        let attacks = stub.hyperbola(occupied: defender, attackers: attackers)
        let expectation: Bitboard = 0xFC
        
        XCTAssertEqual(attacks, expectation)
    }
    
    func testHyperbolaMultiOnOneRankWithOccupier() {
        let attackers: Bitboard = 0x12 // 01001000
        let defender: Bitboard = 0x1A  // 01011000
        
        let attacks = stub.hyperbola(occupied: defender, attackers: attackers)
        let expectation: Bitboard = 0xEC
        
        XCTAssertEqual(attacks, expectation)
    }
    
    func testHyperbolaMultiOnOneRankWithOccupierAndSpace() {
        let attackers: Bitboard = 0x22 // 01000100
        let defender: Bitboard = 0x2A  // 01010100
        
        let attacks = stub.hyperbola(occupied: defender, attackers: attackers)
        let expectation: Bitboard = 0xCC // 00110011
        
        XCTAssertEqual(attacks, expectation)
    }
    
    func testOccupiersContainingAttackersDoesntMatter() {
        let attackers: Bitboard = 0x22  // 01000100
        let occupiers: Bitboard = 0x2A  // 01010100
        let defender: Bitboard = 0x8    // 00010000
        
        let attacksWithOccupiers = stub.hyperbola(occupied: occupiers, attackers: attackers)
        let attacksWithDefender = stub.hyperbola(occupied: defender, attackers: attackers)
        
        XCTAssertEqual(attacksWithOccupiers, attacksWithDefender)
    }
}

extension SlidingMechanicsTests {
    struct BasicStub: SlidingPieceMechanics {
        func attacks(on board: Bitboard, as color: Color) -> Bitboard {
            return 0
        }
    }
}
