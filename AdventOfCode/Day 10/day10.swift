//
//  day10.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 10.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

private func lookAndSay(input: String) -> String {
    guard var currentDigit = input.characters.first else {
        return ""
    }
    
    var output = ""
    var currentDigitCount = 0
    
    for digit in input.characters {
        if digit == currentDigit {
            currentDigitCount += 1
        } else {
            output.appendContentsOf("\(currentDigitCount)")
            output.append(currentDigit)
            currentDigit = digit
            currentDigitCount = 1
        }
    }
    output.appendContentsOf("\(currentDigitCount)")
    output.append(currentDigit)
    
    return output
}

func day10() {
    var input = "3113322113"
    
    for _ in 1...50 {
        input = lookAndSay(input)
    }
    
    print(input.characters.count)
}