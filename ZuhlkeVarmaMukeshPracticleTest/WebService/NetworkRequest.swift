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
    func decode(_ data: Data) throws -> ModelType?
    func load(onSuccess: @escaping (ModelType?) -> Void, onError: @escaping (Error?) -> Void?)
}

extension NetworkRequest {
    func load(_ url: URL, onSuccess: @escaping (ModelType?) -> Void, onError: @escaping (Error?) -> Void?) {
        let session = URLSession.init(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url, completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data else {
                onError(error)
                return
            }
            do {
                try onSuccess(self?.decode(data))
            } catch let parsingError {
                print("Error", parsingError)
            }
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
    func load(onSuccess: @escaping (Resource.ModelType?) -> Void, onError: @escaping (Error?) -> Void?) {
        load(resource.url, onSuccess: onSuccess, onError: onError)
    }
    
    func decode(_ data: Data) -> Resource.ModelType? {
        let wrapper = try? JSONDecoder().decode(Resource.ModelType.self, from: data)
        return wrapper
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
