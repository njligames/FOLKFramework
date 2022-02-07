//
//  FOLKFrameworkTests.swift
//  FOLKFrameworkTests
//
//  Created by James Folk on 2/3/22.
//

import XCTest
@testable import FOLKFramework

class FOLKFrameworkTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCrowdin() throws {
        let crowdin:CrowdInKeyManager = CrowdInKeyManager()
        let keys:[String] = ["key1", "key2", "key3"]
        let values:[String] = ["jim", "Jim"]
        
        crowdin.add(values[0], keys[0])
        crowdin.add(values[1], keys[1])
        
        // duplicate crowdin value, different crowdin key
        crowdin.add(values[1], keys[2])
        
        // duplicate crowdin value, duplicate crowdin key
        crowdin.add(values[1], keys[2])
        
        let v0 = crowdin.get(values[0])
        let v1 = crowdin.get(values[1])
        
        XCTAssertEqual(v0.count, 1, "Not adding crowdin kv correctly.")
        XCTAssertEqual(v1.count, 2, "Should only add a crowdin key if the key doesn't already exist.")
        
        
    }

}
