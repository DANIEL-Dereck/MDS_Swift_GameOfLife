//
//  DeadCell.swift
//  MacDoGameOfLife
//
//  Created by Service Informatique on 29/09/2020.
//  Copyright © 2020 MDS. All rights reserved.
//

import Foundation

class DeadCell : Cell {
    var deathRules: [Int : Bool] = [0 : false, 1 : false, 2 : false, 3 : true, 4 : false, 5 : false, 6 : false, 7 : false]

    override func sign() -> String {
        return "-"
    }
    
    override func isAlive(neighbours: Int) -> Bool {
        return deathRules[neighbours]!;
    }
}

