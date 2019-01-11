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
        sut = FileReader()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testCanCreateFileReader () {
        XCTAssertNotNil(sut, "Should be able to create FileReader")
    }
}
