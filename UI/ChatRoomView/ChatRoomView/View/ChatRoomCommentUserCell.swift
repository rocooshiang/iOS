//
//  ChatRoomCommentUserCell.swift
//  ChatRoomView
//
//  Created by Rocoo on 2019/11/19.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import UIKit
import iOSCoreLibrary

class ChatRoomCommentUserCell: UITableViewCell {

    @IBOutlet weak var message: BasicUILabel!
    @IBOutlet weak var time: BasicUILabel!
    @IBOutlet weak var bubble: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

extension ChatRoomCommentUserCell: CellConfigurable {

    func setup(viewModel: RowViewModel) {
        guard let viewModel = viewModel as? ChatRoomCommentUserViewModel else { return }
        message.text = viewModel.message
        time.text = viewModel.time
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.bubble.rounded(corners: [.topLeft, .topRight, .bottomLeft])
        })
    }
}
