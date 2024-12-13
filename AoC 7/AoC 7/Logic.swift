//
//  Logic.swift
//  AoC 7
//
//  Created by Christopher Fonseka on 13/12/2024.
//

extension String {

    var lineByLine: [String] {
        self.components(separatedBy: .newlines)
    }

    var asInts: [Int] {
        self
            .components(separatedBy: .whitespaces)
            .compactMap { Int($0) }
    }

    var testValue: (Int, [Int])? {

        let splitByColon = self.components(separatedBy: ":")

        let resultString = splitByColon.first
        let values = splitByColon.last?.asInts

        guard let resultString, let result = Int(resultString), let values else { return nil }
        return (result, values)
    }
}

struct TestValue {
    let result: Int
    let values: [Int]

    func couldBeTrue() -> Bool {
        guard let first = values.first else { return false }

        let head = Node(value: first)
        var ptr = head
        for value in values.dropFirst() {
            ptr = ptr.appending(value: value)
        }
        return head.result().contains(result)
    }
}

extension TestValue {

    init?(_ string: String) {
        guard let (result, value) = string.testValue else { return nil }
        self = .init(result: result, values: value)
    }
}

extension TestValue: CustomStringConvertible {
    var description: String {
        "(\(result)| \(values))"
    }
}

extension Array<TestValue> {

    static func decode(_ string: String) -> Self {
        string
            .lineByLine
            .compactMap { TestValue($0) }
    }
}

extension TestValue {

    class Node {

        let value: Int
        var child: Node?

        init(value: Int, child: Node? = nil) {
            self.value = value
            self.child = child
        }

        func appending(value: Int) -> Node {
            let newChild = Node(value: value)
            self.child = newChild
            return newChild
        }

        func result() -> Set<Int> {
            return child?.result(acc: [value]) ?? [value]
        }

        func result(acc: Set<Int>) -> Set<Int> {
            var newAcc = Set<Int>()
            for item in acc {
                newAcc.insert(item + value)
                newAcc.insert(item * value)
                newAcc.insert(item || value)
            }

            if let child {
                return child.result(acc: newAcc)
            } else {
                return newAcc
            }
        }
    }
}

infix operator ||
func ||(lhs: Int, rhs: Int) -> Int {
    return Int("\(lhs)\(rhs)")!
}
