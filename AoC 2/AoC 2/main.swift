//
//  main.swift
//  AoC 2
//
//  Created by Christopher Fonseka on 07/12/2024.
//

import Foundation

let result = challenge
    .lineByLine
    .asInts
    .countSafe

print("\(result) lines are safe")
