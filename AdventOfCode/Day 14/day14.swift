//
//  day14.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 14.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

class Reindeer {
    let topSpeed: Int
    let topSpeedTime: Int
    let restTime: Int
    
    var score: Int = 0
    private var resting: (status: Bool, duration: Int) = (false, 0)
    var distance: Int = 0
    private var topSpeedTravelTime: Int = 0
    
    init(topSpeed: Int, topSpeedTime: Int, restTime: Int) {
        self.topSpeed = topSpeed
        self.topSpeedTime = topSpeedTime
        self.restTime = restTime
    }
    
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
    
    func move() {
        if resting.status {
            resting.duration += 1
            if resting.duration == restTime {
                resting.status = false
                resting.duration = 0
            }
        } else {
            distance += topSpeed
            topSpeedTravelTime += 1
            if topSpeedTravelTime == topSpeedTime {
                topSpeedTravelTime = 0
                resting.status = true
            }
        }
    }
}

private func getReindeers() -> [Reindeer] {
    let inputPath = NSBundle.mainBundle().pathForResource("day14_input", ofType: nil)
    let lines = try! String(contentsOfFile: inputPath!).componentsSeparatedByString("\n")
    
    var reindeers = [Reindeer]()
    
    for line in lines {
        let components = line.componentsSeparatedByString(" ")
        
        let topSpeed = Int(components[3])!
        let topSpeedTime = Int(components[6])!
        let restTime = Int(components[components.count - 2])!
        
        reindeers.append(Reindeer(topSpeed: topSpeed, topSpeedTime: topSpeedTime, restTime: restTime))
    }
    
    return reindeers
}

func day14_1() {
    let reindeers = getReindeers()
    let time = 2503
    
    let distances = reindeers.map { $0.distanceAfter(time) }
    
    print(distances.maxElement()!)
}

func day14_2() {
    let reindeers = getReindeers()
    let time = 2503
    
    for _ in 1...time {
        reindeers.forEach { $0.move() }
        let currentMaxDistance = reindeers.map { $0.distance }.maxElement()!
        reindeers.filter { $0.distance == currentMaxDistance }.forEach { $0.score++ }
    }
    
    print(reindeers.map { $0.score }.maxElement())
}