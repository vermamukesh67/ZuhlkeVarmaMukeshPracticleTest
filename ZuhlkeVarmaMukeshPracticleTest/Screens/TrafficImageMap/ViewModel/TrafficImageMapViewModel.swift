//
//  TrafficImageMapViewModel.swift
//  ZuhlkeVarmaMukeshPracticleTest
//
//  Created by verma mukesh on 8/1/21.
//

import Foundation

// A View model class that handles the traffic images api calls and its business logic.
class TrafficImageMapViewModel {
    
    private var apiService = APIRequest(resource: TrafficImageDataResource())
    
    var bindControllerForSuccess : (() -> Void)?
    var bindControllerForError : ((_ errorMessage: String) -> Void)?
    var allCameras = [Cameras]()
    
    var trafficImageData : TrafficImageData? {
        didSet {
            if let cameras = self.trafficImageData?.items?.first?.cameras, !cameras.isEmpty {
                self.allCameras = cameras
                self.bindControllerForSuccess?()
            } else {
                self.bindControllerForError?("traffic images data not found")
            }
        }
    }
    
    /// Fetch traffic image data.
    func getTrafficImageData() {
        apiService.load { [weak self] (trafficData) in
            self?.trafficImageData = trafficData
        }
    }
}
