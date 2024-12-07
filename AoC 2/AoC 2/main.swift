//
//  main.swift
//  AoC 2
//
//  Created by Christopher Fonseka on 07/12/2024.
//

import Foundation

let tests = challenge
    .lineByLine
    .asInts

var safeCount = 0

for test in tests {
    if test.isSafe {
        safeCount += 1

    } else {
        linecheck: for check in test.removingEachEntryOnce {
            if check.isSafe {
                safeCount += 1
                break linecheck
            }
        }
    }
}

print("\(safeCount) lines are safe")
