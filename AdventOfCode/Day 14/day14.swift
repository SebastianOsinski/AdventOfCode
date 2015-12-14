//
//  day14.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 14.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

struct Reindeer {
    let topSpeed: Int
    let topSpeedTime: Int
    let restTime: Int
    
    func distanceAfter(var time: Int) -> Int {
        var distance = 0
        var rest = false
        
        while time > 0 {
            if rest {
                time -= restTime
                rest = false
            } else {
                if time >= topSpeedTime {
                    time -= topSpeedTime
                    distance += topSpeed * topSpeedTime
                } else {
                    distance += time * topSpeedTime
                    time = 0
                }
                rest = true
            }
        }
        
        return distance
    }
}

func day14_1() {
    let inputPath = NSBundle.mainBundle().pathForResource("day14_input", ofType: nil)
    let lines = try! String(contentsOfFile: inputPath!).componentsSeparatedByString("\n")
    
    var reindeers = [Reindeer]()
    let time = 2503
    
    for line in lines {
        let components = line.componentsSeparatedByString(" ")
        
        let topSpeed = Int(components[3])!
        let topSpeedTime = Int(components[6])!
        let restTime = Int(components[components.count - 2])!
        
        reindeers.append(Reindeer(topSpeed: topSpeed, topSpeedTime: topSpeedTime, restTime: restTime))
    }
    
    let distances = reindeers.map { $0.distanceAfter(time) }
    
    print(distances.maxElement()!)
}