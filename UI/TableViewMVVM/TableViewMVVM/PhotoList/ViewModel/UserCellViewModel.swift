//
//  UserCellViewModel.swift
//  TableViewMVVM
//
//  Created by Rocoo on 2019/11/11.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import Foundation

class UserCellViewModel: RowViewModel {

    let username: String
    let avatarUrlString: String

    init(username: String, avatarUrlString: String) {
        self.username = username
        self.avatarUrlString = avatarUrlString
    }
}
