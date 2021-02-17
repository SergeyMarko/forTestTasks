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
    var info: PhotoInfo!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}
