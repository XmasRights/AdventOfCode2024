//
//  Logic.swift
//  AoC 5
//
//  Created by Christopher Fonseka on 13/12/2024.
//

extension String {

    var lineByLine: [String] {
        self.components(separatedBy: .newlines)
    }

    var asIntArray: [Int] {
        self.components(separatedBy: ",")
            .compactMap(Int.init)
    }
}

extension Array<String> {

    var orderingRules: [(Int, Int)] {
        return self.filter { $0.contains("|") }
            .map { $0.split(separator: "|") }
            .compactMap { pairs -> (Int, Int)? in
                guard
                    let _lhs = pairs.first,
                    let lhs = Int(String(_lhs)),
                    let _rhs = pairs.last,
                    let rhs = Int(String(_rhs))
                else { return nil }

                return (lhs, rhs)
            }
    }

    var printRequests: [[Int]] {
        self.filter { $0.contains(",") }
            .map(\.asIntArray)
    }
}

struct OrderingRules {

    let store: [Int: Set<Int>]

    init(rules: [(Int, Int)]) {
        self.store = rules.reduce(into: [Int: Set<Int>]()) { _store, rule in
            let (lhs, rhs) = rule
            var pages = _store[lhs] ?? []
            pages.insert(rhs)
            _store[lhs] = pages
        }
    }

    func precedingPages(for page: Int) -> Set<Int> {
        store[page] ?? []
    }
}

extension Array<Int> {

    func isValid(rules: OrderingRules) -> Bool {
        var seen: Set<Int> = []
        for page in self {
            let preceding = rules.precedingPages(for: page)

            if preceding.allSatisfy({ !seen.contains($0) }) {
                seen.insert(page)
            } else {
                return false
            }
        }
        return true
    }
}

extension Array<Int> {

    var middleNumber: Int {
        let middle = self.count / 2
        return self[middle]
    }
}
