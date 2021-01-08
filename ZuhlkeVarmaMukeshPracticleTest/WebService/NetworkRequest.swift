//
//  NetworkRequest.swift
//  ZuhlkeVarmaMukeshPracticleTest
//
//  Created by verma mukesh on 8/1/21.
//

import Foundation

/// A Network protocol used for api call in APIRequest class.
protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func load(withCompletion completion: @escaping (ModelType?) -> Void)
}

extension NetworkRequest {
    func load(_ url: URL, withCompletion completion: @escaping (ModelType?) -> Void) {
        let session = URLSession.init(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url, completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data else {
                completion(nil)
                return
            }
            completion(self?.decode(data))
        })
        task.resume()
    }
}
/// A class that fetch data from given api resources.
class APIRequest<Resource: APIResource> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequest {
    func decode(_ data: Data) -> Resource.ModelType? {
        let wrapper = try? JSONDecoder().decode(Resource.ModelType.self, from: data)
        return wrapper
    }
    
    func load(withCompletion completion: @escaping (Resource.ModelType?) -> Void) {
        load(resource.url, withCompletion: completion)
    }
}

protocol APIResource {
    associatedtype ModelType: Decodable
    var methodPath: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension APIResource {
    var url: URL {
        var components = URLComponents(string: "https://api.data.gov.sg")!
        components.path = methodPath
        components.queryItems = queryItems
        return components.url!
    }
}
