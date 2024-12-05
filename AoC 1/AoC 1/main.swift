//
//  main.swift
//  AoC 1
//
//  Created by Christopher Fonseka on 04/12/2024.
//

import Foundation

let (left, right) = InputDecoder.decode(input)

let zipped = zip(left.sorted(), right.sorted())

let distances = zipped.map { abs($0.0.distance(to: $0.1)) }

let result = distances.reduce(0, +)

print(result)
