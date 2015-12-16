//
//  day11.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 16.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

private func isValid(password: String) -> Bool {
    guard password.characters.count >= 3 else {
        return false
    }
    
    var consecutiveCharacters = false
    
    for i in 2..<password.unicodeScalars.count {
        let firstSubindex = password.unicodeScalars.startIndex.advancedBy(i - 2)
        
        let a = password.unicodeScalars[firstSubindex].value
        let b = password.unicodeScalars[firstSubindex.advancedBy(1)].value
        let c = password.unicodeScalars[firstSubindex.advancedBy(2)].value
        
        if a == b - 1 && b == c - 1 {
            consecutiveCharacters = true
            break
        }
    }
    if !consecutiveCharacters {
        return false
    }
    
    for character in password.characters {
        if ["i", "o", "l"].contains(character) {
            return false
        }
    }

    let pattern = try! NSRegularExpression(pattern: "(\\w)\\1", options: [])
    if pattern.matchesInString(password, options: [], range: NSMakeRange(0, password.characters.count)).count < 2 {
        return false
    }
    
    return true
}

private extension String {
    
    mutating func increment() {
        guard self.unicodeScalars.endIndex != self.unicodeScalars.startIndex else {
            return
        }
        
        var currentIndex = self.unicodeScalars.endIndex
        let zValue = "z".unicodeScalars.first!.value
        let a = "a".unicodeScalars.first!
        
        repeat {
            currentIndex = currentIndex.predecessor()
            let scalar = self.unicodeScalars[currentIndex]
            
            self.unicodeScalars.removeAtIndex(currentIndex)
            if scalar.value < zValue {
                let newScalar = UnicodeScalar(scalar.value + 1)
                self.unicodeScalars.insert(newScalar, atIndex: currentIndex)
                return
            } else {
                self.unicodeScalars.insert(a, atIndex: currentIndex)
            }
        } while (currentIndex != self.unicodeScalars.startIndex)
    }
}

private func nextPassword(var password: String) -> String {
    repeat {
        password.increment()
    } while !isValid(password)
    
    return password
}

func day11() {
    var password = "cqjxjnds"
    password = nextPassword(password)
    print(password)
    password = nextPassword(password)
    print(password)
}