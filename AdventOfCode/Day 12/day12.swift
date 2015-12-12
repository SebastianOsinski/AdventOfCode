//
//  day12.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 12.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

func day12() {
    let inputPath = NSBundle.mainBundle().pathForResource("day12_input", ofType: "json")
    let json = try! String(contentsOfFile: inputPath!)
    
    let pattern = "(-)?[0-9]+"
    let regexp = try! NSRegularExpression(pattern: pattern, options: [])
    
    let matches = regexp.matchesInString(json, options: [], range: NSMakeRange(0, json.characters.count))
    
    let nsJson = json as NSString
    
    var sum = 0
    
    for match in matches {
        let matchedString = nsJson.substringWithRange(match.range)
        if let num = Int(matchedString) {
            sum += num
        }
    }
    
    print(sum)
}