//
//  PhotoCellVIewModel.swift
//  TableViewMVVM
//
//  Created by Rocoo on 2019/10/29.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import Foundation

class PhotoCellViewModel: RowViewModel, ViewModelPressible {

    let title: String
    let desc: String
    let date: String
    let photoUrl: String
    var cellPressed: (() -> Void)?

    init(title: String, date: String, desc: String, photoUrl: String) {
        self.title = title
        self.desc = desc
        self.date = date
        self.photoUrl = photoUrl
    }
}
