//
//  TableViewCell.swift
//  TableViewMergeCollectionView
//
//  Created by Geosat-RD01 on 2016/8/25.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
  
 @IBOutlet private weak var collectionView: UICollectionView!
  
  var collectionViewOffset: CGFloat {
    get {
      return collectionView.contentOffset.x
    }
    
    set {
      collectionView.contentOffset.x = newValue
    }
  }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
  
  // The D type conforms to both dataSource and delegate protocol.
  func setCollectionViewDataSourceDelegate
    <D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>
    (dataSourceDelegate: D, forRow row: Int) {
    
    collectionView.delegate = dataSourceDelegate
    collectionView.dataSource = dataSourceDelegate
    collectionView.tag = row
    collectionView.reloadData()
  }

}
