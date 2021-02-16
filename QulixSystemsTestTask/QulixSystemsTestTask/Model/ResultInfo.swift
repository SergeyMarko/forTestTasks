//
//  ResultInfo.swift
//  QulixSystemsTestTask
//
//  Created by 1 on 2/13/21.
//

import Foundation

struct ResultInfo: Decodable {
    
    var photos: Photos?
    var stat: String?
}

struct Photos: Decodable {
    var photo: [Photo]?
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
    
    var imageURL: String? {
        "https://live.staticflickr.com/\(server ?? "")/\(id ?? "")_\(secret ?? "")_w.jpg"
    }
}
