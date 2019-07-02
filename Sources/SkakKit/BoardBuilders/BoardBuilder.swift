//
//  File 2.swift
//  
//
//  Created by Magnus Jensen on 27/06/2019.
//

import Foundation

protocol BoardBuilder {
    func construct() -> [Position: Piece]
}
