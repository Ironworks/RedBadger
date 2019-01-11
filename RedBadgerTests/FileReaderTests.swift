//
//  FileReaderTests.swift
//  RedBadgerTests
//
//  Created by Trevor Doodes on 11/01/2019.
//  Copyright © 2019 IronworksMediaLimited. All rights reserved.
//

import XCTest
@testable import RedBadger

class FileReaderTests: XCTestCase {
    
    var sut: FileReader!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = FileReader(fileName: "test", type: "txt")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testCanCreateFileReader () {
        XCTAssertNotNil(sut, "Should be able to create FileReader")
    }
    
    func testCanSetFileNameAndType() {
        XCTAssert(sut.fileName == "test", "Should be able to set file name")
        XCTAssert(sut.fileType == "txt", "Should be able to set file type")
    }
    
    func testCanReadFile() {
        let commands = sut.readFile()
        
        XCTAssert(commands?.gridSize == CGPoint(x: 5, y: 3), "Should set grid size correctly")
        XCTAssert(commands?.robotCommands.count == 3, "Should have 3 sets of robot commands")
        
        
        XCTAssert(commands?.robotCommands[0].startPoint == CGPoint(x: 1, y: 1))
        XCTAssert(commands?.robotCommands[0].startOrientation == .east, "Should set start orientation correctly")
        XCTAssert(commands?.robotCommands[0].moves[0] == "R", "Should get correct first move")
        XCTAssert(commands?.robotCommands[0].moves[1] == "F", "Should get correct second move")
        XCTAssert(commands?.robotCommands[0].moves[2] == "R", "Should get correct third move")
        XCTAssert(commands?.robotCommands[0].moves[3] == "F", "Should get correct forth move")
        XCTAssert(commands?.robotCommands[0].moves[4] == "R", "Should get correct fifth move")
        XCTAssert(commands?.robotCommands[0].moves[5] == "F", "Should get correct sixth move")
        XCTAssert(commands?.robotCommands[0].moves[6] == "R", "Should get correct seventh move")
        XCTAssert(commands?.robotCommands[0].moves[7] == "F", "Should get correct eigth move")
        
        XCTAssert(commands?.robotCommands[1].startPoint == CGPoint(x: 3, y: 2))
        XCTAssert(commands?.robotCommands[1].startOrientation == .north, "Should set start orientation correctly")
        XCTAssert(commands?.robotCommands[1].moves[0] == "F", "Should get correct first move")
        XCTAssert(commands?.robotCommands[1].moves[1] == "R", "Should get correct second move")
        XCTAssert(commands?.robotCommands[1].moves[2] == "R", "Should get correct third move")
        XCTAssert(commands?.robotCommands[1].moves[3] == "F", "Should get correct forth move")
        XCTAssert(commands?.robotCommands[1].moves[4] == "L", "Should get correct fifth move")
        XCTAssert(commands?.robotCommands[1].moves[5] == "L", "Should get correct sixth move")
        XCTAssert(commands?.robotCommands[1].moves[6] == "F", "Should get correct seventh move")
        XCTAssert(commands?.robotCommands[1].moves[7] == "F", "Should get correct eigth move")
        XCTAssert(commands?.robotCommands[1].moves[8] == "R", "Should get correct ninth move")
        XCTAssert(commands?.robotCommands[1].moves[9] == "R", "Should get correct tenth move")
        XCTAssert(commands?.robotCommands[1].moves[10] == "F", "Should get correct eleventh move")
        XCTAssert(commands?.robotCommands[1].moves[11] == "L", "Should get correct twelveth move")
        XCTAssert(commands?.robotCommands[1].moves[12] == "L", "Should get correct thirteenth move")
        
        XCTAssert(commands?.robotCommands[2].startPoint == CGPoint(x: 0, y: 3))
        XCTAssert(commands?.robotCommands[2].startOrientation == .west, "Should set start orientation correctly")
        XCTAssert(commands?.robotCommands[2].moves[0] == "L", "Should get correct first move")
        XCTAssert(commands?.robotCommands[2].moves[1] == "L", "Should get correct second move")
        XCTAssert(commands?.robotCommands[2].moves[2] == "F", "Should get correct third move")
        XCTAssert(commands?.robotCommands[2].moves[3] == "F", "Should get correct forth move")
        XCTAssert(commands?.robotCommands[2].moves[4] == "F", "Should get correct fifth move")
        XCTAssert(commands?.robotCommands[2].moves[5] == "L", "Should get correct sixth move")
        XCTAssert(commands?.robotCommands[2].moves[6] == "F", "Should get correct seventh move")
        XCTAssert(commands?.robotCommands[2].moves[7] == "L", "Should get correct eigth move")
        XCTAssert(commands?.robotCommands[2].moves[8] == "F", "Should get correct ninth move")
        XCTAssert(commands?.robotCommands[2].moves[9] == "L", "Should get correct tenth move")
    }
}
