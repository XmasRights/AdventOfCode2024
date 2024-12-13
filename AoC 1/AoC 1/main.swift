//
//  main.swift
//  AoC 1
//
//  Created by Christopher Fonseka on 04/12/2024.
//

import Foundation

// PART 1

//let (lhs, rhs) = input
//    .asIntArray
//    .sortIntoOddAndEvenIndexes
//
//let result = zip(lhs.sorted(), rhs.sorted())
//    .map { absoluteDistance(lhs: $0.0, rhs: $0.1) }
//    .reduce(0, +)
//
//print("Result \(result)")

// PART 2

let (lhs, rhs) = input
    .asIntArray
    .sortIntoOddAndEvenIndexes

let elementCount = rhs.countFrequencyOfElements

var acc = 0

for item in lhs {
    let count = elementCount[item] ?? 0
    let score = count * item
    acc += score
}

print(acc)
