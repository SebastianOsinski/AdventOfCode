//
//  day24.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 24.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

func day24() {
    let inputPath = NSBundle.mainBundle().pathForResource("day24_input", ofType: nil)
    let packages =  try! String(contentsOfFile: inputPath!).componentsSeparatedByString("\n").map { Int($0)! }
    
    let groupWeight = packages.reduce(0, combine: +) / 4
    
    var minFirstGroupCount = packages.count
    var minQE = Int.max
    
    outer: while true {
        var shuffledPackages = packages.shuffle()
        var sum = 0
        
        var groupCount = 0
        
        while groupCount < shuffledPackages.count {
            sum += shuffledPackages[groupCount]
            groupCount += 1
            if sum > groupWeight {
                continue outer
            }
            if sum == groupWeight {
                break
            }
        }
        
        if groupCount > minFirstGroupCount {
            continue
        }
        
        let qe = shuffledPackages[0..<groupCount].product()
        
        shuffledPackages.removeFirst(groupCount)
        
        var i = 0
        sum = 0
        while i < shuffledPackages.count {
            sum += shuffledPackages[i]
            i += 1
            if sum > groupWeight {
                continue outer
            }
            if sum == groupWeight {
                break
            }
        }
        
        shuffledPackages.removeFirst(i)
        
        i = 0
        sum = 0
        while i < shuffledPackages.count {
            sum += shuffledPackages[i]
            i += 1
            if sum > groupWeight {
                continue outer
            }
            if sum == groupWeight {
                break
            }
        }
        
        if groupCount < minFirstGroupCount {
            minFirstGroupCount = groupCount
            minQE = qe
            print(minQE)
        } else if qe < minQE {
            minQE = qe
            print(minQE)
        }
        
    }
}

private extension SequenceType where Generator.Element: IntegerType {
    
    func product() -> Generator.Element {
        return self.reduce(1, combine: *)
    }
}

private func randDiscUniform(min: Int, _ max: Int) -> Int {
    return Int(arc4random_uniform(UInt32(max - min + 1))) + min
}

private extension Array {
    
    private func shuffle() -> [Element] {
        var array = self
        for i in 0..<(array.count - 1) {
            let k = randDiscUniform(i, array.count - 1)
            if k != i {
                swap(&array[i], &array[k])
            }
        }
        
        return array
    }
    
}