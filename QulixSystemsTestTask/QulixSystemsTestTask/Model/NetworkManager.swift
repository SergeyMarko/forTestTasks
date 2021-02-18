//
//  NetworkManager.swift
//  QulixSystemsTestTask
//
//  Created by 1 on 2/14/21.
//

import Foundation
import UIKit

enum DataError: Error {
    case loading(message: String = "An error occurred while downloading data from the server, no data received")
}

// MARK: - NetworkManager

class NetworkManager {
    
    var dataTask: URLSessionDataTask?
    
    func loadPhotos(with text: String, completionHandler: @escaping ((Result<ResultInfo, Error>) -> Void)) -> Void {
        
        guard let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=22f1636b6dd971cc0bc46b33b09b7960&text=\(text)&format=json&nojsoncallback=1")
        else { return }
        
        let session = URLSession(configuration: .default)
        let newDataTask = session.dataTask(with: url) { (data, _, error) in
            
            func fireCompletion(_ resultInfo: Result<ResultInfo, Error>) {
                DispatchQueue.main.async {
                    completionHandler(resultInfo)
                }
            }
            
            
            if let error = error as NSError?, error.code == NSURLErrorCancelled {
                // the error is ignored here, as it is due to the request being canceled before the closure is processed
                return
            } else if let error = error {
                fireCompletion(.failure(error))
                return
            }
            
            guard let data = data else {
                let dataLoadingError = DataError.loading()
                fireCompletion(.failure(dataLoadingError))
                return
            }
            
            do {
                let resultInfo = try JSONDecoder().decode(ResultInfo.self, from: data)
                fireCompletion(.success(resultInfo))
            } catch let parsingError {
                fireCompletion(.failure(parsingError))
            }
        }
        self.dataTask?.cancel()
        self.dataTask = newDataTask
        newDataTask.resume()
    }
    
    func loadPhotoInfo(with photo: Photo, completionHandler: @escaping ((Result<PhotoInfo, Error>) -> Void)) -> Void {
        
        guard
            let id = photo.id,
            let secret = photo.secret,
            let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=22f1636b6dd971cc0bc46b33b09b7960&photo_id=\(id)&secret=\(secret)&format=json&nojsoncallback=1")
        else { return }
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { (data, _, error) in
            
            func fireCompletion(_ resultInfo: Result<PhotoInfo, Error>) {
                DispatchQueue.main.async {
                    completionHandler(resultInfo)
                }
            }
            
            guard error == nil else {
                if let error = error {
                    fireCompletion(.failure(error))
                }
                return
            }
            guard let data = data else {
                let dataLoadingError = DataError.loading()
                fireCompletion(.failure(dataLoadingError))
                return
            }
            
            do {
                let photoInfo = try JSONDecoder().decode(PhotoInfo.self, from: data)
                fireCompletion(.success(photoInfo))
            } catch let parsingError {
                fireCompletion(.failure(parsingError))
            }
        }
        dataTask.resume()
    }
    
    func loadPhoto(with imageURL: String?, completionHandler: @escaping (UIImage?) -> Void) -> Void {
        guard
            let imageURL = imageURL,
            let url = URL(string: imageURL)
        else { return }

        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { (data, _, error) in
            guard
                let data = data,
                error == nil
            else { return }

            var image: UIImage?
            image = UIImage(data: data) ?? UIImage(named: "no-photo")

            DispatchQueue.main.async {
                completionHandler(image)
            }
        }
        dataTask.resume()
    }
}
