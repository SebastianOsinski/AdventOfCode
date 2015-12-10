//
//  day7.swift
//  AdventOfCode
//
//  Created by Sebastian Osiński on 09.12.2015.
//  Copyright © 2015 Sebastian Osiński. All rights reserved.
//

import Foundation

protocol Gate {
    func execute(inout wires: [String: UInt16]) -> Bool
}

struct BinaryGate: Gate {
    
    let rightInputWire: String
    let leftInputWire: String
    let outputWire: String
    let operation: (UInt16, UInt16) -> UInt16
    
    func execute(inout wires: [String: UInt16]) -> Bool {
        guard let rightValue = wires[rightInputWire], leftValue = wires[leftInputWire] else {
            return false
        }
        wires[outputWire] = operation(rightValue, leftValue)
        
        return true
    }
}

struct UnaryGate: Gate {
    
    let inputWire: String
    let outputWire: String
    let operation: UInt16 -> UInt16
    
    func execute(inout wires: [String: UInt16]) -> Bool {
        guard let inputValue = wires[inputWire] else {
            return false
        }
        wires[outputWire] = operation(inputValue)
        
        return true
    }
}

struct InsertGate: Gate {
    
    let outputWire: String
    let value: UInt16
    
    func execute(inout wires: [String : UInt16]) -> Bool {
        wires[outputWire] = value
        
        return true
    }
}

private func createGate(instruction: String) -> Gate? {
    let instructionParts = instruction.componentsSeparatedByString(" -> ")
    let outputWire = instructionParts[1]
    
    let operationParts = instructionParts[0].componentsSeparatedByString(" ")
    
    switch operationParts.count {
    case 1:
        if let value = UInt16(operationParts[0]) {
            return InsertGate(outputWire: outputWire, value: value)
        } else {
            return UnaryGate(inputWire: operationParts[0], outputWire: outputWire, operation: {$0})
        }

    case 2 where operationParts[0] == "NOT":
        let inputWire = operationParts[1]
        return UnaryGate(inputWire: inputWire, outputWire: outputWire, operation: ~)
    case 3 where operationParts[1] == "RSHIFT":
        let inputWire = operationParts[0]
        let shift = UInt16(operationParts[2])!
        return UnaryGate(inputWire: inputWire, outputWire: outputWire, operation: { [shift] input in return input >> shift })
    case 3 where operationParts[1] == "LSHIFT":
        let inputWire = operationParts[0]
        let shift = UInt16(operationParts[2])!
        return UnaryGate(inputWire: inputWire, outputWire: outputWire, operation: { [shift] input in return input << shift })
    case 3 where operationParts[1] == "AND":
        return BinaryGate(rightInputWire: operationParts[0], leftInputWire: operationParts[2], outputWire: outputWire, operation: &)
    case 3 where operationParts[1] == "OR":
        return BinaryGate(rightInputWire: operationParts[0], leftInputWire: operationParts[2], outputWire: outputWire, operation: |)
    default:
        return nil
    }
}

func day7() {
    let inputPath = NSBundle.mainBundle().pathForResource("day7_input", ofType: nil)
    let instructions = try! String(contentsOfFile: inputPath!).componentsSeparatedByString("\n")
    
    var wires = [String: UInt16]()
    var gates = [Gate?]()
    
    gates = instructions.map { createGate($0) }
    print(gates.count)
    while !gates.isEmpty {
        for i in 0..<gates.count {
            if let gate = gates[i] {
                //print(gate.execute(&wires))
                if gate.execute(&wires) {
                    //print(gate)
                    gates[i] = nil
                }
            }
        }
        gates = gates.filter { $0 != nil }
        print(gates)
    }
    
}