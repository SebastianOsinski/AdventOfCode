//
//  day6_1.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 09.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

typealias Position = (x: Int, y: Int)

struct LightGrid {
    
    private var lights: [[Bool]]
    private static let dim = 1000
    
    init() {
        lights = Array(count: LightGrid.dim, repeatedValue: Array(count: LightGrid.dim, repeatedValue: false))
    }
    
    mutating private func setState(from from: Position, to: Position, state: Bool) {
        for x in from.x...to.x {
            for y in from.y...to.y {
                lights[x][y] = state
            }
        }
    }
    
    mutating func turnOn(from from: Position, to: Position) {
        setState(from: from, to: to, state: true)
    }
    
    mutating func turnOff(from from: Position, to: Position) {
        setState(from: from, to: to, state: false)
    }
    
    mutating func toggle(from from: Position, to: Position) {
        for x in from.x...to.x {
            for y in from.y...to.y {
                lights[x][y] = !lights[x][y]
            }
        }
    }
    
    var litCount: Int {
        return lights.flatMap { $0.map { $0 ? 1 : 0 } }.reduce(0, combine: +)
    }
    
}


func day6_1() {
    let inputPath = NSBundle.mainBundle().pathForResource("day6_input", ofType: nil)
    let instructions = try! String(contentsOfFile: inputPath!).componentsSeparatedByString("\n")
    
    var grid = LightGrid()
    
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
    
    print(grid.litCount)
}