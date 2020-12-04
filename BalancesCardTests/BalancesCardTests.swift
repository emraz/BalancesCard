//
//  BalancesCardTests.swift
//  BalancesCardTests
//
//  Created by Mahmudul Hasan on 11/27/20.
//

import XCTest
@testable import BalancesCard

class BalancesCardTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: - Successful API call with raw URL
    func test_network_data_successfull() throws {
        let expectation = XCTestExpectation(description: "Waiting for the API call to return")
        let networkManager = Networking()
        networkManager.requestNetworkTask(endpoint: .accounts, type: AccountTopLevel.self) { (result) in
            defer {
                expectation.fulfill()
            }
            switch result {
            case .success(let account):
                XCTAssertEqual(account.accounts == nil, true)
            case .failure:
                break
            }
        }

        wait(for: [expectation], timeout: 2.0)
    }

    // MARK: - Successful API call with local json data
    func test_local_json_data_successfull() throws {
        let expectation = XCTestExpectation(description: "Waiting for the API call to return")
        let networkManager = NetworkingStab()
        networkManager.requestNetworkTask(endpoint: .accounts, type: AccountTopLevel.self) { (result) in
            defer {
                expectation.fulfill()
            }
            switch result {
            case .success(let account):
                XCTAssertEqual(account.accounts != nil, true)
//                XCTAssertEqual(config.settings.isCallEnabled, true)
//                XCTAssertEqual(config.settings.isChatEnabled, true)
//                XCTAssertEqual(config.settings.workHours, "M-F 23:00 - 23:45")
            case .failure:
                break
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }

}
