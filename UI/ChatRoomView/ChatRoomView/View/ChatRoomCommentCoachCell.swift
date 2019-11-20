//
//  ChatRoomCommentCoachCell.swift
//  ChatRoomView
//
//  Created by Rocoo on 2019/11/19.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import UIKit
import iOSCoreLibrary
import SDWebImage

class ChatRoomCommentCoachCell: UITableViewCell {
    @IBOutlet weak var message: BasicUILabel!
    @IBOutlet weak var time: BasicUILabel!
    @IBOutlet weak var avatar: RoundCornerUIImageView!
    @IBOutlet weak var bubble: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

extension ChatRoomCommentCoachCell: CellConfigurable {

    func setup(viewModel: RowViewModel) {
        guard let viewModel = viewModel as? ChatRoomCommentCoachViewModel else { return }
        message.text = viewModel.message
        time.text = viewModel.time
        avatar.sd_setImage(with: viewModel.avatarURL, placeholderImage: "chatroom-default-avatar".image())
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            self.bubble.rounded(corners: [.topLeft, .topRight, .bottomRight])
        })
    }
}
