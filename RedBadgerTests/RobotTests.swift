//
//  RobotTests.swift
//  RedBadgerTests
//
//  Created by Trevor Doodes on 11/01/2019.
//  Copyright © 2019 IronworksMediaLimited. All rights reserved.
//

import XCTest

class RobotTests: XCTestCase {
    
    var sut: Robot!
    var mockPlanet: MockPlanet!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockPlanet = MockPlanet()
        sut = Robot(planet: mockPlanet, position: CGPoint(x: 3, y: 3), orientation: .north)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockPlanet = nil
        sut = nil
    }
    
    func testCanCreateRobot() {
        XCTAssertNotNil(sut, "Should be able to create a robot")
        XCTAssertNotNil(sut.planet, "Should set planet")
        XCTAssert(sut.position == CGPoint(x: 3, y: 3), "Should set position")
        XCTAssert(sut.orientation == .north, "Should set orientation")
    }
    
    func testCanTurnRight() {
        sut.execute(instruction: .turnRight)
        XCTAssert(sut.orientation == .east, "Should change orientation to East")
        
        sut.execute(instruction: .turnRight)
        XCTAssert(sut.orientation == .south, "Should change orientation to South")
        
        sut.execute(instruction: .turnRight)
        XCTAssert(sut.orientation == .west, "Should change orientation to West")
        
        sut.execute(instruction: .turnRight)
        XCTAssert(sut.orientation == .north, "Should change orientation the North")
        
        sut.execute(instruction: .turnRight)
        XCTAssert(sut.orientation == .east, "Should change orientation to East")
    }
    
    func testCanTurnLeft() {
        sut.execute(instruction: .turnLeft)
        XCTAssert(sut.orientation == .west, "Should change orientation to West")
        
        sut.execute(instruction: .turnLeft)
        XCTAssert(sut.orientation == .south, "Should change orientation to South")
        
        sut.execute(instruction: .turnLeft)
        XCTAssert(sut.orientation == .east, "Should change orientation to East")
        
        sut.execute(instruction: .turnLeft)
        XCTAssert(sut.orientation == .north, "Should change orientation to North")
        
        sut.execute(instruction: .turnLeft)
        XCTAssert(sut.orientation == .west, "Should change orientation to West")
        
    }
    
    func testCanMoveNorth() {
        sut.execute(instruction: .goForward)
        XCTAssertTrue(mockPlanet.locationExistsCalled, "Should call location exists")
        XCTAssertFalse(mockPlanet.robotLostCalled, "Should not call robot lost")
        XCTAssert(sut.position == CGPoint(x: 3, y: 4), "Should update position")
    }
    
    func testCanMoveEast() {
        sut.execute(instruction: .turnRight)
        sut.execute(instruction: .goForward)
        XCTAssertTrue(mockPlanet.locationExistsCalled, "Should call location exists")
        XCTAssertFalse(mockPlanet.robotLostCalled, "Should not call robot lost")
        XCTAssert(sut.position == CGPoint(x: 4, y: 3), "Should update position")
    }
    
    func testCanMoveSouth() {
        sut.execute(instruction: .turnRight)
        sut.execute(instruction: .turnRight)
        sut.execute(instruction: .goForward)
        XCTAssertTrue(mockPlanet.locationExistsCalled, "Should call location exists")
        XCTAssertFalse(mockPlanet.robotLostCalled, "Should not call robot lost")
        XCTAssert(sut.position == CGPoint(x: 3, y: 2), "Should update position")
    }
    
    func testCanMoveWes() {
        sut.execute(instruction: .turnLeft)
        sut.execute(instruction: .goForward)
        XCTAssertTrue(mockPlanet.locationExistsCalled, "Should call location exists")
        XCTAssertFalse(mockPlanet.robotLostCalled, "Should not call robot lost")
        XCTAssert(sut.position == CGPoint(x: 2, y: 3), "Should update position")
    }
    
    func testInvalidInstruction() {
        sut.execute(instruction: .invalid)
        XCTAssert(sut.position == CGPoint(x: 3, y: 3), "Should not move robot")
        XCTAssert(sut.orientation == .north, "Should not change orientation")
    }
    
    func testInstructionNotExecutedIfRobotLost() {
        mockPlanet.locationExists = false
        
        //Send robot off the grid
        sut.execute(instruction: .goForward)
        
        //Reset mockPlanet
        mockPlanet.locationExistsCalled = false
        mockPlanet.robotLostCalled = false
        
        //Execute tests
        sut.execute(instruction: .turnLeft)
        sut.execute(instruction: .goForward)
        XCTAssertFalse(mockPlanet.robotLostCalled, "Should not call location Exists")
        XCTAssertFalse(mockPlanet.robotLostCalled, "Should not call robotLost")
        XCTAssert(sut.orientation == .north, "Should not change orientation")
        XCTAssert(sut.position == CGPoint(x: 3, y: 3), "Should not move")
    }
    
    func testSetRobotToLostIfItGoesOutOfBounds() {
        mockPlanet.locationExists = false
        sut.execute(instruction: .goForward)
        
        XCTAssertTrue(mockPlanet.locationExistsCalled, "Should call location exists")
        XCTAssertTrue(mockPlanet.robotLostCalled, "Should call robot lost")
        XCTAssertTrue(sut.lost, "Should set lost to true")
        XCTAssertTrue(mockPlanet.setRobotLostCalled, "Should call set robot to lost")
        XCTAssertTrue(mockPlanet.robotLost, "Should set robot lost to true")
    }
    
    func testInstructionNotExecutedIfRobotPreviouslyLost() {
        mockPlanet.locationExists = false
        mockPlanet.robotLost = true
        
        sut.execute(instruction: .goForward)
        
        XCTAssertTrue(mockPlanet.locationExistsCalled, "Should call location exists")
        XCTAssertTrue(mockPlanet.robotLostCalled, "Should call robot lost")
        XCTAssertFalse(sut.lost, "Should not set lost to true")
        XCTAssert(sut.orientation == .north, "Should not change orientation")
        XCTAssert(sut.position == CGPoint(x: 3, y: 3), "Should not move")
    }
    
    func testStatusForRobotNotLost() {
        XCTAssert(sut.status() == "3 3 N", "Should output the correct status")
    }
    
    func testStatusForRobotLost() {
        mockPlanet.locationExists = false
        sut.execute(instruction: .goForward)
        
        XCTAssert(sut.status() == "3 3 N LOST", "Should output the correct status")
    }
}

class MockPlanet: Planet {

    var locationExists = true
    var locationExistsCalled = false
    
    var robotLost = false
    var robotLostCalled = false
    
    var setRobotLostCalled = false
    
    func locationExists(at point: CGPoint) -> Bool {
        locationExistsCalled = true
        return locationExists
    }
    
    func setRobotLost(at point: CGPoint) {
        setRobotLostCalled = true
        robotLost = true
    }
    
    func robotLost(at point: CGPoint) -> Bool {
        robotLostCalled = true
        return robotLost
    }
}
