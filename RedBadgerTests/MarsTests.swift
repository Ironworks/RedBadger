//
//  MarsTests.swift
//  RedBadgerTests
//
//  Created by Trevor Doodes on 11/01/2019.
//  Copyright © 2019 IronworksMediaLimited. All rights reserved.
//

import XCTest
@testable import RedBadger

class MarsTests: XCTestCase {
    
    var sut: Mars!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = Mars(topRight: CGPoint(x: 5, y: 5))
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testCanCreateMars() {
        XCTAssertNotNil(sut, "Should be able to create mars")
        XCTAssert(sut.topRight == CGPoint(x: 5, y: 5))
        XCTAssert(sut.grid.count == 6, "Should have 6 rows")
        XCTAssert(sut.grid[0].count == 6, "Should have 6 columns")
        
        for i in 0...sut.grid.count - 1 {
            for j in 0...sut.grid[i].count - 1 {
                XCTAssertFalse(sut.grid[i][j].robotLost, "Should set robot lost to false")
            }
        }
    }
    
    func testLocationExists() {
        XCTAssertTrue(sut.locationExists(at: CGPoint(x: 3, y: 3)), "Should return true for a valid location")
    }
    
    func testLocationOutOfBounds() {
        XCTAssertFalse(sut.locationExists(at: CGPoint(x: 7, y: 7)), "Should return false for a valid location")
    }
    
    func testCanSetRobotLostAtValidLocatio() {
        sut.setRobotLost(at: CGPoint(x: 5, y: 3))
        XCTAssertTrue(sut.grid[5][3].robotLost, "Should set robot lost to true")
    }
    
    func testCantSetRobotLostIfNotAtEdgeOfPlanet() {
        sut.setRobotLost(at: CGPoint(x: 3, y: 3))
        XCTAssertFalse(sut.grid[3][3].robotLost, "Should not set robot lost if location is not at the edge of the grid")
    }
    
    func testRobotLostForLocation() {
        sut.setRobotLost(at: CGPoint(x: 5, y: 3))
        XCTAssertTrue(sut.robotLost(at: CGPoint(x: 5, y: 3)), "Should return true")
    }
    
    func testRobotNotLostForLocation() {
        XCTAssertFalse(sut.robotLost(at: CGPoint(x: 5, y: 3)), "Should return false")
    }
    
}
