//
//  ChatRoomCommentCoachCell.swift
//  ChatRoomView
//
//  Created by Rocoo on 2019/11/19.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import UIKit
import iOSCoreLibrary

class ChatRoomCommentCoachCell: UITableViewCell {
    @IBOutlet weak var message: BasicUILabel!
    @IBOutlet weak var time: BasicUILabel!
    @IBOutlet weak var avatar: RoundCornerUIImageView!
    @IBOutlet weak var bubble: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    

}
