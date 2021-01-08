//
//  APIRequestTest.swift
//  ZuhlkeVarmaMukeshPracticleTestTests
//
//  Created by verma mukesh on 8/1/21.
//

import XCTest
@testable import ZuhlkeVarmaMukeshPracticleTest

class APIRequestTest: XCTestCase {
    var apiRequest: MockAPIRequest<MockTrafficImageDataResource>!
    override func setUpWithError() throws {
        apiRequest = MockAPIRequest.init(resource: MockTrafficImageDataResource())
    }
    
    override func tearDownWithError() throws {
        apiRequest = nil
    }
    
    func testApiSuccessscenario() throws {
        apiRequest.load { data in
            XCTAssertNotNil(data, "data should not be nil")
            XCTAssertNotNil(data?.api_info, "api_info should not be nil")
            XCTAssertNotNil(data?.items, "items should not be nil")
            XCTAssertEqual(data?.items?.first?.cameras?.count, 87, "Wrong count of camera data is there")
            XCTAssertEqual(data?.items?.first?.cameras?.first?.camera_id, "1001", "camera id should be equal to 1001")
            XCTAssertNotNil(data?.items?.first?.cameras?.first?.location, "camera location should not be nil")
        } onError: { error in }
    }
}

struct MockTrafficImageDataResource: APIResource {
    typealias ModelType = TrafficImageData
    let methodPath = "/v1/transport/traffic-images"
    var queryItems: [URLQueryItem]? = nil
}

protocol MockNetworkRequest: NetworkRequest {
}

extension MockNetworkRequest {
    func load(_ url: URL, onSuccess: @escaping (ModelType?) -> Void, onError: @escaping (Error?) -> Void?) {
        
        let data = self.getData(name: "mockdata")
        do {
            try onSuccess(self.decode(data))
        } catch let parsingError {
            onError(parsingError)
            print("Error", parsingError)
        }
        
    }
    func getData(name: String, withExtension: String = "json") -> Data {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: name, withExtension: withExtension)
        let data = try! Data(contentsOf: fileUrl!)
        return data
    }
}

class MockAPIRequest<Resource: APIResource>: MockNetworkRequest  {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
    func load(onSuccess: @escaping (Resource.ModelType?) -> Void, onError: @escaping (Error?) -> Void?) {
        load(resource.url, onSuccess: onSuccess, onError: onError)
    }
    
    func decode(_ data: Data) -> Resource.ModelType? {
        let wrapper = try? JSONDecoder().decode(Resource.ModelType.self, from: data)
        return wrapper
    }
}
