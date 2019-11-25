//
//  PhotoListViewModel.swift
//  TableViewMVVM
//
//  Created by Rocoo on 2019/10/17.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import Foundation
import iOSCoreLibrary

struct AlertContent {
    let title: String
    let message: String
}

struct CellPressedContent {
    let photoName: String
    let photoDesc: String?
}

class PhotoListViewModel {

    let apiService: APIServiceProtocol
    let sectionViewModels = Observable<[SectionViewModel]>(value: [])
    var isLoading = Observable<Bool>(value: false)
    var showAlert = Observable<AlertContent>(value: AlertContent(title: "", message: ""))
    var cellPressed = Observable<CellPressedContent>(value: CellPressedContent(photoName: "", photoDesc: ""))

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
                self.buildViewModel(photos: photos)
                self.isLoading.value = false
            }
        }
    }

    private func buildViewModel(photos: [Photo]) {
        self.photos = photos
        var sectionTable = [String: [RowViewModel]]()

        for photo in photos {
            let photoCellVM = buildPhotoCellViewModel(photo: photo)
            let userCellVM = buildUserCellViewModel(photo: photo)
            let rating = String(photo.rating)
            if var rows = sectionTable[rating] {
                var index = -1
                for (idx, row) in rows.enumerated() {
                    if let vm = row as? UserCellViewModel, vm.username == userCellVM.username {
                        index = idx
                    }
                }

                if index == -1 {
                    rows.append(userCellVM)
                    rows.append(photoCellVM)
                } else {
                    rows.insert(photoCellVM, at: index + 1)
                }
                sectionTable[rating] = rows
            } else {
                sectionTable[rating] = [userCellVM, photoCellVM]
            }
        }
        for (key, _) in sectionTable {
            print("key: \(key)")
        }

        self.sectionViewModels.value = coverToSectionViewModel(sectionTable)
    }

    func buildPhotoCellViewModel(photo: Photo) -> PhotoCellViewModel {

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
        let date = dateFormatter.string(from: photo.createdAt)
        let photoCellViewModel = PhotoCellViewModel(title: photo.name, date: date, desc: desc, photoUrl: photo.imageUrl)

        photoCellViewModel.cellPressed = {
            self.cellPressed.value = CellPressedContent(photoName: photo.name, photoDesc: photo.description)
            print("rating: \(photo.rating), user name: \(photo.user.username)")
        }
        return photoCellViewModel
    }

    func buildUserCellViewModel(photo: Photo) -> UserCellViewModel {
        return UserCellViewModel(username: photo.user.username, avatarUrlString: photo.user.userpicHTTPSURL)
    }

    func coverToSectionViewModel(_ sectionTable: [String: [RowViewModel]]) -> [SectionViewModel] {

        let sortedKey = sectionTable.keys.sorted(by: ratingDescComparator())

        return sortedKey.map {
            let rowViewModes = sectionTable[$0]!
            return SectionViewModel(rowViewModels: rowViewModes, headerTitle: $0)
        }
    }

    private func ratingDescComparator() -> ((String, String) -> Bool) {
        return { (rating1Str, rating2Str) -> Bool in
            if let rating1 = Double(rating1Str), let rating2 = Double(rating2Str) {
                return rating1 > rating2
            } else {
                return false
            }
        }
    }

    func cellIdentifier(for viewModel: RowViewModel) -> String {
        switch viewModel {
        case is PhotoCellViewModel:
            return "PhotoCell"
        case is UserCellViewModel:
            return "UserCell"
        default:
            fatalError("Unexpected view model type: \(viewModel)")
        }
    }

}
