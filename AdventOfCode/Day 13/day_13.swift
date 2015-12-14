//
//  day_13.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 13.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

struct Change: CustomStringConvertible {
    
    let person: String
    let neighbor: String
    let value: Int
    
    init(line: String) {
        let components = line.componentsSeparatedByString(" ")
        
        person = components[0]
        
        let neighborComponent = components[components.count - 1]
        neighbor = neighborComponent.substringToIndex(neighborComponent.endIndex.predecessor())
        
        value = (components[2] == "gain" ? 1 : -1) * Int(components[3])!
    }
    
    var description: String {
        return "\(person) --[\(value)]--> \(neighbor)"
    }
}

struct TotalChange: CustomStringConvertible, Hashable {
    
    let firstPerson: String
    let secondPerson: String
    let value: Int
    
    init?(change1: Change, change2: Change) {
        guard change1.person == change2.neighbor && change2.person == change1.neighbor else {
            return nil
        }
        
        firstPerson = change1.person
        secondPerson = change2.person
        value = change1.value + change2.value
    }
    
    var description: String {
        return "\(firstPerson) <--[\(value)]--> \(secondPerson)"
    }
    
    var hashValue: Int {
        return firstPerson.hashValue &+ secondPerson.hashValue &+ value.hashValue
    }

}

func ==(lhs: TotalChange, rhs: TotalChange) -> Bool {
    return ((lhs.firstPerson == rhs.firstPerson && lhs.secondPerson == rhs.secondPerson) ||
            (lhs.firstPerson == rhs.secondPerson && lhs.secondPerson == rhs.firstPerson)) &&
            lhs.value == rhs.value
}

func day13() {
    let inputPath = NSBundle.mainBundle().pathForResource("day13_input", ofType: nil)
    let lines = try! String(contentsOfFile: inputPath!).componentsSeparatedByString("\n")
    
    let changes = lines.map { Change(line: $0) }
    
    var totalChanges = Set<TotalChange>()
    
    for (index1, change1) in changes.enumerate() {
        for (index2, change2) in changes.enumerate() where index2 != index1 {
            if let totalChange = TotalChange(change1: change1, change2: change2) {
                totalChanges.insert(totalChange)
            }
        }
    }
    print(totalChanges.count)
    totalChanges.forEach { print($0) }
}