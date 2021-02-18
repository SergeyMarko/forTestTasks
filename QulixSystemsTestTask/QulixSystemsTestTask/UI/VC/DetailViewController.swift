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
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var infoIsFavoriteLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var infoViewsLabel: UILabel!
    
    // MARK: - Propertis
    
    var photo: Photo!
    var photoInfo: PhotoInfo?
    let networkManager = NetworkManager()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Detail Photo"
        loadData()
    }
    
    // MARK: - Private
    
    private func updateUI() {
        ownerLabel.text = "owner"
        locationLabel.text = "location"
        dateLabel.text = "publication"
        favoriteLabel.text = "favorite"
        viewsLabel.text = "views"
        
        namePhotoLabel.text = photo.title
        infoFullNameLabel.text = photoInfo?.info?.owner?.fullName
        infoLoactionLabel.text = photoInfo?.info?.owner?.location
        infoDateLabel.text = photoInfo?.info?.publicationDate?.taken
        infoIsFavoriteLabel.text = "\(photoInfo?.info?.isFavorite ?? 0)"
        infoViewsLabel.text = photoInfo?.info?.views
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
}
