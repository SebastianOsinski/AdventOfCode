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

private func getPeopleAndChanges() -> (people: [String], changes: [Pair: Int]) {
    let inputPath = NSBundle.mainBundle().pathForResource("day13_input", ofType: nil)
    let lines = try! String(contentsOfFile: inputPath!).componentsSeparatedByString("\n")
    
    var peopleSet = Set<String>()
    var changes = [Pair: Int]()
    
    for line in lines {
        let components = line.componentsSeparatedByString(" ")
        let personA = components[0]
        peopleSet.insert(personA)
        
        let personBComponent = components[components.count - 1]
        let personB = personBComponent.substringToIndex(personBComponent.endIndex.predecessor())
        peopleSet.insert(personB)
        
        let value = (components[2] == "gain" ? 1 : -1) * Int(components[3])!
        
        let pair = Pair(personA: personA, personB: personB)
        
        if let currentValue = changes[pair] {
            changes[pair] = currentValue + value
        } else {
            changes[pair] = value
        }
    }
    
    let people = Array(peopleSet).sort()
    
    return (people: people, changes: changes)
}

private func totalChangeForArrangement(arrangement: [String], changes: [Pair: Int]) -> Int {
    var totalChange = 0
    
    for i in 0..<arrangement.count {
        totalChange += changes[Pair(personA: arrangement[i], personB: arrangement[(i + 1) % arrangement.count])] ?? 0
    }
    
    return totalChange
}

func day13() {
    var (people, changes) = getPeopleAndChanges()
    people.append("Me")
    let arrangements = people.permutations
    
    var maxTotalChange = 0
    
    for arrangement in arrangements {
        let totalChange = totalChangeForArrangement(arrangement, changes: changes)
        if totalChange > maxTotalChange {
            maxTotalChange = totalChange
        }
    }
    
    print(maxTotalChange)
}