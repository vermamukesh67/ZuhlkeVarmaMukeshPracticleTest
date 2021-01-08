//
//  TrafficImagePreviewViewModel.swift
//  ZuhlkeVarmaMukeshPracticleTest
//
//  Created by verma mukesh on 8/1/21.
//

import Foundation
import UIKit

/// A viewmodel for traffic image preview screen.

class TrafficImagePreviewViewModel {
    
    private var strImageUrl: String
    
    private var imageRequest: ImageRequest!
    
    var bindControllerForSuccess : ((_ image: UIImage) -> Void)?
    var bindControllerForError : ((_ errorMessage: String) -> Void)?
    
    /// Init the view model with image url string.
    /// - Parameter strImageUrl: A String value for image url.
    init(strImageUrl: String) {
        self.strImageUrl = strImageUrl
        guard let imageUrl = URL.init(string: strImageUrl) else { return }
        self.imageRequest = ImageRequest(url: imageUrl)
    }
    /// Starts loading of image.
    func loadImage() {
        if let trafficImage = ImageCache.shared.image(for: imageRequest.url) {
            self.bindControllerForSuccess?(trafficImage)
        } else {
            imageRequest.load(withCompletion: {[weak self] (image: UIImage?) in
                DispatchQueue.main.async {
                    guard let trafficImage = image else {
                        self?.bindControllerForError?("image data not found")
                        return
                    }
                    self?.bindControllerForSuccess?(trafficImage)
                }
            })
        }
    }
}
