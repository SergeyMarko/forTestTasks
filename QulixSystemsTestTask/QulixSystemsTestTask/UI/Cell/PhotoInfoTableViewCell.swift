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
    
    var dataTask: URLSessionDataTask?
    var cellTag = 0
    
    // MARK: - Public
    
    func update(with photo: Photo, cellTag: Int) {
        self.cellTag = cellTag
        
        func loadPhoto() {
            self.dataTask?.cancel()

            guard
                let imageURL = photo.imageURL,
                let url = URL(string: imageURL)
            else { return }

            let session = URLSession(configuration: .default)
            let newDataTask = session.dataTask(with: url) { [weak self] (data, _, error) in
                guard
                    let self = self,
                    let data = data,
                    error == nil,
                    cellTag == self.cellTag
                else { return }

                var image: UIImage?
                image = UIImage(data: data) ?? UIImage(named: "no-photo")

                DispatchQueue.main.async {
                    if self.cellTag == cellTag {
                        self.photoImageView.image = image
                    }
                }
            }
            self.dataTask? = newDataTask
            newDataTask.resume()
        }
        loadPhoto()
        titleLabel.text = photo.title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dataTask?.cancel()
        dataTask = nil
        photoImageView.image = nil
        textLabel?.text = nil
    }
}
