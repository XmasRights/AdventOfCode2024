//
//  main.swift
//  AoC 6
//
//  Created by Christopher Fonseka on 13/12/2024.
//

import Foundation

// Part 1

let part1 = challenge

let (start, o) = part1.obstaclesAndGuards
let size = MapSize(map: part1)

let traverser = MapTraverser(
    obstacles: o,
    size: size
)

let result = traverser.walk(from: start).count

print(result)
