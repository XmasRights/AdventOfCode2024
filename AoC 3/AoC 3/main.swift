//
//  main.swift
//  AoC 3
//
//  Created by Christopher Fonseka on 07/12/2024.
//

import Foundation
import RegexBuilder

let result = challenge
    .matches(of: mulFuctionRegex)
    .compactMap { result -> Int? in
        guard
            let lhs = result.output.1,
            let rhs = result.output.2
        else { return nil }

        return lhs * rhs
    }
    .reduce(0, +)

print(result)
