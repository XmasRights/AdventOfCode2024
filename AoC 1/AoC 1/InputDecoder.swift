//
//  InputDecoder.swift
//  AoC 1
//
//  Created by Christopher Fonseka on 04/12/2024.
//

import Algorithms

enum InputDecoder {

    static func decode(_ input: String) -> ([Int], [Int]) {
        let values = input
            .components(separatedBy: .whitespacesAndNewlines)
            .compactMap { Int($0) }

        var left = [Int]()
        var right = [Int]()

        values.chunks(ofCount: 2).forEach { x in
            if let a = x.first, let b = x.last {
                left.append(a)
                right.append(b)
            }
        }

        return (left, right)
    }
}
