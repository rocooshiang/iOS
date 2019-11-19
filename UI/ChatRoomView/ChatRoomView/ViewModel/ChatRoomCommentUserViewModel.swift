//
//  ChatRoomCommentUserViewModel.swift
//  ChatRoomView
//
//  Created by Rocoo on 2019/11/19.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import Foundation

class ChatRoomCommentUserViewModel: RowViewModel {
    let message: String
    let time: String

    init(message: String, time: String) {
        self.message = message
        self.time = time
    }
}
