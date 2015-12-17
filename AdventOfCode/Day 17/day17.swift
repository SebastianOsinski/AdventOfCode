//
//  day17.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 17.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

private func getContainers() -> [Int] {
    let inputPath = NSBundle.mainBundle().pathForResource("day17_input", ofType: nil)
    let lines = try! String(contentsOfFile: inputPath!).componentsSeparatedByString("\n")
    
    return lines.map { Int($0)! }
}

func day17() {
    let amount = 150
    let containers = getContainers()
    
    let possibleCombinations = containers.allSubarrays.filter { $0.reduce(0, combine: +) == amount }
    let minCombinationCount = possibleCombinations.minElement { $0.count < $1.count }!.count
    
    print(possibleCombinations.count)
    print(possibleCombinations.filter { $0.count == minCombinationCount }.count)
}