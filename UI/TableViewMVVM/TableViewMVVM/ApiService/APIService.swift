//
//  APIService.swift
//  MVVMPlayground
//
//  Created by Neo on 01/10/2017.
//  Copyright © 2017 ST.Huang. All rights reserved.
//

import Foundation

enum APIError: String, Error {
    case noNetwork = "No Network"
    case dataDecodeIssue = "Some problems with decode data"
}

protocol APIServiceProtocol {
    func fetchPopularPhoto( complete: @escaping ( _ success: Bool, _ photos: [Photo], _ error: APIError? ) -> Void )
}

class APIService: APIServiceProtocol {
    // Simulate a long waiting for fetching 
    func fetchPopularPhoto( complete: @escaping ( _ success: Bool, _ photos: [Photo], _ error: APIError? ) -> Void ) {
        print("fetch Popular photo")
        DispatchQueue.global().async {
            sleep(3)
            let path = Bundle.main.path(forResource: "content", ofType: "json")!
            do {
                guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return }
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                guard let photos = try? decoder.decode(Photos.self, from: data) else {
                    complete(false, [], .dataDecodeIssue)
                    return
                }
                complete(true, photos.photos, nil )
            }
        }
    }

}
