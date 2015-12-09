//
//  day6_2.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 09.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

struct BrightLightGrid {
    
    private var lights: [[Int]]
    private static let dim = 1000
    
    init() {
        lights = Array(count: BrightLightGrid.dim, repeatedValue: Array(count: BrightLightGrid.dim, repeatedValue: 0))
    }
    
    mutating func turnOn(from from: Position, to: Position) {
        for x in from.x...to.x {
            for y in from.y...to.y {
                lights[x][y] += 1
            }
        }
    }
    
    mutating func turnOff(from from: Position, to: Position) {
        for x in from.x...to.x {
            for y in from.y...to.y where lights[x][y] > 0 {
                lights[x][y] -= 1
            }
        }
    }
    
    mutating func toggle(from from: Position, to: Position) {
        for x in from.x...to.x {
            for y in from.y...to.y {
                lights[x][y] += 2
            }
        }
    }
    
    var totalBrightness: Int {
        return lights.flatMap { $0 }.reduce(0, combine: +)
    }
    
}

func day6_2() {
    let inputPath = NSBundle.mainBundle().pathForResource("day6_input", ofType: nil)
    let instructions = try! String(contentsOfFile: inputPath!).componentsSeparatedByString("\n")
    
    var grid = BrightLightGrid()
    
    for instruction in instructions {
        let separatedInstruction = instruction.componentsSeparatedByString(" through ")
        
        let leftPartSeparated = separatedInstruction[0].componentsSeparatedByString(" ")
        let instructionType: String
        
        if leftPartSeparated.count == 3 {
            instructionType = leftPartSeparated[0...1].joinWithSeparator(" ")
        } else {
            instructionType = leftPartSeparated[0]
        }
        
        let fromStringArray = leftPartSeparated[leftPartSeparated.count - 1].componentsSeparatedByString(",")
        let from = (x: Int(fromStringArray[0])!, y: Int(fromStringArray[1])!)
        
        let toStringArray = separatedInstruction[1].componentsSeparatedByString(",")
        let to = (x: Int(toStringArray[0])!, y: Int(toStringArray[1])!)
        
        switch instructionType {
        case "turn on": grid.turnOn(from: from, to: to)
        case "turn off": grid.turnOff(from: from, to: to)
        default: grid.toggle(from: from, to: to)
        }
    }
    
    print(grid.totalBrightness)
}