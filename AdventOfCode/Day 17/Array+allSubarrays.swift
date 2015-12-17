//
//  Array+allSubarrays.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 17.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

extension Array {
    
    func filterByIndex(@noescape includeElement: (Int) throws -> Bool) rethrows -> [Array.Generator.Element] {
        return try self.enumerate().filter { try includeElement($0.index) }.map { $0.element }
    }
    
    var allSubarrays: [[Element]] {
        let noOfSubarrays: UInt = 1 << UInt(self.count)
        var subarrays = [[Element]]()
        
        for i in 0..<noOfSubarrays {
            let subarray = self.filterByIndex { (i >> UInt($0)) % 2 == 1 }
            subarrays.append(subarray)
        }
        
        return subarrays
    }
    
}