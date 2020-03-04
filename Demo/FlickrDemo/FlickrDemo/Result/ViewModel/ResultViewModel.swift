//
//  ResultViewModel.swift
//  FlickrDemo
//
//  Created by Rocoo on 2020/3/3.
//  Copyright © 2020 rocoo. All rights reserved.
//

import Foundation
import iOSCoreLibrary

class ResultViewModel {

    static let share = ResultViewModel()
    
    let photos = Observable<[Photo]>(value: [Photo]())
    let favorites = Observable<[Photo]>(value: [Photo]())
    
    func fetchPhotos(requestModel: PhotosRequestModel) {
        let request = API.PhotosRequest(model: requestModel)
        
        ApiService.shared.send(request) { (result, _) in
            if let photosResult = result {
                self.photos.value = photosResult.photos.photo
            }
        }
    }
    
    func addPhotoToFavoriteList(tag: Int) {
        let photos = self.photos.value
        var photo = photos[tag]
        photo.favorite = true
        self.photos.value = photos
    }
}
