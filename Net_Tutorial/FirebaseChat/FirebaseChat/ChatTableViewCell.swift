//
//  ChatTableViewCell.swift
//  FirebaseChat
//
//  Created by Rocoo on 2016/8/16.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

  @IBOutlet weak var userName: UILabel!
  @IBOutlet weak var message: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
