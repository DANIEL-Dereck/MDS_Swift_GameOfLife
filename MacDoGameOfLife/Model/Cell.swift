//
//  Cell.swift
//  MacDoGameOfLife
//
//  Created by Service Informatique on 29/09/2020.
//  Copyright © 2020 MDS. All rights reserved.
//

import Foundation

class Cell {
    var x : Int
    var y : Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    func sign() -> String {
        return "x"
    }
    
    func isAlive(neighbours : Int) -> Bool {
        return false
    }
}


