//
//  main.swift
//  AoC 5
//
//  Created by Christopher Fonseka on 13/12/2024.
//

import Foundation

// PART 1

let _rules = input
    .lineByLine
    .orderingRules

let rules = OrderingRules(rules: _rules)

let printRequests = input
    .lineByLine
    .printRequests


let result = printRequests
    .filter { $0.isValid(rules: rules) }
    .map(\.middleNumber)
    .reduce(0, +)

print(result)
