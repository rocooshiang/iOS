//
//  PhotoListTableViewCell.swift
//  TableViewMVVM
//
//  Created by Rocoo on 2019/10/17.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import UIKit

class PhotoListTableViewCell: UITableViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descContainerHeightConstraint: NSLayoutConstraint!
    var photoListCellModel : PhotoListCellModel? {
        didSet {
            nameLabel.text = photoListCellModel?.titleText
            descriptionLabel.text = photoListCellModel?.descText
            mainImageView?.sd_setImage(with: URL( string: photoListCellModel?.imageUrl ?? "" ), completed: nil)
            dateLabel.text = photoListCellModel?.dateText
        }
    }

}
