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
                DispatchQueue.main.async {
                    self.alertMessage = error.rawValue
                }
            } else {
                self.processFetchPhoto(photos: photos)
            }
        }
    }

    private func processFetchPhoto(photos: [Photo]) {
        print("count: \(photos.count)")
        self.photos = photos
        var vms = [PhotoListCellModel]()
        for photo in photos {
            print("desc: \(photo.description ?? "no desc")")
            let model = createCellModel(photo: photo)
            print("model desc: \(model.descText)")
            vms.append(model)
        }

        self.cellModels = vms
    }

    func createCellModel( photo: Photo ) -> PhotoListCellModel {

        //Wrap a description
        var descTextContainer: [String] = [String]()
        if let camera = photo.camera {
            descTextContainer.append(camera)
        }

        if let description = photo.description {
            descTextContainer.append( description )
        }

        var desc = " "
        if let camera = photo.camera, camera.trimming() != "", let description = photo.description, description.trimming() != "" {
            desc = descTextContainer.joined(separator: " - ")
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        return PhotoListCellModel(titleText: photo.name,
                                  descText: desc,
                                  imageUrl: photo.imageUrl,
                                  dateText: dateFormatter.string(from: photo.createdAt))
    }

    func getCellModel(at indexPath: IndexPath) -> PhotoListCellModel {
        return cellModels[indexPath.row]
    }

    func userPressed( at indexPath: IndexPath ) {
        let photo = self.photos[indexPath.row]
        if photo.forSale {
            self.isAllowSegue = true
            self.selectedPhoto = photo
        } else {
            self.isAllowSegue = false
            self.selectedPhoto = nil
            self.alertMessage = "This item is not for sale"
        }
    }

}
