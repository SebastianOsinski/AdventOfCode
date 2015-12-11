//
//  day8.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 10.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

func day8_1() {
    let inputPath = NSBundle.mainBundle().pathForResource("day8_input", ofType: nil)
    let lines = try! String(contentsOfFile: inputPath!).componentsSeparatedByString("\n")
    
    var totalNumberOfCharacters = 0
    var totalNumberOfCharactersInMemory = 0
    
    for line in lines {
        totalNumberOfCharacters += line.characters.count
        
        var numberOfCharactersInMemory = 0
        var escaped = false
        var hexEscaped = false
        var hexEscapedCount = 0
        for char in line.characters {
            switch char {
            case "\"" where !escaped:
                break
            case "\\" where !escaped:
                escaped = true
            case "x" where escaped:
                hexEscaped = true
                numberOfCharactersInMemory += 1
            case _ where hexEscaped && hexEscapedCount < 2:
                hexEscapedCount += 1
                if hexEscapedCount == 2 {
                    hexEscapedCount = 0
                    hexEscaped = false
                    escaped = false
                }
            default:
                escaped = false
                numberOfCharactersInMemory += 1
            }
        }
        
        totalNumberOfCharactersInMemory += numberOfCharactersInMemory
    }
    
    print(totalNumberOfCharacters)
    print(totalNumberOfCharactersInMemory)
    print(totalNumberOfCharacters - totalNumberOfCharactersInMemory)
}