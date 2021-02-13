//
//  ResultInfo.swift
//  QulixSystemsTestTask
//
//  Created by 1 on 2/13/21.
//

import Foundation

struct ResultInfo: Decodable {
    
    var photos: [Photo]?
}

struct Photo: Decodable {
    var id: String?
    var server: String?
    var secret: String?
    var title: String?
    var imageURL: String? {
        "https://live.staticflickr.com/\(server ?? "")/\(id ?? "")_\(secret ?? "")_t.jpg"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, server, secret, title
    }
}
