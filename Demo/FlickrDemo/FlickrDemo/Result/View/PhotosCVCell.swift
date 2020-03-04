//
//  PhotosCVCell.swift
//  FlickrDemo
//
//  Created by Rocoo on 2020/3/4.
//  Copyright © 2020 rocoo. All rights reserved.
//

import UIKit
import iOSCoreLibrary
import SDWebImage

class PhotosCVCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var title: BasicUILabel!
    @IBOutlet weak var add: UIButton!
    
    func setup(photo: Photo) {
        self.photo.sd_setImage(with: photo.imageUrl, placeholderImage: "default".image())
        self.title.text = photo.title        
        self.add.isHidden = photo.favorite
    }
    
}


