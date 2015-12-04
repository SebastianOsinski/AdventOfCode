//
//  day4.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 04.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

func day4() {
    let input = "iwrupvqb"
    
    var suffix = 0
    
    while !(input + "\(suffix)").md5().hasPrefix("00000") {
        suffix++
    }
    
    print(suffix)
}