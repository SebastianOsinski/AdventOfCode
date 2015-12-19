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
        let pattern = try! NSRegularExpression(pattern: replacement.from, options: [])
        let matches = pattern.matchesInString(molecule, options: [], range: NSMakeRange(0, molecule.characters.count))
        
        let ranges = matches.map { $0.range }
        
        ranges.forEach { (range) -> () in
            let createdMolecule = (molecule as NSString).stringByReplacingCharactersInRange(range, withString: replacement.to)
            
            createdMolecules.insert(createdMolecule)
        }
    }
    
    print(createdMolecules.count)
}