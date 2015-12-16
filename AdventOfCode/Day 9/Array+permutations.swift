//
//  Array+permutations.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 16.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

extension Array {
    
    var permutations: [[Element]] {
        guard self.count > 0 else {
            return [[]]
        }
        
        var results = [[Element]]()
        
        for i in 0..<self.count {
            var copy = self
            let element = copy.removeAtIndex(i)
            let subPermutations = copy.permutations
            
            for var subPermutation in subPermutations {
                subPermutation.insert(element, atIndex: 0)
                results.append(subPermutation)
            }
        }
        
        return results
    }
}
