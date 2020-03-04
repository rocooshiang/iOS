//
//  PhotoResult.swift
//  FlickrDemo
//
//  Created by Rocoo on 2020/3/3.
//  Copyright © 2020 rocoo. All rights reserved.
//

import Foundation

// MARK: - Photos
struct PhotoData: Codable {
    let photo: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let id, secret, server, title: String
    let farm: Int
    var imageUrl: URL? {
       return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg")
    }
}

