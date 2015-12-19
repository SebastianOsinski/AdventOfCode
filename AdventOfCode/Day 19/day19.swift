//
//  day19.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 19.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

typealias Replacement = (from: String, to: String)

private func getMoleculeAndReplacements() -> (molecule: String, replacements: [Replacement]) {
    let inputPath = NSBundle.mainBundle().pathForResource("day19_input", ofType: nil)
    var lines = try! String(contentsOfFile: inputPath!).componentsSeparatedByString("\n")
    
    
    let molecule = lines.removeLast()
    lines.removeLast()
    
    let replacements = lines.map { (line) -> Replacement  in
        let components = line.componentsSeparatedByString(" => ")
        return (from: components[0], to: components[1])
    }
    
    return (molecule: molecule, replacements: replacements)
}

func day19_1() {
    let (molecule, replacements) = getMoleculeAndReplacements()
    
    var createdMolecules = Set<String>()
    
    for replacement in replacements {
        createdMolecules.unionInPlace(molecule.allStringsByReplacing(replacement.from, withString: replacement.to))
    }
    
    print(createdMolecules.count)
}

extension String {
    
    func allStringsByReplacing(substring: String, withString replacement: String) -> [String] {
        let pattern = try! NSRegularExpression(pattern: substring, options: [])
        let matches = pattern.matchesInString(self, options: [], range: NSMakeRange(0, self.characters.count))
        
        let ranges = matches.map { $0.range }
        
        return ranges.map { (range) -> String in
            return (self as NSString).stringByReplacingCharactersInRange(range, withString: replacement)
        }
    }
}


class MinimumFinder {
    
    private var currentMinimum = Int.max
    private let replacements: [Replacement]
    private let molecule: String
    
    init(molecule: String, replacements: [Replacement]) {
        self.molecule = molecule
        self.replacements = replacements
    }
    
    private func finderHelper(molecules: [String], deepness: Int) {
        guard molecules.count > 0 && deepness < currentMinimum else {
            return
        }
        
        for molecule in molecules {
            if molecule == "e" {
                currentMinimum = deepness
                print(currentMinimum)
            }
            
            for replacement in replacements {
                let subMolecules = molecule.allStringsByReplacing(replacement.to, withString: replacement.from)
                finderHelper(subMolecules, deepness: deepness + 1)
            }
        }
    }
    
    func findMinimum() -> Int {
        finderHelper([molecule], deepness: 0)
        return currentMinimum
    }
}

func day19_2() {
    let (molecule, replacements) = getMoleculeAndReplacements()
    let finder = MinimumFinder(molecule: molecule, replacements: replacements)
    
    let minimum = finder.findMinimum()
    
    print(minimum)
}