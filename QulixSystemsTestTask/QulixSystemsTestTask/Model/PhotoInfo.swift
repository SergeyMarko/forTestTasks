//
//  PhotoInfo.swift
//  QulixSystemsTestTask
//
//  Created by 1 on 2/17/21.
//

import Foundation

struct PhotoInfo: Decodable {
    var info: Info?
    
    enum CodingKeys: String, CodingKey {
        case info = "photo"
    }
}

struct Info: Decodable {
    var owner: Owner?
    var publicationDate: Dates?
    var views: String?
    var description: Description?
    
    enum CodingKeys: String, CodingKey {
        case publicationDate = "dates"
        case owner, views, description
    }
}

struct Owner: Decodable {
    var fullName: String?
    var location: String?
    
    enum CodingKeys: String, CodingKey {
        case fullName = "username"
        case location
    }
}

struct Dates: Decodable {
    var taken: String?
}

struct Description: Decodable {
    var content: String?
    
    enum CodingKeys: String, CodingKey {
        case content = "_content"
    }
}
