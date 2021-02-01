//
//  Array+Collision.swift
//  CasualCollision
//
//  Created by Thomas Leonhardt on 28.01.21.
//

import Foundation

extension Array where Self.Element : Comparable {
    private enum CollisonError: Error {
        case invalidArray
    }
    
    private mutating func change() {
        guard self.count > 2 else {
            return
        }
        var result = self
        for i in stride(from: 0, to: count - 1, by: 2) {
            let value = result[i]
            result[i] = result[i + 1]
            result[i + 1] = value
        }
        self = result
    }
    
    private mutating func simpleShift() {
        var result = self
        if let first = result.first {
            result.append(first)
            result.removeFirst()
        }
        self = result
    }
    
    private func isEven() throws {
        if !count.isMultiple(of: 2) {
            print("Invalid Array")
            throw CollisonError.invalidArray
        }
    }
    
    private func tupel<T: Comparable>(type: T.Type) -> Array<(T, T)> {
        var result = [(T, T)]()
        for (index, _) in enumerated() {
            if !index.isMultiple(of: 2) {
                continue
            }
            let l = self[index] as! T
            let r = self[index + 1] as! T
            var tupel = (l, r)
            if (r >= l) {
                tupel = (r, l)
            }
            result.append(tupel)
        }
        return result
    }
    
    private func computeCollisions<T: Comparable>(type: T.Type, control: Array<(T, T)> = []) -> Dictionary<Int, Array<(T, T)>> {
        var dict: [Int: [(T, T)]] = [Int: [(T, T)]]()
        var sortArray = self
        var key = 0
        repeat {
            sortArray.change()
            let tupels = sortArray.tupel(type: type)
            if !control.contains(where: {$0.0 == tupels.first!.0 && $0.1 == tupels.first!.1}) {
                dict[key] = tupels
            }
            sortArray.simpleShift()
            key += 1
        } while sortArray != self
        return dict
    }
    
    private func reference<T: Comparable>(type: T.Type, dict: Dictionary<Int, [(T, T)]>) -> Array<(T, T)> {
        var result = [(T, T)]()
        for (key, _) in dict.enumerated() {
            result.append(dict[key]!.first!)
        }
        return result
    }
    
    private func transform<T: Comparable>(type: T.Type) -> Array<T> {
        var result = self
        result.remove(at: 1)
        result.append(self[1])
        return result as! [T]
    }
    
    private func match<T: Comparable>(type: T.Type, first: Dictionary<Int, [(T, T)]>, second: Dictionary<Int, [(T, T)]>) -> Dictionary<Int, [(T, T)]> {
        var result = first
        let sortedKeys = first.keys.sorted {
            $0 < $1
        }
        var newKey: Int = sortedKeys.max() ?? 0
        for (key, _) in second.enumerated() {
            result[newKey] = second[key]
            newKey += 1
        }
        return result
    }
    
    func collision<T: Comparable>(type: T.Type) -> Dictionary<Int, [(T, T)]> {
        try! isEven()
        let first = computeCollisions(type: type)
        let control = self.reference(type: type, dict: first)
        let nextArray = transform(type: type)
        let second = nextArray.computeCollisions(type: type, control: control)
        return match(type: type, first: first, second: second)
    }
}

