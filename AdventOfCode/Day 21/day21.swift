//
//  day21.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 21.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

class Warrior {
    
    var hitPoints: Int
    let damage: Int
    var armor: Int
    
    init(hitPoints: Int, damage: Int, armor: Int) {
        self.hitPoints = hitPoints
        self.damage = damage
        self.armor = armor
    }
    
    func damageBy(attacker: Warrior) {
        var dmg = attacker.damage - self.armor
        if dmg <= 0 {
            dmg = 1
        }
        hitPoints -= dmg
    }
    
    var isDead: Bool {
        return hitPoints <= 0
    }
    
}

struct Item {
    
    let cost: Int
    let damage: Int
    let armor: Int
}

private func allPossibleWarriorsAndCosts() -> [(warrior: Warrior, cost: Int)] {
    let hitPoints = 100
    
    let weapons = [Item(cost: 8, damage: 4, armor: 0),
                    Item(cost: 10, damage: 5, armor: 0),
                    Item(cost: 25, damage: 6, armor: 0),
                    Item(cost: 40, damage: 7, armor: 0),
                    Item(cost: 74, damage: 8, armor: 0)]
    
    let armors = [Item(cost: 13, damage: 0, armor: 1),
                    Item(cost: 31, damage: 0, armor: 2),
                    Item(cost: 53, damage: 0, armor: 3),
                    Item(cost: 75, damage: 0, armor: 4),
                    Item(cost: 102, damage: 0, armor: 5),
                    Item(cost: 0, damage: 0, armor: 0)]
    
    let rings = [Item(cost: 25, damage: 1, armor: 0),
                    Item(cost: 50, damage: 2, armor: 0),
                    Item(cost: 100, damage: 3, armor: 0),
                    Item(cost: 20, damage: 0, armor: 1),
                    Item(cost: 40, damage: 0, armor: 2),
                    Item(cost: 80, damage: 0, armor: 3)]
    
    let ringsSets = rings.allSubarrays.filter { $0.count <= 2 }
    
    var warriorsAndCosts = [(warrior: Warrior, cost: Int)]()
    
    for weapon in weapons {
        for armor in armors {
            for rings in ringsSets {
                let totalCost = weapon.cost + armor.cost + rings.map { $0.cost }.reduce(0, combine: +)
                let totalDamage = weapon.damage + armor.damage + rings.map { $0.damage }.reduce(0, combine: +)
                let totalArmor = weapon.armor + armor.armor + rings.map { $0.armor }.reduce(0, combine: +)
                
                warriorsAndCosts.append((Warrior(hitPoints: hitPoints, damage: totalDamage, armor: totalArmor), totalCost))
            }
        }
    }
    
    return warriorsAndCosts
}

private func battle(warrior1 warrior1: Warrior, warrior2: Warrior) {
    
    while true {
        warrior2.damageBy(warrior1)
        if warrior2.isDead {
            return
        }
        warrior1.damageBy(warrior2)
        if warrior1.isDead {
            return
        }
    }
}

func day21() {
    let playersAndCosts = allPossibleWarriorsAndCosts()
    
    var minCostWithWin = Int.max
    var maxCostWithLose = 0
    
    for (player, cost) in playersAndCosts {
        let boss = Warrior(hitPoints: 104, damage: 8, armor: 1)
        battle(warrior1: player, warrior2: boss)
        
        if cost < minCostWithWin && !player.isDead {
            minCostWithWin = cost
        }
        
        if cost > maxCostWithLose && player.isDead {
            maxCostWithLose = cost
        }
        
    }
    
    print(minCostWithWin)
    print(maxCostWithLose)
}