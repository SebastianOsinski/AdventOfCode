//
//  day3.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 03.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

private func visitedHouses(directions: String, var visitedPositions: [(x: Int, y: Int)]! = nil) -> [(x: Int, y: Int)] {
    var pos = (x: 0, y: 0)
    
    if visitedPositions == nil {
        visitedPositions = [(x: Int, y: Int)]()
        
        visitedPositions.append(pos)
    }
    
    for char in directions.characters {
        
        switch char {
        case "v":
            pos.y--
        case "^":
            pos.y++
        case ">":
            pos.x++
        case "<":
            pos.x--
        default:
            continue
        }
        
        if !visitedPositions.contains({ $0.x == pos.x && $0.y == pos.y }) {
            visitedPositions.append(pos)
        }
    }
    
    return visitedPositions
}

func day3_1() {
    let inputPath = NSBundle.mainBundle().pathForResource("day3_input", ofType: nil)
    let directions = try! String(contentsOfFile: inputPath!)
    
    print(visitedHouses(directions).count)
}

func day3_2() {
    let inputPath = NSBundle.mainBundle().pathForResource("day3_input", ofType: nil)
    let directions = try! String(contentsOfFile: inputPath!)
    
    let realSantaDirections = String(directions.characters.enumerate().filter { $0.index % 2 == 0 }.map { $0.element })
    let roboSantaDirections = String(directions.characters.enumerate().filter { $0.index % 2 == 1 }.map { $0.element })
    
    print(visitedHouses(roboSantaDirections, visitedPositions: visitedHouses(realSantaDirections)).count)
}