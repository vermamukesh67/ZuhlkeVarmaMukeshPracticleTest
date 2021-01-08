//
//  ImageCacheTest.swift
//  ZuhlkeVarmaMukeshPracticleTestTests
//
//  Created by verma mukesh on 8/1/21.
//

import XCTest
@testable import ZuhlkeVarmaMukeshPracticleTest

class ImageCacheTest: XCTestCase {
    var imageCache: ImageCache!
    override func setUpWithError() throws {
       imageCache = ImageCache()
    }

    override func tearDownWithError() throws {
        imageCache = nil
    }

    func testInsertImage() throws {
        let url = URL.init(string: "https://images.data.gov.sg/api/traffic-images/2021/01/37b2ca21-96f5-4a0c-b404-1c1101c00502.jpg")!
        imageCache.insertImage(UIImage(), for: url)
        XCTAssertNotNil(imageCache.image(for: url), "image should not be nil")
        XCTAssertNotNil(imageCache[url], "image should not be nil")
    }
    
    func testSubscriptApi() throws {
        let url = URL.init(string: "https://images.data.gov.sg/api/traffic-images/2021/01/37b2ca21-96f5-4a0c-b404-1c1101c00502.jpg")!
        imageCache.insertImage(UIImage(), for: url)
        XCTAssertNotNil(imageCache[url], "image should not be nil")
    }
    
    func testRemoveImageApi() throws {
        let url = URL.init(string: "https://images.data.gov.sg/api/traffic-images/2021/01/37b2ca21-96f5-4a0c-b404-1c1101c00502.jpg")!
        imageCache.insertImage(UIImage(), for: url)
        XCTAssertNotNil(imageCache[url], "image should not be nil")
        imageCache.removeImage(for: url)
        XCTAssertNil(imageCache[url], "image should be nil")
    }
    
    func testRemoveAllImageApi() throws {
        let url = URL.init(string: "https://images.data.gov.sg/api/traffic-images/2021/01/37b2ca21-96f5-4a0c-b404-1c1101c00502.jpg")!
        imageCache.insertImage(UIImage(), for: url)
        XCTAssertNotNil(imageCache[url], "image should not be nil")
        imageCache.removeAllImages()
        XCTAssertNil(imageCache[url], "image should be nil")
    }
}
