//
//  main.swift
//  AoC 4
//
//  Created by Christopher Fonseka on 11/12/2024.
//

import Foundation

// PART 1

//let indexed = index(input: challenge, valid: \.isValid)
//let (w, h) = challenge.size
//
//var acc = 0
//
//for col in 0..<w {
//    for row in 0..<h {
//        if let coord = Coordinate(row: row, col: col) {
//            let count = indexed.countXmasStrings(location: coord)
//            acc += count
//        }
//    }
//}
//
//print("result \(acc)")

// Part 2

let indexed = index(input: challenge, valid: \.isValidForPart2)
let (w, h) = challenge.size

var acc = 0

for row in 0..<h {
    for col in 0..<w {
        if let coord = Coordinate(row: row, col: col) {
            let count = indexed.countMasStrings(location: coord)

            if count == 2 {
                acc += 1
            }
        }
    }
}

print("result \(acc)")

