//
//  Logic.swift
//  AoC 6
//
//  Created by Christopher Fonseka on 13/12/2024.
//

// MARK: String Parsing Basics

extension String {

    var lineByLine: [String] {
        self.components(separatedBy: .newlines)
    }
}

// MARK: Coordinate System

struct MapSize {
    let width: Int
    let height: Int
}

extension MapSize {

    init(map: String) {
        let lines = map.lineByLine
        self.width  = lines.map(\.count).max() ?? 0
        self.height = lines.count
    }
}

struct Coordinate: Hashable {

    let row: Int
    let col: Int

    init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
}

extension Coordinate: CustomStringConvertible {

    var description: String {
        "(\(row),\(col))"
    }
}


// MARK: Map Decoding

extension Character {
    var isObstacle: Bool { self == "#" }
    var isGuard: Bool { self == "^" }
}

extension String {

    var obstaclesAndGuards: (guard: Coordinate, obstacles: Set<Coordinate>) {
        var g: Coordinate?
        var obstacles = Set<Coordinate>()

        for (x, row) in self.lineByLine.enumerated() {
            for (y, point) in row.enumerated() {
                if point.isObstacle { obstacles.insert(.init(row: x, col: y)) }
                else if point.isGuard { g = .init(row: x, col: y) }
            }
        }

        return (g!, obstacles)
    }

}

// MARK: Map Traversal

enum Direction: Hashable {
    case up, down, left, right

    var turnRight: Direction {
        switch self {
        case .up: .right
        case .down: .left
        case .left: .up
        case .right: .down
        }
    }

    func position(after c: Coordinate) -> Coordinate {
        switch self {
        case .up:
            Coordinate(row: c.row - 1, col: c.col)
        case .down:
            Coordinate(row: c.row + 1, col: c.col)
        case .left:
            Coordinate(row: c.row, col: c.col - 1)
        case .right:
            Coordinate(row: c.row, col: c.col + 1)
        }
    }
}

extension Coordinate {

    func outOfBounds(mapSize: MapSize) -> Bool {
        if (0..<mapSize.width).contains(self.row), (0..<mapSize.height).contains(self.col) {
            return false
        }
        return true
    }

}

struct MapTraverser {

    let obstacles: [Coordinate]
    let size: MapSize

    func walk(from start: Coordinate) -> Set<Coordinate> {
        var traversed = Set<Coordinate>()
        return walk(
            from: start,
            in: .up,
            traversed: &traversed
        )
    }

    func walk(
        from start: Coordinate,
        in direction: Direction,
        traversed: inout Set<Coordinate>
    ) -> Set<Coordinate> {
        let next = direction.position(after: start)

        if next.outOfBounds(mapSize: size) {
            traversed.insert(start)
            return traversed
        }

        if obstacles.contains(next) {
            return self.walk(from: start, in: direction.turnRight, traversed: &traversed)
        }

        traversed.insert(start)
        return self.walk(from: next, in: direction, traversed: &traversed)
    }
}

// MARK: Part 2

struct CoordinateAndDirection: Hashable {
    let coordinate: Coordinate
    let direction: Direction

    var next: CoordinateAndDirection {
        .init(
            coordinate: direction.position(after: coordinate),
            direction: direction
        )
    }

    var turnRight: CoordinateAndDirection {
        .init(
            coordinate: coordinate,
            direction: direction.turnRight
        )
    }
}

struct LoopFinder {

    let obstacles: Set<Coordinate>
    let size: MapSize

    func isLoop(start: Coordinate) -> Bool {
        let _start = CoordinateAndDirection(coordinate: start, direction: .up)
        var traversed = Set<CoordinateAndDirection>()
        return isLoop(start: _start, traversed: &traversed)
    }
    
    func isLoop(
        start: CoordinateAndDirection,
        traversed: inout Set<CoordinateAndDirection>
    ) -> Bool {
        guard !traversed.contains(start) else { return true }

        let next = start.next

        if next.coordinate.outOfBounds(mapSize: size) {
            return false
        }

        if obstacles.contains(next.coordinate) {
            return self.isLoop(
                start: start.turnRight,
                traversed: &traversed
            )
        }

        traversed.insert(start)
        return isLoop(start: next, traversed: &traversed)
    }
}

struct CoordinateSequence: Sequence, IteratorProtocol {

    let size: MapSize

    var currentPosition: Coordinate? = Coordinate(row: 0, col: 0)

    mutating func next() -> Coordinate? {
        defer {
            if let currentPosition {
                self.currentPosition = position(after: currentPosition)
            }
        }
        return currentPosition
    }

    func position(after x: Coordinate) -> Coordinate? {
        if let nextCol = col(after: x) {
            return Coordinate(row: x.row, col: nextCol)
        }

        if let nextRow = row(after: x) {
            return Coordinate(row: nextRow, col: 0)
        }

        return nil
    }

    func row(after x: Coordinate) -> Int? {
        guard x.row + 1 < size.height else { return nil }
        return x.row + 1
    }

    func col(after x: Coordinate) -> Int? {
        guard x.col + 1 < size.width else { return nil }
        return x.col + 1
    }
}
