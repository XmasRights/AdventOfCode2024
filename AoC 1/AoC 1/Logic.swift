//
//  Logic.swift
//  AoC 1
//
//  Created by Christopher Fonseka on 13/12/2024.
//

import Algorithms

extension String {

    var asIntArray: [Int] {
        self.components(separatedBy: .whitespacesAndNewlines)
            .compactMap(Int.init)
    }
}

extension Array<Int> {

    var sortIntoOddAndEvenIndexes: (lhs: [Int], rhs: [Int]) {
        var lhs = [Int]()
        var rhs = [Int]()

        for item in chunks(ofCount: 2) {
            if let l = item.first, let r = item.last {
                lhs.append(l)
                rhs.append(r)
            }
        }
        return (lhs, rhs)
    }

    var countFrequencyOfElements: [Int: Int] {
        let mapped = self.map { ($0, 1) }
        return Dictionary(mapped, uniquingKeysWith: +)
    }
}

func absoluteDistance(lhs: Int, rhs: Int) -> Int {
    abs(lhs.distance(to: rhs))
}
