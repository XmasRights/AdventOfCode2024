//
//  Logic.swift
//  AoC 3
//
//  Created by Christopher Fonseka on 07/12/2024.
//

import RegexBuilder

let doRegex = Regex { "do()" }

let dontRegex = Regex { "don't()" }

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

final class RegexMatchSequence: Sequence, IteratorProtocol {

    enum Match {
        case `do`
        case dont
        case mult(Int, Int)
    }

    struct MatchAndRange {
        let match: Match
        let range: Range<String.Index>
    }

    let input: String
    var ptr: String.Index

    init(input: String) {
        self.input = input
        self.ptr = input.startIndex
    }

    private var _input: String.SubSequence {
        input[ptr...]
    }

    func next() -> Match? {
        var mulMatch: MatchAndRange? {
            guard
                let reg = _input.firstMatch(of: mulFuctionRegex),
                let lhs = reg.output.1, let rhs = reg.output.2
            else { return nil }
            let match = Match.mult(lhs, rhs)
            return MatchAndRange(match: match, range: reg.range)
        }

        var doMatch: MatchAndRange? {
            guard let reg = _input.firstMatch(of: doRegex) else { return nil }
            return MatchAndRange(match: .do, range: reg.range)
        }

        var dontMatch: MatchAndRange? {
            guard let reg = _input.firstMatch(of: dontRegex) else { return nil }
            return MatchAndRange(match: .dont, range: reg.range)
        }

        let nextMatch = [mulMatch, doMatch, dontMatch]
            .compactMap { $0 }
            .min(by: { $0.range.lowerBound < $1.range.lowerBound })

        if let nextMatch {
            self.ptr = nextMatch.range.upperBound
            return nextMatch.match
        } else {
            return nil
        }
    }
}

extension RegexMatchSequence.Match: CustomStringConvertible {

    var description: String {
        switch self {
            case .do: "do"
            case .dont: "dont"
            case .mult(let lhs, let rhs): "mul(\(lhs), \(rhs))"
        }
    }
}

extension RegexMatchSequence.MatchAndRange: CustomStringConvertible {

    var description: String {
        "(m:\(match), r:\(range.description))"
    }
}
