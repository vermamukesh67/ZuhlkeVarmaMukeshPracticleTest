//
//  ImageRequest.swift
//  ZuhlkeVarmaMukeshPracticleTest
//
//  Created by verma mukesh on 8/1/21.
//

import Foundation
import UIKit

/// A class to load image data from url.
class ImageRequest {
    let url: URL
    init(url: URL) {
        self.url = url
    }
}

extension ImageRequest: NetworkRequest {
    
    func load(onSuccess: @escaping (UIImage?) -> Void, onError: @escaping (Error?) -> Void?) {
        load(url, onSuccess: onSuccess, onError: onError)
    }
    

    func decode(_ data: Data) -> UIImage? {
        let image = UIImage(data: data)
        ImageCache.shared.insertImage(image, for: url)
        return image
    }
}
