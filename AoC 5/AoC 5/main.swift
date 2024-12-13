//
//  main.swift
//  AoC 5
//
//  Created by Christopher Fonseka on 13/12/2024.
//

import Foundation

// PART 1

//let _rules = input
//    .lineByLine
//    .orderingRules
//
//let rules = OrderingRules(rules: _rules)
//
//let printRequests = input
//    .lineByLine
//    .printRequests
//
//
//let result = printRequests
//    .filter { $0.isValid(rules: rules) }
//    .map(\.middleNumber)
//    .reduce(0, +)
//
//print(result)


// Part 2

let _rules = challenge
    .lineByLine
    .orderingRules

let rules = OrderingRules(rules: _rules)

let printRequests = challenge
    .lineByLine
    .printRequests

let result = printRequests
    .filter { !$0.isValid(rules: rules) }
    .map { $0.corrected(rules: rules) }
    .map(\.middleNumber)
    .reduce(0, +)

print(result)
