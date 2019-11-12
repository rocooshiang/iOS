//
//  Photo.swift
//  TableViewMVVM
//
//  Created by Rocoo on 2019/10/15.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import Foundation
struct Photos: Codable {
    let photos: [Photo]
}

struct Photo: Codable {
    let id: Int
    let name: String
    let description: String?
    let rating: Double
    let createdAt: Date
    let imageUrl: String
    let forSale: Bool
    let camera: String?
    let user: User

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case rating
        case createdAt = "created_at"
        case imageUrl = "image_url"
        case forSale = "for_sale"
        case camera
        case user
    }
}

// MARK: - User
struct User: Codable {
    let id: Int
    let username, firstname: String
    let lastname: String?
    let city, country: String
    let usertype: Int
    let fullname: String
    let userpicURL, userpicHTTPSURL: String

    enum CodingKeys: String, CodingKey {
        case id, username, firstname, lastname, city, country, usertype, fullname
        case userpicURL = "userpic_url"
        case userpicHTTPSURL = "userpic_https_url"
    }
}
