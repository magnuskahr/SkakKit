//
//  Bitboard.swift
//  
//
//  Created by Magnus Jensen on 02/07/2019.
//

import Foundation

enum BPiece {
    case pawn, bishop, rook, knight, queen, king
}

struct Bitboard {
    
    let color: Color
    let piece: BPiece
    
    init(color: Color, piece: BPiece) {
        self.color = color
        self.piece = piece
    }
    
    private var data: UInt64 = 0
    
    /// Marks a position as occupied, will return wether it was successfull or not
    /// A possition can be marked if the representing value will be higher.
    /// - Parameter file: the file to mark
    /// - Parameter rank: the rank to mark
    mutating func mark(file: File, rank: Rank) -> Bool {
        let markedPosition = position(file: file, rank: rank)
        let newData = data ^ markedPosition
        guard newData > data else {
            return false
        }
        
        data = newData
        return true
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
    internal func position(file: File, rank: Rank) -> UInt64 {
        let exponent = Double(rank.rawValue - 1) * 8 + Double(file.rawValue) - 1
        let value = pow(2.0, exponent)
        return UInt64(value)
    }
}

extension Bitboard {
    struct Masks {
    }
}

extension Bitboard: CustomStringConvertible {
    
    var description: String {
        return data.words.reduce(into: "") {
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
