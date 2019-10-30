//
//  PhotoListTableViewCell.swift
//  TableViewMVVM
//
//  Created by Rocoo on 2019/10/17.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import UIKit
import iOSCoreLibrary

class PhotoCell: UITableViewCell {

    @IBOutlet weak var title: BasicUILabel!
    @IBOutlet weak var desc: BasicUILabel!
    @IBOutlet weak var date: BasicUILabel!
    @IBOutlet weak var photo: UIImageView!

    var viewModel: PhotoCellViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        title.textColor = .black
        desc.textColor = .black
        date.textColor = .black
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel?.cellPressed = nil
    }

}

extension PhotoCell: CellConfigurable {
    func setup(viewModel: RowViewModel) {
        guard let viewModel = viewModel as? PhotoCellViewModel else { return }
        self.viewModel = viewModel
        self.title.text = viewModel.title
        self.desc.text = viewModel.desc
        self.desc.text = "viewModel.desc, viewModel.desc, viewModel.desc"
        photo?.sd_setImage(with: URL(string: viewModel.photoUrl), placeholderImage: defaultViewImage)
    }
}
