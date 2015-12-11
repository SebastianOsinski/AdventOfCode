//
//  day8_2.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 11.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

func day8_2() {
    let inputPath = NSBundle.mainBundle().pathForResource("day8_input", ofType: nil)
    let lines = try! String(contentsOfFile: inputPath!).componentsSeparatedByString("\n")
    
    var totalNumberOfCharacters = 0
    var totalNumberOfCharactersInRepresentation = 0
    
    for line in lines {
        totalNumberOfCharacters += line.characters.count
        
        var numberOfCharactersInRepresentation = 2
        for char in line.characters {
            switch char {
            case "\"", "\\":
                numberOfCharactersInRepresentation += 2
            default:
                numberOfCharactersInRepresentation += 1
            }
        }
        
        totalNumberOfCharactersInRepresentation += numberOfCharactersInRepresentation
    }
    
    print(totalNumberOfCharacters)
    print(totalNumberOfCharactersInRepresentation)
    print(totalNumberOfCharactersInRepresentation - totalNumberOfCharacters)
}
