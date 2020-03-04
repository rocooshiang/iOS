//
//  PhotosRequest.swift
//  FlickrDemo
//
//  Created by Rocoo on 2020/3/3.
//  Copyright © 2020 rocoo. All rights reserved.
//

import Foundation
import iOSCoreLibrary

struct PhotosRequestModel {
    let searchContent: String
    let countOfDisplayed: String
}

// MARK: - PhotoResult
struct PhotosResult: Codable {
    let photos: PhotoData
    
    init?(data: Data) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            let photosResult = try decoder.decode(PhotosResult.self, from: data)
            self.photos = photosResult.photos
        } catch {
            self.photos = PhotoData(photo: [Photo]())
            print("Decode PhotoResult error: \(error)")
        }
    }
    
}

extension PhotosResult: NetworkingDataDecodable {
    static func parse(data: Data) -> PhotosResult? {
        return PhotosResult(data: data)
    }
}
