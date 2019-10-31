//
//  PhotoListViewModel.swift
//  TableViewMVVM
//
//  Created by Rocoo on 2019/10/17.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import Foundation

struct AlertContent {
    let title: String
    let message: String
}

class PhotoListViewModel {

    let apiService: APIServiceProtocol
    var isAllowSegue: Bool = false
    var selectedPhoto: Photo?
    let cellViewModels = Observable<[RowViewModel]>(value: [])
    var isLoading = Observable<Bool>(value: false)
    var showAlert = Observable<AlertContent>(value: AlertContent(title: "", message: ""))

    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }

    private var photos = [Photo]()

    func startFetching() {
        self.isLoading.value = true
        apiService.fetchPopularPhoto { (_, photos, error) in
            if let error = error, true {
                self.isLoading.value = false
                self.showAlert.value = AlertContent(title: "Alert", message: error.rawValue)
            } else {
                self.processFetchPhoto(photos: photos)
                self.isLoading.value = false
            }
        }
    }

    private func processFetchPhoto(photos: [Photo]) {
        self.photos = photos
        var vms = [PhotoCellViewModel]()
        for photo in photos {
            let model = createCellViewModel(photo: photo)
            vms.append(model)
        }

        self.cellViewModels.value = vms
    }

    func createCellViewModel(photo: Photo) -> PhotoCellViewModel {

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

        let photoCellViewModel = PhotoCellViewModel(title: photo.name, date: dateFormatter.string(from: photo.createdAt), desc: desc, photoUrl: photo.imageUrl)

        return photoCellViewModel
    }

    func userPressed( at indexPath: IndexPath ) {
        let photo = self.photos[indexPath.row]
        if photo.forSale {
            self.isAllowSegue = true
            self.selectedPhoto = photo
        } else {
            self.isAllowSegue = false
            self.selectedPhoto = nil
//            self.alertMessage = "This item is not for sale"
        }
    }

    func cellIdentifier(for viewModel: RowViewModel) -> String {
        switch viewModel {
        case is PhotoCellViewModel:
            return "PhotoCell"
        default:
            fatalError("Unexpected view model type: \(viewModel)")
        }
    }

}
