//
//  Event.swift
//  MVVMPlayground
//
//  Created by Neo on 01/10/2017.
//  Copyright © 2017 ST.Huang. All rights reserved.
//

import Foundation
struct Photos: Codable {
    let photos: [Photo]
}

struct Photo: Codable {
    let id: Int
    let name: String
    let description: String?
    let createdAt: Date
    let imageUrl: String
    let forSale: Bool
    let camera: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case createdAt = "created_at"
        case imageUrl = "image_url"
        case forSale = "for_sale"
        case camera
    }
}
