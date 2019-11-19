//
//  ChatRoomCommentCoachViewModel.swift
//  ChatRoomView
//
//  Created by Rocoo on 2019/11/19.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import Foundation

class ChatRoomCommentCoachViewModel: RowViewModel {
    let message: String
    let time: String
    let avatarURL: URL?

    init(message: String, time: String, avatarURL: URL?) {
        self.message = message
        self.time = time
        self.avatarURL = avatarURL
    }
}
