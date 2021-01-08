//
//  ViewController.swift
//  ZuhlkeVarmaMukeshPracticleTest
//
//  Created by verma mukesh on 8/1/21.
//

import UIKit

/// A UIViewController that shows the map with traffic images.
class TrafficImageMapViewController: UIViewController {
    
    @IBOutlet weak var trafficImageMapView: TrafficImageMapView!
    @IBOutlet weak var actIndicatorView: UIActivityIndicatorView!
    var viewModel : TrafficImageMapViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModelForUIUpdate()
        self.setupMapView()
    }
    
    /// Set up view model.
    private func setupViewModelForUIUpdate() {
        self.actIndicatorView.startAnimating()
        self.viewModel = TrafficImageMapViewModel()
        self.viewModel.bindControllerForSuccess = {
            self.updateDataSource()
        }
        self.viewModel.bindControllerForError = {[weak self] errorMessage in
            self?.handleNoData(errorMessage)
        }
        self.viewModel.getTrafficImageData()
    }
    
    /// Set up map view.
    private func setupMapView() {
        trafficImageMapView.annotationSelectionHandler = {[weak self]  cameraData in
            self?.openImagePreviewScreen(cameraData)
        }
    }
    
    /// Update the ui when traffic images fetched successfully.
    private func updateDataSource() {
        DispatchQueue.main.async { [weak self] in
            self?.actIndicatorView.stopAnimating()
            if let cameras = self?.viewModel.allCameras {
                self?.trafficImageMapView.prepareUI(arrCamera: cameras)
            }
        }
    }
    
    /// Handle UI for no data fetch for traffic images.
    /// - Parameter errorMessage: A string value
    private func handleNoData(_ errorMessage: String) {
        DispatchQueue.main.async { [weak self] in
            self?.actIndicatorView.stopAnimating()
            self?.showAlert(title: "", message: errorMessage)
        }
    }
    
    /// Open image preview screen for selected annotation on map.
    /// - Parameter cameraData: Cameras object
    private func openImagePreviewScreen(_ cameraData: Cameras) {
        guard let strImageUrl =  cameraData.image else {
            return
        }
        let imagePreviewScreen = TrafficImagePreviewController.init(imageUrl: strImageUrl)
        imagePreviewScreen.show(in: self)
    }
}

