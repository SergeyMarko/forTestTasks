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
    
    private var dataTask: URLSessionDataTask?
    private var cellTag = 0
    private(set) var cache = ImageCache.shared
    
    // MARK: - Public
    
    func update(with photo: Photo, cellTag: Int) {
        self.cellTag = cellTag
        
        photoImageView.roundCorners(with: 7)
        
        loadPhoto(with: photo, cellTag: cellTag)
        titleLabel.text = photo.title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dataTask?.cancel()
        dataTask = nil
        photoImageView.image = nil
        textLabel?.text = nil
    }
    
    // MARK: - Private
    
    private func loadPhoto(with photo: Photo, cellTag: Int) {
        guard
            let imageURL = photo.imageURL75,
            let url = URL(string: imageURL)
        else { return }
        
        if let cachedImage = cache.image(forKey: url) {
            photoImageView.image = cachedImage
        } else {
            loadPhotoFromServer(with: url, cellTag: cellTag)
        }
    }
    
    private func loadPhotoFromServer(with url: URL, cellTag: Int) {
        self.dataTask?.cancel()

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
                    self.cache.insertImage(image, forKey: url)
                }
            }
        }
        self.dataTask? = newDataTask
        newDataTask.resume()
    }
}
