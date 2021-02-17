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
    var isFavorite: Int?
    var owner: Owner?
    var publicationDate: Dates?
    var views: Int?
    
    enum CodingKeys: String, CodingKey {
        case isFavorite = "isfavorite"
        case publicationDate = "dates"
        case owner, views
    }
}

struct Owner: Decodable {
    var fullName: String?
    var location: String?
    
    enum CodingKeys: String, CodingKey {
        case fullName = "realname"
        case location
    }
}

struct Dates: Decodable {
    var taken: String?
}
