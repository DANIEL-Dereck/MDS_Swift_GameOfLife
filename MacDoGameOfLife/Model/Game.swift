//
//  Game.swift
//  MacDoGameOfLife
//
//  Created by DANIEL Dereck on 29/09/2020.
//  Copyright © 2020 MDS. All rights reserved.
//

import Foundation

class Game {
    var xMax: Int
    var yMax: Int
    var age: Int = 0
    var world = [[Cell]]()
    var prevGen = [[Cell]]()

    init(raws x : Int, columns y : Int) {
        self.xMax = x
        self.yMax = y
        generateNewWorld()
    }
    
    func generateNewWorld() {
        for x in 0..<xMax {
            var tab = [Cell]()
            for y in 0..<yMax {
                if Int.random(in: 0...2) % 2 == 0 {
                    tab.append(AliveCell(x: x, y: y))
                } else {
                    tab.append(DeadCell(x: x, y: y))
                }
            }
            world.append(tab)
        }
    }
    
    func calculNextGen() {
        prevGen = world
        var newWorld = [[Cell]]()
        
        for x in 0..<xMax {
            var tab = [Cell]()
            for y in 0..<yMax {
                tab.append(newCell(cell: world[x][y]))
            }
            newWorld.append(tab)
        }
       
        self.world = newWorld
    }
    
    func newCell(cell: Cell) -> Cell {
        if let aliveCell = cell as? AliveCell {
            if aliveCell.isAlive(neighbours: calcNeighbourdsFast(x: cell.x, y: cell.y)) {
                return AliveCell(x:cell.x, y:cell.y)
            } else {
                return DeadCell(x:cell.x, y:cell.y)
            }
        } else if let deadCell = cell as? DeadCell {
            if deadCell.isAlive(neighbours: calcNeighbourdsFast(x: cell.x, y: cell.y)) {
                return AliveCell(x:cell.x, y:cell.y)
            } else {
                return DeadCell(x:cell.x, y:cell.y)
            }
        }
        
        return Cell(x:cell.x, y:cell.y)
    }
    
    func calcNeighbourdsFast(x: Int, y: Int) -> Int {
        var result = 0
        for i in -1...1 {
            for j in -1...1 {
                if !(i == 0 && j == 0) {
                    let neiX = x + i
                    let neiY = y + j
                    
                    if neiX < 0 || neiY < 0 {
                        continue
                    }
                    
                    if neiX >= world.count || neiY >= world[0].count {
                        continue
                    }

                    if world[neiX][neiY] is AliveCell {
                        result += 1
                    }
                }
            }
        }
        return result
    }
    
    
    func calcNeighbourds(x: Int, y: Int) -> Int {
        var result : Int = 0
        
        if x > 0 && y > 0 && world[x-1][y-1] is AliveCell {
            result += 1
        }
        
        if y > 0 && world[x][y-1] is AliveCell {
            result += 1
        }
        
        if x < xMax-1 && y > 0 && world[x+1][y-1] is AliveCell {
            result += 1
        }
        
        if x > 0 && world[x-1][y] is AliveCell {
            result += 1
        }
        
        if x < xMax-1 && world[x+1][y] is AliveCell {
            result += 1
        }
        
        if x > 0 && y < yMax-1 && world[x-1][y+1] is AliveCell {
            result += 1
        }
        
        if y < yMax-1 && world[x][y+1] is AliveCell {
            result += 1
        }
        
        if x < xMax-1 && y < yMax-1 && world[x+1][y+1] is AliveCell {
            result += 1
        }

        return result
    }

    func isInfinitPattern() -> Bool
    {
        var result = true
        
        for x in world {
            for y in x {
                if (prevGen[y.x][y.y] is AliveCell && y is AliveCell)
                || (prevGen[y.x][y.y] is DeadCell && y is DeadCell) {
                    continue
                }
                result = false
            }
        }

        return result
    }
    
    func displayWord() {
        print("Génération \(age)")
        for x in world {
            for y in x {
                print("\(y.sign()) ", terminator: "")
            }
            print("")
            print("")
        }
    }

    func play () {
        while true {
            displayWord()
            self.age += 1
            calculNextGen()
            if isInfinitPattern() {
                print("Infinit Static pattern")
                return
            }
            sleep(1)
        }
    }
}
