//
//  NetworkManager.swift
//  QulixSystemsTestTask
//
//  Created by 1 on 2/14/21.
//

import Foundation
import UIKit

enum DataError: Error {
    case loading(message: String)
}

class NetworkManager {
    
    var dataTask: URLSessionDataTask?
    
    func loadPhotoInfo(text: String, completionHandler: @escaping ((Result<ResultInfo, Error>) -> Void)) -> Void {
        // 22f1636b6dd971cc0bc46b33b09b7960 &format=json&nojsoncallback=1
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
                let dataLoadingError = DataError.loading(message: "An error occurred while downloading data from the server, no data received.")
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
}
