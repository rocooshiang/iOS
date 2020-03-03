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
    let photoData: PhotoData
    
    init?(data: Data) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            let photosResult = try decoder.decode(PhotosResult.self, from: data)
            self.photoData = photosResult.photoData
        } catch {
            self.photoData = PhotoData(photos: [Photo]())
            print("Decode PhotoResult error: \(error)")
        }
    }
    
}

extension PhotosResult: NetworkingDataDecodable {
    static func parse(data: Data) -> PhotosResult? {
        return PhotosResult(data: data)
    }
}
