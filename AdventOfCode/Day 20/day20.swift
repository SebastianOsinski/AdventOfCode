//
//  day20.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 20.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

func day20_1() {
    let input = 36_000_000
    let numberOfHouses = 1_000_000
    var houses = [Int](count: numberOfHouses, repeatedValue: 0)
    
    for elf in 1...houses.count {
        for houseNumber in (elf - 1).stride(to: houses.count, by: elf) {
            houses[houseNumber] += elf * 10
        }
        
        if houses[elf - 1] >= input {
            print(elf)
            break
        }
    }
}

func day20_2() {
    let input = 36_000_000
    let numberOfHouses = 1_000_000
    var houses = [Int](count: numberOfHouses, repeatedValue: 0)
    
    for elf in 1...houses.count {
        for houseNumber in (elf - 1).stride(to: houses.count, by: elf).prefix(50) {
            houses[houseNumber] += elf * 11
        }
        
        if houses[elf - 1] >= input {
            print(elf)
            break
        }
    }
}