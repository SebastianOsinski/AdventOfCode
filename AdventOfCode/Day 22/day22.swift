//
//  day22.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 23.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

class Wizard: Warrior {
    
    var mana: Int
    
    init(mana: Int, hitPoints: Int) {
        self.mana = mana
        super.init(hitPoints: hitPoints, damage: 0, armor: 0)
    }
}

class Battle {

    let player: Wizard
    let enemy: Warrior
    var cost = 0
 
    var effects: [String: (player: Wizard, enemy: Warrior) -> ()] = [:]
    var effectsTimers = [String: UInt]()
    
    init(player: Wizard, enemy: Warrior) {
        self.player = player
        self.enemy = enemy
        
        effects["Shield"] = { (player, enemy) in player.armor += 7 }
        effects["Poisson"] = { (player, enemy) in enemy.hitPoints -= 3 }
        effects["Recharge"] = { (player, enemy) in player.mana += 101 }
        
        effectsTimers["Shield"] = 0
        effectsTimers["Poisson"] = 0
        effectsTimers["Recharge"] = 0
    }
    
    private func execute() {
        while true {
            player.hitPoints -= 1
            if player.isDead {
                return
            }
            
            applyEffects()
            if enemy.isDead {
                return
            }
            
            randomSpell()
            if enemy.isDead || player.isDead {
                return
            }
            
            applyEffects()
            if enemy.isDead {
                return
            }
            
            player.damageBy(enemy)
            if player.isDead {
                return
            }
        }
    }
    
    private let spellCosts = [53, 73, 113, 173, 229]
    
    private func randomSpell() {
        let n = spellCosts.filter { $0 <= player.mana }.count
        
        if n == 0 {
            player.hitPoints = 0
            return
        }
        
        var availableSpells = Array(0.stride(to: n, by: 1))
        
        if effectsTimers["Shield"]! > 0, let i = availableSpells.indexOf(2) {
            availableSpells.removeAtIndex(i)
        }
        
        if effectsTimers["Poisson"]! > 0, let i = availableSpells.indexOf(3) {
            availableSpells.removeAtIndex(i)
        }
        
        if effectsTimers["Recharge"]! > 0, let i = availableSpells.indexOf(4) {
            availableSpells.removeAtIndex(i)
        }
        
        switch availableSpells[Int(arc4random_uniform(UInt32(availableSpells.count)))] {
        case 0:
            cost += 53
            player.mana -= 53
            enemy.hitPoints -= 4
        case 1:
            cost += 73
            player.mana -= 73
            enemy.hitPoints -= 2
            player.hitPoints += 2
        case 2:
            cost += 113
            player.mana -= 113
            effectsTimers["Shield"] = 6
        case 3:
            cost += 173
            player.mana -= 173
            effectsTimers["Poisson"] = 6
        case 4:
            cost += 229
            player.mana -= 229
            effectsTimers["Recharge"] = 5
        default:
            break
        }
    }
    
    private func applyEffects() {
        player.armor = 0
        
        for (name, effect) in effects where effectsTimers[name]! > 0 {
            effect(player: player, enemy: enemy)
            effectsTimers[name]! -= 1
        }
    }
}

func day22() {
    var minCost = Int.max
    
    while true {
        let player = Wizard(mana: 500, hitPoints: 50)
        let boss = Warrior(hitPoints: 55, damage: 8, armor: 0)
        
        let battle = Battle(player: player, enemy: boss)
        battle.execute()
        
        assert(player.isDead != boss.isDead)
        
        if boss.isDead && battle.cost < minCost {
            minCost = battle.cost
            print(minCost)
        }
    }
}