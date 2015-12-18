//
//  day18.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 18.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

struct AnimatedLightGrid: CustomStringConvertible {
    
    typealias Bulb = (x: Int, y: Int)
    
    var lightsStates: [[Bool]]
    let rows: Int
    let columns: Int
    
    init(withString string: String) {
        let lines = string.componentsSeparatedByString("\n")
        let grid = lines.map { Array<Character>($0.characters) }
        
        lightsStates = [[Bool]](count: grid.count + 2, repeatedValue: [Bool](count: grid[0].count + 2, repeatedValue: false))
        rows = grid.count
        columns = grid[0].count
        
        for x in 0..<grid.count {
            for y in 0..<grid[0].count {
                lightsStates[x + 1][y + 1] = (grid[x][y] == "#")
            }
        }
        
        stuck()
    }
    
    private func numberOfOnNeighborsForBulb(bulb : Bulb) -> Int {
        let (x, y) = bulb
        
        let firstPart = lightsStates[x - 1][y - 1].intValue +
                        lightsStates[x][y - 1].intValue +
                        lightsStates[x + 1][y - 1].intValue +
                        lightsStates[x + 1][y].intValue
        
        let secondPart = lightsStates[x + 1][y + 1].intValue +
                        lightsStates[x][y + 1].intValue +
                        lightsStates[x - 1][y + 1].intValue +
                        lightsStates[x - 1][y].intValue

        
        return firstPart + secondPart
    }
    
    mutating private func stuck() {
        lightsStates[1][1] = true
        lightsStates[1][columns] = true
        lightsStates[rows][1] = true
        lightsStates[rows][columns] = true
    }
    
    mutating private func animateStep() {
        var lightsStatesCopy = lightsStates
        
        for x in 1...rows {
            for y in 1...columns {
                let bulb = (x: x, y: y)
                
                let noOfOnNeighbors = numberOfOnNeighborsForBulb(bulb)
                
                if lightsStates[x][y] {
                    lightsStatesCopy[x][y] = (2...3 ~= noOfOnNeighbors)
                } else {
                    lightsStatesCopy[x][y] = (noOfOnNeighbors == 3)
                }
            }
        }
        
        lightsStates = lightsStatesCopy
        stuck()
    }
    
    mutating func animateTimes(times: Int) {
        print(self)
        print("\n")
        for _ in 1...times {
            animateStep()
            print(self)
            print("\n")
        }
    }
    
    func onBulbsCount() -> Int {
        return lightsStates.flatMap { $0.map { $0.intValue } }.reduce(0, combine: +)
    }
    
    var description: String {
        return lightsStates.map { $0[1...rows].map { $0 ? "#" : "." }.joinWithSeparator("") }[1...columns].joinWithSeparator("\n")
    }
}

func day18() {
    let inputPath = NSBundle.mainBundle().pathForResource("day18_input", ofType: nil)
    let string = try! String(contentsOfFile: inputPath!)
    
    var grid = AnimatedLightGrid(withString: string)
    
    grid.animateTimes(100)
    print(grid.onBulbsCount())
}