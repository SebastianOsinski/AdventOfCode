//
//  day9.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 16.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

struct Route: Hashable {
    let cityA: String
    let cityB: String
    
    var hashValue: Int {
        return cityA.hashValue &+ cityB.hashValue
    }
}

func ==(lhs: Route, rhs: Route) -> Bool {
    return (lhs.cityA == rhs.cityA && lhs.cityB == rhs.cityB) ||
            (lhs.cityA == rhs.cityB && lhs.cityB == rhs.cityA)
}

private func getCitiesAndDistances() -> (cities: [String], distances: [Route: Int]) {
    let inputPath = NSBundle.mainBundle().pathForResource("day9_input", ofType: nil)
    let lines = try! String(contentsOfFile: inputPath!).componentsSeparatedByString("\n")
    
    var citiesSet = Set<String>()
    var distances = [Route: Int]()
    
    for line in lines {
        let lineComponents = line.componentsSeparatedByString(" = ")
        let distance = Int(lineComponents[1])!
        
        let routeCities = lineComponents[0].componentsSeparatedByString(" to ")
        citiesSet.insert(routeCities[0])
        citiesSet.insert(routeCities[1])
        
        distances[Route(cityA: routeCities[0], cityB: routeCities[1])] = distance
    }
    
    let cities = Array(citiesSet).sort()
    
    return (cities: cities, distances: distances)
}

private func totalDistanceForRoute(route: [String], distances: [Route: Int]) -> Int {
    guard route.count > 1 else {
        return 0
    }
    var totalDistance = 0
    
    for i in 0..<(route.count - 1) {
        totalDistance += distances[Route(cityA: route[i], cityB: route[i + 1])]!
    }
    
    return totalDistance
}

func day9() {
    let (cities, distances) = getCitiesAndDistances()
    let citiesPermutations = cities.permutations

    var minTotalDistance = Int.max
    var maxTotalDistance = 0
    
    for route in citiesPermutations {
        let totalDistance = totalDistanceForRoute(route, distances: distances)
        
        if totalDistance < minTotalDistance {
            minTotalDistance = totalDistance
        }
        
        if totalDistance > maxTotalDistance {
            maxTotalDistance = totalDistance
        }
    }
    
    print("Shortest total distance: \(minTotalDistance)")
    print("Longest total distance: \(maxTotalDistance)")
}