//
//  PhotoListViewModel.swift
//  TableViewMVVM
//
//  Created by Rocoo on 2019/10/17.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import Foundation

class PhotoListViewModel {
    let apiService: APIServiceProtocol
    var isAllowSegue: Bool = false
    var selectedPhoto: Photo?
    var reloadTableView: (() -> Void)?
    var showAlert: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?

    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }

    private var photos = [Photo]()


    private var cellModels: [PhotoListCellModel] = [PhotoListCellModel]() {
        didSet {
            self.reloadTableView?()
        }
    }

    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }

    var alertMessage: String? {
        didSet {
            self.showAlert?()
        }
    }

    var numberOfCells: Int {
        return cellModels.count
    }

    func initFetch() {
        self.isLoading = true
        apiService.fetchPopularPhoto { (_, photos, error) in
            self.isLoading = false
            if let error = error {
                self.alertMessage = error.rawValue
            } else {
                self.processFetchPhoto(photos: photos)
            }
        }
    }

    private func processFetchPhoto(photos: [Photo]) {
        self.photos = photos
        var vms = [PhotoListCellModel]()
        for photo in photos {
            vms.append(createCellViewModel(photo: photo))
        }
    }

    func createCellViewModel( photo: Photo ) -> PhotoListCellModel {

        //Wrap a description
        var descTextContainer: [String] = [String]()
        if let camera = photo.camera {
            descTextContainer.append(camera)
        }

        if let description = photo.description {
            descTextContainer.append( description )
        }

        let desc = descTextContainer.joined(separator: " - ")

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        return PhotoListCellModel(titleText: photo.name,
                                  descText: desc,
                                  imageUrl: photo.image_url,
                                  dateText: dateFormatter.string(from: photo.created_at))
    }

    func getCellModel(at indexPath: IndexPath) -> PhotoListCellModel {
        return cellModels[indexPath.row]
    }

    func userPressed( at indexPath: IndexPath ) {
        let photo = self.photos[indexPath.row]
        if photo.for_sale {
            self.isAllowSegue = true
            self.selectedPhoto = photo
        } else {
            self.isAllowSegue = false
            self.selectedPhoto = nil
            self.alertMessage = "This item is not for sale"
        }

    }

}
