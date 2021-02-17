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
    
    // MARK: - Propertis
    
    var photo: Photo!
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        namePhotoLabel.text = photo.title
    }
}
