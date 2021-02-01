//
//  CasualCollisionTests.swift
//  CasualCollisionTests
//
//  Created by Thomas Leonhardt on 28.01.21.
//

import XCTest
@testable import CasualCollision

class CasualCollisionTests: XCTestCase {
    
    func testSimple() throws {
        simple()
    }
    
    func testCollisonSort() throws {
        if let collision = collisionSorted {
            
        }
    }
    
    
    private var collision: [(Int, Int)]?  {
        return testArray.collision(type: Int.self)
    }
    private var collisionSorted: Dictionary<Int, [(Int, Int)]>? {
        return testArray.collisionSort(type: Int.self)
    }
    
    private struct TupelSummary: Equatable {
        private static func compare(a: (Int, Int), b: (Int, Int)) -> Bool {
            return (a.0 == b.0 || a.0 == b.1) && (a.1 == b.0) || (a.1 == b.1)
        }
        
        static func == (lhs: TupelSummary, rhs: TupelSummary) -> Bool {
            lhs.sum == rhs.sum && TupelSummary.compare(a: lhs.intTupel, b: rhs.intTupel)
        }
        
        var intTupel: (Int, Int)
        var sum: Int {
            return intTupel.0 + intTupel.1
        }
    }
    
    private func isDuplicate(duplicate: Bool = false) -> Bool {
        var tupelsSum = Array<TupelSummary>()
        guard let collision = collision else {
            return false
        }
        for value in collision {
            tupelsSum.append(TupelSummary(intTupel: value))
        }
        
        if duplicate {
            tupelsSum.append(contentsOf: tupelsSum)
        }
        
        let crossReference = Dictionary(grouping: tupelsSum, by: {$0.sum})
        let duplicates = crossReference.filter { $1.count > 1 }

        for (_, sums) in duplicates {
            for tupel in sums {
                let duplicate = sums.filter { (tsummary) -> Bool in
                    tsummary == tupel
                }
                if duplicate.count > 1 {
                    return true
                }
            }
        }
        return false
    }
    private var testArray = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    func testBaseCollision() throws {
        var remains = testArray
        for (_, value) in testArray.enumerated() {
            remains.removeFirst()
            for remain in remains {
                let insideTupel = (value, remain)
                XCTAssert(collision?.contains(where: {$0 == insideTupel}) == true, "Missing Collision Tupel: \(insideTupel)")
            }
        }
    }
    
    func testDuplicateCollistion() throws {
        XCTAssert(!isDuplicate(), "Found Duplicate Collision")
        XCTAssert(isDuplicate(duplicate: true), "Duplicate Collision Not Found")
    }
}
