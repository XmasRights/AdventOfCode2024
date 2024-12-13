//
//  main.swift
//  AoC 7
//
//  Created by Christopher Fonseka on 13/12/2024.
//

import Foundation

let testValues: [TestValue] = .decode(challenge)

let result = testValues
    .filter { $0.couldBeTrue() }
    .map(\.result)
    .reduce(0, +)

print(result)
