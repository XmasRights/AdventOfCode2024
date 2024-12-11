//
//  main.swift
//  AoC 3
//
//  Created by Christopher Fonseka on 07/12/2024.
//

import Foundation
import RegexBuilder

// Part 1
//let result = input
//    .matches(of: mulFuctionRegex)
//    .compactMap { result -> Int? in
//        guard
//            let lhs = result.output.1,
//            let rhs = result.output.2
//        else { return nil }
//
//        print(lhs, rhs)
//        return lhs * rhs
//    }
//    .reduce(0, +)
//

// Part 2

let seq = RegexMatchSequence(input: challenge)

var acc = 0
var disabledInstructions = false

while let result = seq.next() {
    switch result {
    case .do:
        disabledInstructions = false
    case .dont:
        disabledInstructions = true
    case .mult(let int, let int2):
        guard !disabledInstructions else { continue }
        let result = int * int2
        acc += result
    }
}

print("result is \(acc)")
