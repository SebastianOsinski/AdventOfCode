//
//  day1.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 03.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

func day1_1() {
    let inputPath = NSBundle.mainBundle().pathForResource("day1_input", ofType: nil)
    let directions = try! String(contentsOfFile: inputPath!)
    
    let upCount = directions.characters.filter { $0 == "(" }.count
    let downCount = directions.characters.filter { $0 == ")" }.count
    
    print(upCount - downCount)
}

func day1_2() {
    let inputPath = NSBundle.mainBundle().pathForResource("day1_input", ofType: nil)
    let directions = try! String(contentsOfFile: inputPath!)
    
    let floorChanges = directions.characters.map { $0 == "(" ? 1 : -1 }
    
    var floor = 0
    var stop = 0
    
    for (index, change) in floorChanges.enumerate() {
        floor += change
        
        if floor == -1 {
            stop = index + 1
            break
        }
    }
    
    print(stop)
}