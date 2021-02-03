//
//  ViewController.swift
//  CasualCollision
//
//  Created by Thomas Leonhardt on 28.01.21.
//

import UIKit
import Foundation

class EmployeesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let array = [0, 1, 2, 3, 4, 5]
        let c = array.collision(type: Int.self)
//        print(c)
        array.uniquePairs(type: Int.self)
        
//        let result  = array.uniquePairs(type: Int.self)
//        print(result)
//        print(result?.count ?? 0)
//        let request = EmployeeRequest()
//        request.send()
    }
}

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
        var dict: [Int: [(T, T)]]! = [Int: [(T, T)]](minimumCapacity: countDic)
        let tupels = collision(type: type)
        for i in 0...countTupels - 1 {
            dict[i] = [(T, T)](repeating: tupels[i], count: countDic)
            
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
//        return pairDic
//        var result: [Int: [(T, T)]] = pairDictionary(type: type)
//        let tupels = collision(type: type)
        for i in 0...countTupels - 2 {
            var pairs = [(T, T)]()
//            print("i: \(i)")
            pairs.append(pairDic[i]!.first!) // erster wert unstrittig
            var filter: [(T, T)] = tupels.filter{($0.0 != pairs[0].0 && $0.1 != pairs[0].1) && ($0.0 != pairs[0].1 && $0.1 != pairs[0].0)}
            let ft = findTupel(a: filter, maxValue: !(i).isMultiple(of: 2))
            pairs.append(ft)
            for j in 1...countDic - 2 {
//                print(filter)
                filter = filter.filter{($0.0 != pairs[1].0 && $0.1 != pairs[1].1) && ($0.0 != pairs[1].1 && $0.1 != pairs[1].0)}
//                print(filter)
                pairs.append(filter.first!) // (== min value )
                tupels = tupels.filter({ (tupel) -> Bool in
                    !pairs.contains { (value) -> Bool in
                        tupel == value
                    }
                })
            }
            print("i:[\(i)]: \(pairs)")
            pairDic[i] = pairs
        }
        pairDic.printValues(type: type)
        return pairDic
    }
    
    /// imagine as days
    private var countTupels: Int! {
        return self.count
    }
    /// imagine as numbers of day
    private var countDic: Int! {
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

