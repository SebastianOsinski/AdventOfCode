//
//  day12_2.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 12.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

func sumWithoutRed(json: JSON, inout sum: Int) {
    if let num = json.int {
        sum += num
        return
    }
    if let jsonArray = json.array {
        for jsonElement in jsonArray {
            sumWithoutRed(jsonElement, sum: &sum)
        }
        return
    }
    if let jsonDict = json.dictionary where !jsonDict.values.contains("red") {
        for subJson in jsonDict.values {
            sumWithoutRed(subJson, sum: &sum)
        }
    }
}

func day12_2() {
    let inputPath = NSBundle.mainBundle().pathForResource("day12_input", ofType: "json")
    let jsonData = NSData(contentsOfFile: inputPath!)!
    let json = JSON(data: jsonData)
    
    var sum = 0
    sumWithoutRed(json, sum: &sum)
    
    print(sum)
}