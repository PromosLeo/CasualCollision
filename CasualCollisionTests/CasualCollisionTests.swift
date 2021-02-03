//
//  CasualCollisionTests.swift
//  CasualCollisionTests
//
//  Created by Thomas Leonhardt on 28.01.21.
//

import XCTest
@testable import CasualCollision

class CasualCollisionTests: XCTestCase {
    
    private func isDuplicate(duplicate: Bool = false) -> Bool  {
        return true
    }
    
    func testBaseCollision() throws {
//        print(testTupel.count, refTupel.count)
//        print(testTupel)
    }
    
    func testDuplicateCollistion() throws {
        XCTAssert(!isDuplicate(), "Found Duplicate Collision")
        XCTAssert(isDuplicate(duplicate: true), "Duplicate Collision Not Found")
    }
}
