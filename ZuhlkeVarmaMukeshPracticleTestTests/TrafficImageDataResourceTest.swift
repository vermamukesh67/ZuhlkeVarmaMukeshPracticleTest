//
//  ApiRequestTest.swift
//  ZuhlkeVarmaMukeshPracticleTestTests
//
//  Created by verma mukesh on 8/1/21.
//

import XCTest
@testable import ZuhlkeVarmaMukeshPracticleTest

class TrafficImageDataResourceTest: XCTestCase {
    var apiResource: TrafficImageDataResource!
    override func setUpWithError() throws {
        apiResource = TrafficImageDataResource()
    }

    override func tearDownWithError() throws {
       apiResource = nil
    }

    func testWhenApiResourceIsInitlised() throws {
        XCTAssertEqual(apiResource.url.absoluteString, "https://api.data.gov.sg/v1/transport/traffic-images", "Url is not correct")
        apiResource.queryItems = [
            URLQueryItem(name: "site", value: "gov"),
        ]
        XCTAssertEqual(apiResource.url.absoluteString, "https://api.data.gov.sg/v1/transport/traffic-images?site=gov", "Url is not correct")
    }
}
