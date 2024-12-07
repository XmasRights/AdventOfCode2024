//
//  Logic.swift
//  AoC 3
//
//  Created by Christopher Fonseka on 07/12/2024.
//

import RegexBuilder

let mulFuctionRegex = Regex {
    "mul("
    Capture{
      OneOrMore(.digit)
    } transform: { match in
        Int(match)
    }

    ","
    Capture{
      OneOrMore(.digit)
    } transform: { match in
        Int(match)
    }

    ")"
}
