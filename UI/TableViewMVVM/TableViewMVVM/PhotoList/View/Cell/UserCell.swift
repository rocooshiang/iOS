//
//  UserCell.swift
//  TableViewMVVM
//
//  Created by Rocoo on 2019/11/11.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import UIKit
import SDWebImage
import iOSCoreLibrary

class UserCell: UITableViewCell {

    var viewModel: UserCellViewModel?
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: BasicUILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension UserCell: CellConfigurable {
    func setup(viewModel: RowViewModel) {
        guard let viewModel = viewModel as? UserCellViewModel else { return }
        self.viewModel = viewModel

        avatar.sd_setImage(with: URL(string: viewModel.avatarUrlString), placeholderImage: "default".image())
        name.text = viewModel.username
    }
}
