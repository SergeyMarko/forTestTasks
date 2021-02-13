//
//  NetworkManager.swift
//  QulixSystemsTestTask
//
//  Created by 1 on 2/14/21.
//

import Foundation

class NetworkManager {
    
    var dataTask: URLSessionDataTask?
    
    func loadPhotoInfo(text: String, completionHandler: @escaping ((ResultInfo?, Error?) -> Void)) -> Void {
        
        guard let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=39293cea7646ac5004421a4acadfa1fa&text=\(text)")
        else { return }
        
        let session = URLSession(configuration: .default)
        let newDataTask = session.dataTask(with: url) { (data, _, error) in
            
            func fireCompletion(_ resultInfo: ResultInfo?, _ error: Error?) {
                DispatchQueue.main.async {
                    completionHandler(resultInfo, error)
                }
            }
            
            guard
                let data = data,
                error == nil
            else {
                fireCompletion(nil, error)
                return
            }
            
            do {
                let resultInfo = try JSONDecoder().decode(ResultInfo.self, from: data)
                fireCompletion(resultInfo, error)
            } catch {
                fireCompletion(nil, error)
            }
        }
        self.dataTask?.cancel()
        self.dataTask = newDataTask
        newDataTask.resume()
    }
}
