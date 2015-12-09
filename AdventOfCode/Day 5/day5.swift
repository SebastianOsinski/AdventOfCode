//
//  day5.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 05.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation


private extension String {
    private func isNice1() -> Bool {
        var regex = try! NSRegularExpression(pattern: ".*(ab|cd|pq|xy).*", options: [])
        var matches = regex.matchesInString(self, options: [], range: NSMakeRange(0, self.characters.count))
        if matches.count > 0 {
            return false
        }
        
        regex = try! NSRegularExpression(pattern: "[aeiou].*[aeiou].*[aeiou].*", options: [])
        matches = regex.matchesInString(self, options: [], range: NSMakeRange(0, self.characters.count))
        if matches.count == 0 {
            return false
        }
        
        regex = try! NSRegularExpression(pattern: "(.)\\1", options: [])
        matches = regex.matchesInString(self, options: [], range: NSMakeRange(0, self.characters.count))

        return matches.count > 0
    }
    
    private func isNice2() -> Bool {
        var regex = try! NSRegularExpression(pattern: "(..).*\\1", options: [])
        var matches = regex.matchesInString(self, options: [], range: NSMakeRange(0, self.characters.count))
        if matches.count == 0 {
            return false
        }
        
        regex = try! NSRegularExpression(pattern: "(.).\\1", options: [])
        matches = regex.matchesInString(self, options: [], range: NSMakeRange(0, self.characters.count))
        
        return matches.count > 0
    }
}


func day5() {
    let inputPath = NSBundle.mainBundle().pathForResource("day5_input", ofType: nil)
    let words = try! String(contentsOfFile: inputPath!).componentsSeparatedByString("\n")
    
    //let words = ["ugknbfddgicrmopn", "aaa", "jchzalrnumimnmhp", "haegwjzuvuyypxyu", "dvszwmarrgswjxmb"]
    
    let niceWords = words.filter { $0.isNice1() }
    
    print(niceWords.count)
 }