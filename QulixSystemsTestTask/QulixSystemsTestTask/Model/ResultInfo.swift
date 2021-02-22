//
//  ResultInfo.swift
//  QulixSystemsTestTask
//
//  Created by 1 on 2/13/21.
//

import Foundation

struct ResultInfo: Decodable {
    
    var collection: Photos?
    
    enum CodingKeys: String, CodingKey {
        case collection = "photos"
    }
}

struct Photos: Decodable {
    var photos: [Photo]?
    
    enum CodingKeys: String, CodingKey {
        case photos = "photo"
    }
}

struct Photo: Decodable {
    var id: String?
    var server: String?
    var secret: String?
    var title: String?
    
    enum CodingKeys: String, CodingKey {
        case id, server, secret, title
    }
}

extension Photo {
    // photos load with a resolution of 75x75p(to display in cells )
    var imageURL75: String? {
        guard
            let server = server,
            let id = id,
            let secret = secret
        else { return nil}
        
        return "https://live.staticflickr.com/\(server)/\(id)_\(secret)_s.jpg"
    }
    // photos load with a resolution of 1024x1024p(to display in DetailsViewController)
    var imageURL1024: String? {
        guard
            let server = server,
            let id = id,
            let secret = secret
        else { return nil}
        
        return "https://live.staticflickr.com/\(server)/\(id)_\(secret)_b.jpg"
    }
}
