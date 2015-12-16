//
//  day16.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 16.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

private func getAuntsInfos() -> [[String: Int]] {
    let inputPath = NSBundle.mainBundle().pathForResource("day16_input", ofType: nil)
    let lines = try! String(contentsOfFile: inputPath!).componentsSeparatedByString("\n")
    
    let pattern = try! NSRegularExpression(pattern: "Sue [0-9]+: ", options: [])
    
    let infos = lines.map { (line) -> [String: Int] in
        let componentsString = pattern.stringByReplacingMatchesInString(line, options: [], range: NSMakeRange(0, line.characters.count), withTemplate: "")
        
        let attributes = componentsString.componentsSeparatedByString(", ")
        
        var attributesDictionary = [String: Int]()
        
        attributes.forEach { (attribute) -> () in
            let attributeComponents = attribute.componentsSeparatedByString(": ")
            let key = attributeComponents[0]
            let value = Int(attributeComponents[1])!
            
            attributesDictionary[key] = value
        }
        return attributesDictionary
    }
    
    return infos
}

func day16_1() {
    let attributes = ["children": 3,
                    "cats": 7,
                    "samoyeds": 2,
                    "pomeranians": 3,
                    "akitas": 0,
                    "vizslas": 0,
                    "goldfish": 5,
                    "trees": 3,
                    "cars": 2,
                    "perfumes": 1]
    
    let auntsInfos = getAuntsInfos()
    
    outer: for (index, info) in auntsInfos.enumerate() {
        for (key, value) in attributes {
            if let infoValue = info[key] where infoValue != value {
                continue outer
            }
        }
        print("\(index + 1)")
        break
    }
}

func day16_2() {
    let attributes = ["children": 3,
        "cats": 7,
        "samoyeds": 2,
        "pomeranians": 3,
        "akitas": 0,
        "vizslas": 0,
        "goldfish": 5,
        "trees": 3,
        "cars": 2,
        "perfumes": 1]
    
    let auntsInfos = getAuntsInfos()
    
    outer: for (index, info) in auntsInfos.enumerate() {
        for (key, value) in attributes {
            let predicate: (Int, Int) -> Bool
            
            switch key {
            case "cats", "trees":
                predicate = (>)
            case "pomeranians", "goldfish":
                predicate = (<)
            default:
                predicate = (==)
            }
            
            if let infoValue = info[key] where !predicate(infoValue, value) {
                continue outer
            }
        }
        print("\(index + 1)")
        break
    }
}