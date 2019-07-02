//
//  File 2.swift
//  
//
//  Created by Magnus Jensen on 27/06/2019.
//

import Foundation

enum Rank: Int {
    case one = 1, two, three, four, five, six, seven, eight
}

extension Rank: CaseIterable { }
