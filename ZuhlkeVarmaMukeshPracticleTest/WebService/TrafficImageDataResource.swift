//
//  TrafficImageDataResource.swift
//  ZuhlkeVarmaMukeshPracticleTest
//
//  Created by verma mukesh on 8/1/21.
//

import Foundation

/// Represents the traffic image data resource information.
public struct TrafficImageDataResource: APIResource {
    typealias ModelType = TrafficImageData
    let methodPath = "/v1/transport/traffic-images"
    var queryItems: [URLQueryItem]? = nil
}
