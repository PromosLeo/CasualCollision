//
//  Array+Collision.swift
//  CasualCollision
//
//  Created by Thomas Leonhardt on 28.01.21.
//

import Foundation

extension Dictionary {
    /// small Helper :)
    func printValues<T: Comparable>(type: T.Type) {
        for (_, values) in self.enumerated() {
            print(values)
        }
    }
}

extension Array where Self.Element : Comparable {
    private enum CollisonError: Error {
        case invalidArray
    }
    
    private func isEven() throws {
        if !count.isMultiple(of: 2) || isEmpty {
            throw CollisonError.invalidArray
        }
    }
    
    func collision<T: Comparable>(type: T.Type) -> Array<(T, T)> {
        try! isEven()
        var result = [(T, T)]()
        for (index, value) in self.enumerated() {
            if value == self.last {
                break
            }
            for i in (index + 1)..<self.count {
                if let l = value as? T, let r = self[i] as? T {
                    result.append((l, r))
                }
            }
        }
        return result
    }
    
    private func findTupel<T: Comparable>(a: Array<(T, T)>, maxValue: Bool = false) -> (T, T) {
        if a.count == 1 || maxValue {
//            print("findValue: \(a.last!)")
            return a.last!
        }
        let t = a[a.count - 1]
    //    print(t)
        let r = a.filter{$0.0 == t.0 && Swift.min($0.1, t.1) < t.1}
    //    print(r)
        if r.isEmpty {
//            print("findValue: \(t)")
            return t
        }
        var value = r.first
//        print("findValue: \(value)")
        return value!
    }
    
    private func pairDictionary<T: Comparable>(type: T.Type) -> (tupels: Array<(T, T)>, Dictionary<Int, [(T, T)]>) {
        var dict: [Int: [(T, T)]]! = [Int: [(T, T)]](minimumCapacity: countColumn)
        let tupels = collision(type: type)
        for i in 0...countColumn - 1 {
            dict[i] = [(T, T)](repeating: tupels[i], count: countRows)
            
        }
        return (tupels, dict)
    }
    
    /// [0, 1, 2, 3, 4, 5]
    ///
    ///      --> countTupels = (self.count)
    ///        0,1 2,3 4,5        |
    ///        0,2 1,4 3,5        |
    ///        0,3 1,5 2,4        |
    ///        0,4 1,3 2,5        |
    ///        0,5 1,2 3,4        |--> countDic = self.count/2
    func uniquePairs<T: Comparable>(type: T.Type) -> Dictionary<Int, [(T, T)]> {
        try! isEven()
        let t = pairDictionary(type: type)
        var pairDic = t.1
        var tupels = t.0
        print(tupels)
        for i in 0...countColumn - 1 {
            var filter = tupels
            var pairs = [(T, T)]()
            for j in 0...countRows - 1 {
                var pair: (T, T)!
                pair = filter.first
                if j > 0 && i > 0, 1 < filter.count {
                    // wenn möglich 1 nach recths
                    let pairRight: (T, T)? = filter[1]
                    if pairRight!.0 == pair.0 {
                        pair = pairRight
                    }
                }
                pairs.append(pair)
                print("pairs: \(pairs)")
                filter = filter.filter{($0.0 != pair.0 && $0.1 != pair.1) && ($0.0 != pair.1 && $0.1 != pair.0)}
                
                print("filter: \(filter)")
            }
            tupels = tupels.filter({ (tupel) -> Bool in
                !pairs.contains { (value) -> Bool in
                    tupel == value
                }
            })
            
//            print("i: \(i)")
              
//             // erster wert unstrittig
//            var filter: [(T, T)] = tupels.filter{($0.0 != pairs[0].0 && $0.1 != pairs[0].1) && ($0.0 != pairs[0].1 && $0.1 != pairs[0].0)}
//            print("Filter i: \(filter)")
//            let ft = findTupel(a: filter, maxValue: !(i).isMultiple(of: 2))
//            pairs.append(ft)
//            for j in 1...countDic - 2 {
//                filter = filter.filter{($0.0 != pairs[1].0 && $0.1 != pairs[1].1) && ($0.0 != pairs[1].1 && $0.1 != pairs[1].0)}
//                print("Filter j: \(filter)")
//                pairs.append(filter.first!) // (== min value )
//                tupels = tupels.filter({ (tupel) -> Bool in
//                    !pairs.contains { (value) -> Bool in
//                        tupel == value
//                    }
//                })
//            }
            print("i:[\(i)]: \(pairs)")
            pairDic[i] = pairs
        }
        pairDic.printValues(type: type)
        return pairDic
    }
    
    /// imagine as days
    private var countColumn: Int! {
        return self.count - 1
    }
    /// imagine as pairs of day
    private var countRows: Int! {
        return self.count/2
    }
    
