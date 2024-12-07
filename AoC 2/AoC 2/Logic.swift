//
//  Logic.swift
//  AoC 2
//
//  Created by Christopher Fonseka on 07/12/2024.
//

import Algorithms

extension String {

    var lineByLine: [String] {
        self.components(separatedBy: .newlines)
    }

    var asInts: [Int] {
        self
            .components(separatedBy: .whitespaces)
            .compactMap { Int($0) }
    }
}

extension Array<String> {

    var asInts: [[Int]] {
        map(\.asInts)
    }
}

extension Array<Int> {

    var removingEachEntryOnce: [[Int]] {
        self.indices.map { index in
            var copy = self
            copy.remove(at: index)
            return copy
        }
    }

    var diffsAreLessThanThree: Bool {
        for x in windows(ofCount: 2) {
            guard let lhs = x.first, let rhs = x.last else { return false }
            if abs(lhs.distance(to: rhs)) > 3 {
                return false
            }
        }
        return true
    }

    var incrementsInOneDirection: Bool {
        guard let first, let second = self.dropFirst().first else { return true }

        guard first != second else { return false }

        for x in dropFirst(1).windows(ofCount: 2) {
            guard let lhs = x.first, let rhs = x.last else { return false }

            if first < second {
                if lhs >= rhs {
                    return false
                }
            } else {
                if lhs <= rhs {
                    return false
                }
            }
        }
        return true
    }

    var isSafe: Bool {
        diffsAreLessThanThree && incrementsInOneDirection
    }
}

extension Array<Array<Int>> {

    var countSafe: Int {
        map(\.isSafe)
            .filter { $0 == true }
            .count
    }
}
