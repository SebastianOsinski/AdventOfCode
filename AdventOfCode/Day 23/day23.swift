//
//  day23.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 23.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation


func day23() {
    let inputPath = NSBundle.mainBundle().pathForResource("day23_input", ofType: nil)
    var instructions: [[String]] = try! String(contentsOfFile: inputPath!).componentsSeparatedByString("\n").map { instruction in
        var components = instruction.componentsSeparatedByString(" ")
        if components.count == 3 {
            components[1] = components[1].stringByReplacingOccurrencesOfString(",", withString: "")
        }
        return components
    }

    var registers: [String: UInt] = ["a": 0, "b": 0]
    
    var counter = 0
    
    registers["a"] = 1
    
    while counter < instructions.count {
        let instruction = instructions[counter]
        
        switch instruction[0] {
        case "hlf":
            let r = instruction[1]
            registers[r]! /= 2
            counter += 1
        case "tpl":
            let r = instruction[1]
            registers[r]! *= 3
            counter += 1
        case "inc":
            let r = instruction[1]
            registers[r]! += 1
            counter += 1
        case "jmp":
            let offset = Int(instruction[1])!
            counter += offset
        case "jie":
            let r = instruction[1]
            let offset = Int(instruction[2])!
            
            if registers[r]! % 2 == 0 {
                counter += offset
            } else {
                counter += 1
            }
        case "jio":
            let r = instruction[1]
            let offset = Int(instruction[2])!
            
            if registers[r]! == 1 {
                counter += offset
            } else {
                counter += 1
            }
        default:
            print("Instruction not supported")
            return
        }
    }
    print(registers["b"])
}