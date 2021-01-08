//
//  TrafficImageMapView.swift
//  ZuhlkeVarmaMukeshPracticleTest
//
//  Created by verma mukesh on 8/1/21.
//

import UIKit
import MapKit

class TrafficImageMapView: MKMapView, MKMapViewDelegate {
    /**
     Initializes and returns a newly allocated view object with the specified frame rectangle.
     - parameter frame:   The frame rectangle for the view
     - returns: An initialized view object.
     */
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupMap()
    }
    /**
     Initializes and returns a newly allocated view object.
     - returns: An initialized view object.
     */
    public init() {
        super.init(frame: CGRect.zero)
        setupMap()
    }
    /**
     Returns an object initialized from data in a given unarchiver.
     - parameter decoder:   An unarchiver object.
     - returns: self, initialized using the data in decoder.
     */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupMap()
    }
    
    /// preprare the map view.
    private func setupMap() {
        self.delegate = self
    }
    
    /// Update the map with camera object.
    /// - Parameter arrCamera: Array of Cameras object.
    public func prepareUI(arrCamera: [Cameras]) {
        let arrAnnotations = [TrafficImageAnnotation]()
        for camera in arrCamera {
            if let latitude = camera.location?.latitude, let longitude = camera.location?.longitude {
                let pointAnnotation = TrafficImageAnnotation(camera: camera)
                pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                self.addAnnotation(pointAnnotation)
            }
        }
        self.addAnnotations(arrAnnotations)
    }
    /// Selection handler for annotation on map.
    public var annotationSelectionHandler : ((_ camera: Cameras) -> Void)?
    
}
// Handles the map view delegates api.
extension TrafficImageMapView {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is TrafficImageAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let trafficImageAnnotation = view.annotation as? TrafficImageAnnotation else { return }
        annotationSelectionHandler?(trafficImageAnnotation.cameraData)
        mapView.setCenter(trafficImageAnnotation.coordinate, animated: true)
    }
}
