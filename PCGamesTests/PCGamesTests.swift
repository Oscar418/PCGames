//
//  PCGamesTests.swift
//  PCGamesTests
//
//  Created by Oscar on 2021/05/24.
//

import XCTest
import Alamofire
@testable import PCGames

class PCGamesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

extension PCGamesTests {
    func testDealsValidApiCallGetsHTTPStatusCode200() throws {
        try checkNetworkConnectivity()
        let baseURL = "https://www.cheapshark.com/api/1.0"
        let path = "/deals"
        let url = "\(baseURL)\(path)"
        let promise = expectation(description: "Status code: 200")
        var statusCode = 0
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .methodDependent)).responseJSON { response in
            statusCode = response.response?.statusCode ?? 0
            if statusCode == 200 {
                promise.fulfill()
            } else {
                XCTFail("Status code: \(statusCode)")
            }
        }
        wait(for: [promise], timeout: 5)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testGameDetailsValidApiCallGetsHTTPStatusCode200() throws {
        try checkNetworkConnectivity()
        let baseURL = "https://www.cheapshark.com/api/1.0"
        let path = "/deals"
        let dealID = "?id=w8n%2FL0yXAQhd7UEQWcmLKYjDvaQ%2Bp6QAnFfN0V5NreI%3D"
        let url = "\(baseURL)\(path)\(dealID)"
        let promise = expectation(description: "Status code: 200")
        var statusCode = 0
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .methodDependent)).responseJSON { response in
            statusCode = response.response?.statusCode ?? 0
            if statusCode == 200 {
                promise.fulfill()
            } else {
                XCTFail("Status code: \(statusCode)")
            }
        }
        wait(for: [promise], timeout: 5)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testStoresValidApiCallGetsHTTPStatusCode200() throws {
        try checkNetworkConnectivity()
        let baseURL = "https://www.cheapshark.com/api/1.0"
        let path = "/stores"
        let url = "\(baseURL)\(path)"
        let promise = expectation(description: "Status code: 200")
        var statusCode = 0
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .methodDependent)).responseJSON { response in
            statusCode = response.response?.statusCode ?? 0
            if statusCode == 200 {
                promise.fulfill()
            } else {
                XCTFail("Status code: \(statusCode)")
            }
        }
        wait(for: [promise], timeout: 5)
        XCTAssertEqual(statusCode, 200)
    }
}

extension PCGamesTests {
    func checkNetworkConnectivity() throws {
        try XCTSkipUnless(
            Reachability.isConnected(),
            "Network connectivity needed for this test.")
    }
}
