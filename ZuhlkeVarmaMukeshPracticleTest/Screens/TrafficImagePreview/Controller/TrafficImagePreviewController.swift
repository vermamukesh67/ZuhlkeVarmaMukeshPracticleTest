//
//  TrafficImagePreviewController.swift
//  ZuhlkeVarmaMukeshPracticleTest
//
//  Created by verma mukesh on 8/1/21.
//

import UIKit

class TrafficImagePreviewController: UIViewController {
    
    @IBOutlet weak var actIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    
    public var imageString: String
    
    private var viewModel: TrafficImagePreviewViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.setupViewModelForUIUpdate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction fileprivate func btnCloseTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    private func setupViewModelForUIUpdate() {
        self.actIndicatorView.startAnimating()
        self.viewModel = TrafficImagePreviewViewModel.init(strImageUrl: self.imageString)
        self.viewModel.bindControllerForSuccess = {[weak self] image in
            self?.showImage(image)
        }
        self.viewModel.bindControllerForError = {[weak self] errorMessage in
            self?.handleNoData(errorMessage)
        }
        self.viewModel.loadImage()
    }
    
    /// Load controller for given image url.
    /// - Parameter imageUrl: A String value.
    public init(imageUrl: String) {
        self.imageString = imageUrl
        super.init(nibName: "TrafficImagePreviewController", bundle: Bundle.main)
    }
    
    /// Present controller with action sheet like animation.
    /// - Parameter viewController: A UIViewController object.
    public func show(in viewController: UIViewController) {
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overCurrentContext
        viewController.present(self, animated: true)
    }
    
    /// Show image.
    /// - Parameter image: A UIImage object.
    private func showImage(_ image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.actIndicatorView.stopAnimating()
            self?.imageView.image = image
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
}
