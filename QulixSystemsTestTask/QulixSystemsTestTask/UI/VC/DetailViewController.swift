//
//  DetailViewController.swift
//  QulixSystemsTestTask
//
//  Created by 1 on 2/17/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var namePhotoLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var infoFullNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var infoLoactionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var infoDateLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var infoViewsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var infoDescriptionLabel: UILabel!
    
    // MARK: - Propertis
    
    var photo: Photo!
    private var photoInfo: PhotoInfo?
    private let networkManager = NetworkManager()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = L10n("title.detailsVC")
        loadPhoto()
        loadData()
    }
    
    // MARK: - Private
    
    private func updateUI() {
        ownerLabel.text = L10n("label.owner")
        locationLabel.text = L10n("label.location")
        dateLabel.text = L10n("label.publication")
        viewsLabel.text = L10n("label.views")
        descriptionLabel.text = L10n("label.description")
        
        namePhotoLabel.text = photo.title
        infoFullNameLabel.text = photoInfo?.info?.owner?.fullName
        infoLoactionLabel.text = photoInfo?.info?.owner?.location
        infoDateLabel.text = convertDatetime(with: photoInfo?.info?.publicationDate?.taken)
        infoViewsLabel.text = photoInfo?.info?.views
        infoDescriptionLabel.text = photoInfo?.info?.description?.content
    }
    
    private func loadData() {
        networkManager.loadPhotoInfo(with: photo) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let result):
                self.photoInfo = result
                self.updateUI()
            case .failure(let error):
                self.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
    
    private func loadPhoto() {
        
        networkManager.loadPhoto(with: photo.imageURL1024) { [weak self] image in
            self?.photoImageView.image = image
        }
    }
    
    private func convertDatetime(with date: String?) -> String? {
        guard let date = date else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        
        let convertfromStrToDate = dateFormatter.date(from: date)
    
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: convertfromStrToDate ?? Date())
        
    }
}
