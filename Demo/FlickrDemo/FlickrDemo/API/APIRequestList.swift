//
//  APIRequestList.swift
//  FlickrDemo
//
//  Created by Rocoo on 2020/3/3.
//  Copyright © 2020 rocoo. All rights reserved.
//

import Foundation
import iOSCoreLibrary

struct Url {
    static let flickrBaseUrl = "https://www.flickr.com"
}

class API {
    struct PhotosRequest: Request {
        var model: PhotosRequestModel
        var host: String { return Url.flickrBaseUrl }
        var path: String { return "/services/rest/?method=flickr.photos.search&api_key=2a605385b3f72f408756325aacf4c28f&text=\(model.searchContent.percentEncoding())&per_page=\(model.countOfDisplayed.percentEncoding())&format=json&nojsoncallback=1" }
        let method: HttpMethod = .get
        var logResponseData: Bool { return true }
        typealias Response = PhotosResult
    }
}
