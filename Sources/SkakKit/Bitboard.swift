//
//  Bitboard.swift
//  
//
//  Created by Magnus Jensen on 02/07/2019.
//

import Foundation

struct BBIdentifier {
    let piece: BBPiece
    let color: Color
}

struct Bitboard: Equatable {
    
    private(set) var rawValue: UInt64 = 0
    
    init(rawValue: UInt64) {
        self.rawValue = rawValue
    }
    
    /// Marks a bitboard corresponding to the file/rank pair, and returns as a 64bit number.
    /// The LSB corresponds to A1 and MSB correspodns to H8
    ///
    /// A board, it is as follows:
    /// ```
    /// 57 58 59 60 61 62 63 64
    /// 49 51 52 53 54 55 56 56
    /// 41 42 43 44 45 46 47 48
    /// 33 34 35 36 37 38 39 40
    /// 25 26 27 28 29 30 31 32
    /// 17 18 19 20 21 22 23 24
    /// 09 10 11 12 13 14 15 16
    /// 01 02 03 04 05 06 07 08
    /// ```
    init(marked position: Position) {
        let file = Double(position.file.rawValue)
        let rank = Double(position.rank.rawValue)
        let exponent = (rank - 1) * 8 + file - 1
        let value = pow(2.0, exponent)
        self.rawValue = UInt64(value)
    }
    
    init() {}
    
    /// Marks a position as occupied, will return wether it was successfull or not
    /// A possition can be marked if the representing value will be higher.
    /// - Parameter file: the file to mark
    /// - Parameter rank: the rank to mark
    @discardableResult
    mutating func mark(_ position: Position) -> Bool {
        let markedPosition = Bitboard(marked: position)
        let newData = self ^ markedPosition
        guard newData > self else {
            return false
        }
        
        self = newData
        return true
    }
    
    @discardableResult
    mutating func clear(_ position: Position) -> Bool {
        let markedPosition = Bitboard(marked: position)
        let newData = self ^ markedPosition
        guard newData < self else {
            return false
        }
        self = newData
        return true
    }
    
    func attacks(as piece: BBPiece, colored color: Color) -> Bitboard {
        return piece.attacks(on: self, with: color)
    }
}

extension Bitboard: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: UInt64) {
        self.init(rawValue: value)
    }
}

extension Bitboard {
    static func << (lhs: Bitboard, rhs: Bitboard) -> Bitboard {
        let shifted = lhs.rawValue << rhs.rawValue
        return Bitboard(rawValue: shifted)
    }
    
    
    static func >> (lhs: Bitboard, rhs: Bitboard) -> Bitboard {
        let shifted = lhs.rawValue >> rhs.rawValue
        return Bitboard(rawValue: shifted)
    }
    
    static func <<= (lhs: inout Bitboard, rhs: Bitboard) {
        lhs = lhs << rhs
    }
    
    static func >>= (lhs: inout Bitboard, rhs: Bitboard) {
        lhs = lhs >> rhs
    }
    
    static func & (lhs: Bitboard, rhs: Bitboard) -> Bitboard {
        let ANDed = lhs.rawValue & rhs.rawValue
        return Bitboard(rawValue: ANDed)
    }
    
    static func | (lhs: Bitboard, rhs: Bitboard) -> Bitboard {
        let ORed = lhs.rawValue | rhs.rawValue
        return Bitboard(rawValue: ORed)
    }
    
    static func ^ (lhs: Bitboard, rhs: Bitboard) -> Bitboard {
        let XORed = lhs.rawValue ^ rhs.rawValue
        return Bitboard(rawValue: XORed)
    }
    
    static func > (lhs: Bitboard, rhs: Bitboard) -> Bool {
        lhs.rawValue > rhs.rawValue
    }
    
    static func < (lhs: Bitboard, rhs: Bitboard) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

extension Bitboard {
    struct Masks {
        static let notFileA: Bitboard = 0xfefefefefefefefe
        static let notFileH: Bitboard = 0x7f7f7f7f7f7f7f7f
    }
}

extension Bitboard: CustomStringConvertible {
    
    var description: String {
        return rawValue.words.reduce(into: "") {
            $0.append(contentsOf: repeatElement("0", count: $1.leadingZeroBitCount))
            if $1 != 0 {
                $0.append(String($1, radix: 2))
            }
        }
    }
    
    var ascii: String {
        var board = String()
        var row = [Character]()
        for b in description {
            row.append(b)
            if row.count == 8 {
                board += String(row.reversed()) + "\n"
                row.removeAll()
            }
        }
        return board
    }
    
}
