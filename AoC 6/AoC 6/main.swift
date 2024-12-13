//
//  main.swift
//  AoC 6
//
//  Created by Christopher Fonseka on 13/12/2024.
//

import Foundation

// Part 1

//let part1 = challenge
//
//let (start, o) = part1.obstaclesAndGuards
//let size = MapSize(map: part1)
//
//let traverser = MapTraverser(
//    obstacles: o,
//    size: size
//)
//
//let result = traverser.walk(from: start).count
//
//print(result)



// Part 2

let part2 = challenge

let (start, obstacles) = part2.obstaclesAndGuards
let size = MapSize(map: part2)

var sequ = CoordinateSequence(size: size)
var positions = Set<Coordinate>()

while let position = sequ.next() {
    guard !obstacles.contains(position), position != start else {
        continue
    }

    var _obstacles = obstacles
    _obstacles.insert(position)

    let loopFinder = LoopFinder(
        obstacles: _obstacles,
        size: size
    )

    if loopFinder.isLoop(start: start) {
        positions.insert(position)
    }
}

print(positions.count)
