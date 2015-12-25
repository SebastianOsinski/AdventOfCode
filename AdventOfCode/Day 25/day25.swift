//
//  day25.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 25.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

func day25() {
    var code = 20151125
    let multiplier = 252533
    let divisor = 33554393
    
    let row = 2947
    let col = 3029
    
    let n = 1 + ((col - 1) * col) / 2 + row * (row - 1 + 2 * (col - 1)) / 2
    
    for _ in 2...n {
        code = (code * multiplier) % divisor
    }
    print(code)
}