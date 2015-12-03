//
//  day2.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 03.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

func day2_1() {
    let inputPath = NSBundle.mainBundle().pathForResource("day2_input", ofType: nil)
    let dimensions = try! String(contentsOfFile: inputPath!).componentsSeparatedByString("\n")
    
    let total = dimensions.reduce(0) { (previousTotal, dimString) -> Int in
        
        var dims = dimString.componentsSeparatedByString("x").map { Int($0)! }
        
        let surface = 2 * (dims[0] * dims[1] + dims[1] * dims[2] + dims[0] * dims[2])
        dims.removeAtIndex(dims.indexOf(dims.maxElement()!)!)
        let slack = dims[0] * dims[1]
        
        return previousTotal + surface + slack
    }
    
    print(total)
}

func day2_2() {
    let inputPath = NSBundle.mainBundle().pathForResource("day2_input", ofType: nil)
    let dimensions = try! String(contentsOfFile: inputPath!).componentsSeparatedByString("\n")
    
    let total = dimensions.reduce(0) { (previousTotal, dimString) -> Int in
        
        var dims = dimString.componentsSeparatedByString("x").map { Int($0)! }
        
        let bow = dims.reduce(1, combine: *)
        dims.removeAtIndex(dims.indexOf(dims.maxElement()!)!)
        let ribbon = 2 * (dims[0] + dims[1])
        
        return previousTotal + ribbon + bow
    }
    
    print(total)
}