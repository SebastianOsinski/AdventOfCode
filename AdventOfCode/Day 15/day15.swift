//
//  day15.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 15.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

struct Ingredient {
    let capacity: Int
    let durability: Int
    let flavor: Int
    let texture: Int
    let calories: Int
}

infix operator * { associativity left precedence 150 }

private func *(array1: [Int], array2: [Int]) -> Int? {
    guard array1.count == array2.count else {
        return nil
    }
    
    var result = 0
    
    for i in 0..<array1.count {
        result += array1[i] * array2[i]
    }
    
    return result
}

private func getIngredients() -> [Ingredient] {
    let inputPath = NSBundle.mainBundle().pathForResource("day15_input", ofType: nil)
    let lines = try! String(contentsOfFile: inputPath!).componentsSeparatedByString("\n")
    
    let regexp = try! NSRegularExpression(pattern: "-?[0-9]", options: [])
    
    let ingredients = lines.map { (line) -> Ingredient in
        let matches = regexp.matchesInString(line, options: [], range: NSMakeRange(0, line.characters.count))
        let matchedStrings = matches.map { (line as NSString).substringWithRange($0.range) }
        
        let matchedValues = matchedStrings.map { Int($0)! }
        
        return Ingredient(capacity: matchedValues[0], durability: matchedValues[1], flavor: matchedValues[2], texture: matchedValues[3], calories: matchedValues[4])
    }
    
    return ingredients
}

private func allArraysWhichSumTo(sum: Int, size: Int) -> [[Int]] {
    guard size > 0 else {
        return [[]]
    }
    
    var arrays = [[Int]]()
    
    for i in 0...sum {
        let subarrays = allArraysWhichSumTo(sum - i, size: size - 1)
        for var subarray in subarrays where subarray.reduce(0, combine: +) == (sum - i) {
            subarray.insert(i, atIndex: 0)
            arrays.append(subarray)
        }
    }
    
    return arrays
}

func day15() {
    let ingredients = getIngredients()
    assert(ingredients.count == 4)
    
    let capacities = ingredients.map { $0.capacity }
    let durabilities = ingredients.map { $0.durability }
    let flavors = ingredients.map { $0.flavor }
    let textures = ingredients.map { $0.texture }
    let calories = ingredients.map { $0.calories }
    
    var maxScore = 0
    let weightsArray = allArraysWhichSumTo(100, size: ingredients.count)
    
    for weights in weightsArray {
        let totalCalories = (calories * weights)!
        
        if totalCalories != 500 {
            continue
        }
        
        let totalCapacity = (capacities * weights).map { $0 >= 0 ? $0 : 0 }!
        let totalDurability = (durabilities * weights).map { $0 >= 0 ? $0 : 0 }!
        let totalFlavor = (flavors * weights).map { $0 >= 0 ? $0 : 0 }!
        let totalTexture = (textures * weights).map { $0 >= 0 ? $0 : 0 }!
        
        let score = totalCapacity * totalDurability * totalFlavor * totalTexture
        
        if score > maxScore {
            maxScore = score
        }
    }
    
    print(maxScore)
}