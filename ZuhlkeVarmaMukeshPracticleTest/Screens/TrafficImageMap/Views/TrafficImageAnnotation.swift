//
//  TrafficImageAnnotation.swift
//  ZuhlkeVarmaMukeshPracticleTest
//
//  Created by verma mukesh on 8/1/21.
//

import UIKit
import MapKit

class TrafficImageAnnotation: MKPointAnnotation {
    var cameraData: Cameras
    
    init(camera: Cameras) {
        self.cameraData = camera
    }
}
