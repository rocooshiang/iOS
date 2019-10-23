//
//  PhotoListTableViewCell.swift
//  TableViewMVVM
//
//  Created by Rocoo on 2019/10/17.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import UIKit
import iOSCoreLibrary

class PhotoListTableViewCell: UITableViewCell {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var date: BasicUILabel!
    @IBOutlet weak var photoDescription: BasicUILabel!
    @IBOutlet weak var name: BasicUILabel!
    var photoListCellModel : PhotoListCellModel? {
        didSet {
            photo?.sd_setImage(with: URL(string: photoListCellModel?.imageUrl ?? ""), placeholderImage: defaultViewImage)
            name.text = photoListCellModel?.titleText
            photoDescription.text = photoListCellModel?.descText
            photoDescription.text = "photoListCellModel?.descText photoListCellModel?.descText photoListCellModel?.descText"
            date.text = photoListCellModel?.dateText
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        name.textColor = .black
        photoDescription.textColor = .black
        date.textColor = .black
    }

}
