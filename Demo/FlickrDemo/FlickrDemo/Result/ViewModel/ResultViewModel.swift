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
                self.setPhotos(apiPhotos: photosResult.photos.photo)
            }
        }
    }
    
    fileprivate func setPhotos(apiPhotos: [Photo]){
        var newPhotos = apiPhotos
        if let favoritesData = UserDefaults.standard.data(forKey: "favorites"), let oldPhotos = try? JSONDecoder().decode([Photo].self, from: favoritesData) {
            for index in 0..<newPhotos.count {
                for oldPhoto in oldPhotos {
                    if newPhotos[index].id == oldPhoto.id {
                        newPhotos[index].favorite = true
                        break
                    }
                }
            }
        }
        self.photos.value = newPhotos
    }
    
    func addPhotoToFavoriteList(tag: Int) {
        var photos = self.photos.value
        var photo = photos[tag]
        photo.favorite = true
        photos[tag] = photo
        self.photos.value = photos
    }
    
    func fetchFavorites() {
        var favorites = [Photo]()
        for photo in self.photos.value {
            if photo.favorite {
                favorites.append(photo)
            }
        }
        
        self.favorites.value = favorites
        if let data = try? JSONEncoder().encode(favorites), !favorites.isEmpty {
            UserDefaults.standard.set(data, forKey: "favorites")
        }
    }
}

