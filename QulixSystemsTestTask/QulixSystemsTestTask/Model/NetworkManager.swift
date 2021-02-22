//
//  NetworkManager.swift
//  QulixSystemsTestTask
//
//  Created by 1 on 2/14/21.
//

import Foundation
import UIKit

enum DataError: Error {
    case loading(message: String = L10n("error.download"))
}

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

// MARK: - NetworkManager

class NetworkManager {
    
    lazy var urlSession: URLSessionProtocol = URLSession.shared
    private var dataTask: URLSessionDataTask?
    private let baseURL = "https://www.flickr.com/services/rest/?method=flickr.photos"
    private let apiKey = "22f1636b6dd971cc0bc46b33b09b7960"
    
    // - the method executes the request for each letter entered
    func loadPhotos(with text: String, completionHandler: @escaping ((Result<ResultInfo, Error>) -> Void)) -> Void {
        
        guard let url = URL(string: "\(baseURL).search&api_key=\(apiKey)&text=\(text)&format=json&nojsoncallback=1")
        else { return }
        
        let newDataTask = urlSession.dataTask(with: url) { (data, response, error) in
            
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
    
    // - the method makes a request for a specific photo and returns all information about it
    // (for example: title, location, publication date, and so on)
    func loadPhotoInfo(with photo: Photo, completionHandler: @escaping ((Result<PhotoInfo, Error>) -> Void)) -> Void {
        
        guard
            let id = photo.id,
            let secret = photo.secret,
            let url = URL(string: "\(baseURL).getInfo&api_key=\(apiKey)&photo_id=\(id)&secret=\(secret)&format=json&nojsoncallback=1")
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
    
    // - the method loads the photo itself
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
