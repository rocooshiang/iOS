//
//  ShotCell.swift
//  RocooShots
//
//  Created by Geosat-RD01 on 2016/6/7.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import Foundation
import UIKit

class ShotCell: UICollectionViewCell {
  @IBOutlet var coverImageView: UIImageView!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var titleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    nameLabel.textColor = UIColor(white: 0.45, alpha: 1.0)
    nameLabel.font = UIFont(name: MegaTheme.fontName, size: 11)
    
    titleLabel.textColor = UIColor.blackColor()
    titleLabel.font = UIFont(name: MegaTheme.fontName, size: 14)
    
    coverImageView.layer.borderColor = UIColor(white: 0.2, alpha: 1.0).CGColor
    coverImageView.layer.borderWidth = 0.5
  }
}