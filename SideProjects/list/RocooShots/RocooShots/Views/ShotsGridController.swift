//
//  ShotsGridController.swift
//  RocooShots
//
//  Created by Geosat-RD01 on 2016/6/7.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import Foundation
import UIKit

class ShotsGridController: UIViewController{
  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet var layout: UICollectionViewFlowLayout!
  
  var shots: [Shot]!
  var cellHeight: CGFloat = 240
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Shots"
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = UIColor.clearColor()
    
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = 0
    
    let cellWidth = self.view.frame.width/2
    layout.itemSize = CGSizeMake(cellWidth, cellHeight)
    
    shots = [Shot]()
    let api = DribbbleAPI()
    api.loadShots(didLoadShots)
  }
  
}

// MARK - Custom function
extension ShotsGridController{
  func didLoadShots(shots: [Shot]){
    
    self.shots = shots
    
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
      self.collectionView.reloadData()
    })
  }
  
  func asyncLoadShotImage(shot: Shot, imageView: UIImageView){
    let downloadQueue = dispatch_queue_create("com.RocooShots.processdownload",nil)
    
    dispatch_async(downloadQueue){
      
      let data = NSData(contentsOfURL: NSURL(string: shot.imageUrl)!)
      
      var image: UIImage?
      if data != nil{
        shot.imageData = data
        image = UIImage(data: data!)!
      }
      
      dispatch_async(dispatch_get_main_queue(), { () -> Void in
        imageView.image = image
      })
    }
  }

}


// MARK - UICollectionViewDelegate
extension ShotsGridController: UICollectionViewDelegate{
  
}

// MARK - UICollectionViewDataSource
extension ShotsGridController: UICollectionViewDataSource{
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ShotCell", forIndexPath: indexPath) as! ShotCell
    
    let shot = shots[indexPath.row]
    cell.titleLabel.text = shot.title
    cell.nameLabel.text = shot.user.name
    asyncLoadShotImage(shot, imageView: cell.coverImageView)
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return shots.count
  }
}