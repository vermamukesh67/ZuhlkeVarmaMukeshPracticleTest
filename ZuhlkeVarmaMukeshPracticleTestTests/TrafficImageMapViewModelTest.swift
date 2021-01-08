//
//  TrafficImageMapViewModelTest.swift
//  ZuhlkeVarmaMukeshPracticleTestTests
//
//  Created by verma mukesh on 8/1/21.
//

import XCTest
@testable import ZuhlkeVarmaMukeshPracticleTest

class TrafficImageMapViewModelTest: XCTestCase {
    var viewModel: TrafficImageMapViewModel!
    override func setUpWithError() throws {
        viewModel = TrafficImageMapViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testApiSuccessscenario() throws {
        var isSuccessCalled = false
        self.viewModel.bindControllerForSuccess = {
            isSuccessCalled = true
        }
        self.viewModel.bindControllerForError = { errorMessage in
        }
        let apiRequest = MockAPIRequest.init(resource: MockTrafficImageDataResource())
        apiRequest.load { data in
            self.viewModel.trafficImageData = data
        } onError: { error in }
        XCTAssertTrue(isSuccessCalled, "isSuccessCalled should be true")
    }
    
    func testApiErrorScenario() throws {
        var isErrorCalled = false
    
        self.viewModel.bindControllerForError = { errorMessage in
            isErrorCalled = true
        }
        self.viewModel.trafficImageData = nil
        XCTAssertTrue(isErrorCalled, "isErrorCalled should be true")
    }

}
