//
//  Logic.swift
//  AoC 4
//
//  Created by Christopher Fonseka on 11/12/2024.
//

func index(input: String, valid: (Character) -> Bool) -> [Coordinate: Character] {
    var output: [Coordinate: Character] = [:]
    for (row, line) in input.lineByLine.enumerated() {
        for (col, char) in line.enumerated() {
            guard valid(char), let coord = Coordinate(row: row, col: col) else { continue }
            output[coord] = char
        }
    }
    return output
}

extension [Coordinate: Character] {

    func countXmasStrings(location: Coordinate) -> Int {
        countXmasStrings(locations: location.neighbours)
    }

    func countXmasStrings(locations: [[Coordinate]]) -> Int {
        var output = 0

        for line in locations {
            let characters = line.compactMap { self[$0] }
            let string = String(characters)
            if string == "XMAS" {
                output += 1
            }
        }
        return output
    }

    func countMasStrings(location: Coordinate) -> Int {
        countMasStrings(locations: location.xNeighbours)
    }

    func countMasStrings(locations: [[Coordinate]]) -> Int {
        var output = 0

        for line in locations {
            let characters = line.compactMap { self[$0] }
            let string = String(characters)
//            print("line: \(line) -> \(string)")
            if string == "MAS" {
//                print("-> MATCH!!")
                output += 1
            }
        }
        return output
    }
}


extension String {
    var lineByLine: [String] {
        self.components(separatedBy: .newlines)
    }

    var size: (width: Int, height: Int)  {
        let lines = self.lineByLine

        let width  = lines.map(\.count).max() ?? 0
        let height = lines.count

        return (width, height)
    }
}

struct Coordinate: Hashable {
    let row: Int
    let col: Int
    init?(row: Int, col: Int) {
        guard row >= 0, col >= 0 else { return nil }
        self.row = row
        self.col = col
    }

}
extension Coordinate {

    var neighbours: [[Coordinate]] {
        let offsetMap: [[(Int, Int)]] = [
            /* ➡️ */ [(0,0), (0,1), (0,2), (0,3)],
            /* ↘️ */ [(0,0), (1,1), (2,2), (3,3)],
            /* ⬇️ */ [(0,0), (1,0), (2,0), (3,0)],
            /* ↙️ */ [(0,0), (1,-1), (2,-2), (3,-3)],
            /* ⬅️ */ [(0,0), (0,-1), (0,-2), (0,-3)],
            /* ↖️ */ [(0,0), (-1,-1), (-2,-2), (-3,-3)],
            /* ⬆️ */ [(0,0), (-1,0), (-2,0), (-3,0)],
            /* ↗️ */ [(0,0), (-1,1), (-2,2), (-3,3)]
        ]

        let neighbourCoordinates: [[Coordinate]] = offsetMap.compactMap { line in
            let coords = line.compactMap { dRow, dCol in
                Coordinate(row: self.row + dRow, col: self.col + dCol)
            }

            guard coords.count == line.count else { return nil }
            return coords
        }

        return neighbourCoordinates
    }

    var xNeighbours: [[Coordinate]] {
        let offsetMap: [[(Int, Int)]] = [
            /* ↘️ */ [(-1,-1), (0,0), (1,1)],
            /* ↙️ */ [(-1,1), (0,0), (1,-1)],
            /* ↖️ */ [(1,1), (0,0), (-1,-1)],
            /* ↗️ */ [(1,-1), (0,0), (-1,1)]
        ]

        let neighbourCoordinates: [[Coordinate]] = offsetMap.compactMap { line in
            let coords = line.compactMap { dRow, dCol in
                Coordinate(row: self.row + dRow, col: self.col + dCol)
            }

            guard coords.count == line.count else { return nil }
            return coords
        }

//        print("xNeighbours -> \(neighbourCoordinates)")

        return neighbourCoordinates
    }
}

extension Coordinate: CustomStringConvertible {
    var description: String {
        "(\(row),\(col))"
    }
}


extension Character {
    var isValid: Bool {
        let validCharacters: Set<Character> = ["X", "M", "A", "S"]
        return validCharacters.contains(self)
    }

    var isValidForPart2: Bool {
        let validCharacters: Set<Character> = ["M", "A", "S"]
        return validCharacters.contains(self)
    }
}