    private func findValid<T: Comparable>(to: (T, T), in array: [(T, T)]) -> (T, T) {
        let filter = array.filter {$0.0 != to.1}
        return filter.last!
    }
    
    /****
     input == first and count of all arrays
     next is valid
     0,1 2,3 4,5
     0,2 1,3  --> finde nichts
     0,2 1,4 3,5
     0,3 1,5 2,4
     0,4 1,2  --> finde nichts
     0,4 1,3 2,5
     0,5 1,2 3,4
     
     0,1 4,5 2,3
     0,2 3,5 1,4
     0,3 2,4 1,5
     0,4 2,5 1,3
     0,5 3,4 1,2
    
     
         
     
     ***/
    
}
//var tupels = collision(type: type)
//print(tupels)
//var result: [Int: [(T, T)]]! = [Int: [(T, T)]]()
//
//repeat {
//    print(tupels)
//    var count = self.count - 2
//    for i in 0...count {
//        if result[i] == nil {
//            result[i] = [(T, T)]()
//        }
//        let first = tupels.first!
//        let next =  findValid(to: first, in: tupels)
//        result[i]!.append(first)
//        result[i]!.append(next)
//        tupels.removeFirst()
//        tupels.removeLast()
//        count -= 1
//    }
//} while tupels.count != self.count - 1
//return result



//extension Array where Self.Element : Comparable {
//    private enum CollisonError: Error {
//        case invalidArray
//    }
//
//    private mutating func change() {
//        guard self.count > 2 else {
//            return
//        }
//        var result = self
//        for i in stride(from: 0, to: count - 1, by: 2) {
//            let value = result[i]
//            result[i] = result[i + 1]
//            result[i + 1] = value
//        }
//        self = result
//    }
//
//    private mutating func simpleShift() {
//        var result = self
//        if let first = result.first {
//            result.append(first)
//            result.removeFirst()
//        }
//        self = result
//    }
//
//    private func isEven() throws {
//        if !count.isMultiple(of: 2) {
//            print("Invalid Array")
//            throw CollisonError.invalidArray
//        }
//    }
//
//    private func tupel<T: Comparable>(type: T.Type) -> Array<(T, T)> {
//        var result = [(T, T)]()
//        for (index, _) in enumerated() {
//            if !index.isMultiple(of: 2) {
//                continue
//            }
//            let l = self[index] as! T
//            let r = self[index + 1] as! T
//            var tupel = (l, r)
//            if (r >= l) {
//                tupel = (r, l)
//            }
//            result.append(tupel)
//        }
//        return result
//    }
//
//    private func computeCollisions<T: Comparable>(type: T.Type, control: Array<(T, T)> = []) -> Dictionary<Int, Array<(T, T)>> {
//        var dict: [Int: [(T, T)]] = [Int: [(T, T)]]()
//        var sortArray = self
//        var key = 0
//        repeat {
//            sortArray.change()
//            let tupels = sortArray.tupel(type: type)
//            if !control.contains(where: {$0.0 == tupels.first!.0 && $0.1 == tupels.first!.1}) {
//                dict[key] = tupels
//                print(tupels)
//            }
//            sortArray.simpleShift()
//            key += 1
//        } while sortArray != self
//        return dict
//    }
//
//    private func reference<T: Comparable>(type: T.Type, dict: Dictionary<Int, [(T, T)]>) -> Array<(T, T)> {
//        var result = [(T, T)]()
//        for (key, _) in dict.enumerated() {
//            result.append(dict[key]!.first!)
//        }
//        return result
//    }
//
//    private func transform<T: Comparable>(type: T.Type) -> Array<T> {
//        var result = self
//        result.remove(at: 1)
//        result.append(self[1])
//        return result as! [T]
//    }
//
//    private func match<T: Comparable>(type: T.Type, first: Dictionary<Int, [(T, T)]>, second: Dictionary<Int, [(T, T)]>) -> Dictionary<Int, [(T, T)]> {
//        var result = first
//        let sortedKeys = first.keys.sorted {
//            $0 < $1
//        }
//        var newKey: Int = sortedKeys.max() ?? 0
//        for (key, _) in second.enumerated() {
//            result[newKey] = second[key]
//            newKey += 1
//        }
//        return result
//    }
//
////    func collision<T: Comparable>(type: T.Type) -> Dictionary<Int, [(T, T)]> {
////        try! isEven()
////        let first = computeCollisions(type: type)
////        let control = self.reference(type: type, dict: first)
////        let nextArray = transform(type: type)
////        print(" ")
////        let second = nextArray.computeCollisions(type: type, control: control)
////        return match(type: type, first: first, second: second)
////    }
//}

