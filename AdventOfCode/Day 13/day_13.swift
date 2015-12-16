//
//  day_13.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 13.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

struct Pair: Hashable {
    
    let personA: String
    let personB: String
    
    var hashValue: Int {
        return personA.hashValue &+ personB.hashValue
    }
}

func ==(lhs: Pair, rhs: Pair) -> Bool {
    return ((lhs.personA == rhs.personA && lhs.personB == rhs.personB) ||
        (lhs.personA == rhs.personB && lhs.personB == rhs.personA))
}

private func getChanges() -> [Pair: Int] {
    let inputPath = NSBundle.mainBundle().pathForResource("day13_input", ofType: nil)
    let lines = try! String(contentsOfFile: inputPath!).componentsSeparatedByString("\n")
    
    var changes = [Pair: Int]()
    
    for line in lines {
        let components = line.componentsSeparatedByString(" ")
        let personA = components[0]
        
        let personBComponent = components[components.count - 1]
        let personB = personBComponent.substringToIndex(personBComponent.endIndex.predecessor())
        
        let value = (components[2] == "gain" ? 1 : -1) * Int(components[3])!
        
        let pair = Pair(personA: personA, personB: personB)
        
        if let currentValue = changes[pair] {
            changes[pair] = currentValue + value
        } else {
            changes[pair] = value
        }
    }
    
    return changes
}

func day13() {
    let changes = getChanges()
    print(changes)
    
}