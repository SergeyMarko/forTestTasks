//
//  PhotoInfoTableViewCell.swift
//  QulixSystemsTestTask
//
//  Created by 1 on 2/14/21.
//

import UIKit

class PhotoInfoTableViewCell: UITableViewCell {
    
    // MARK: - Static
    
    static let cellId = "photoInfoCell"

    // MARK: - Outlets
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Properties
    
    let networkManager = NetworkManager()
    
    // MARK: - Public
    
    func update(with photo: Photo) {
        titleLabel.text = photo.title
        photoImageView.image = networkManager.loadPhoto(with: photo.imageURL ?? "")
    }
}
