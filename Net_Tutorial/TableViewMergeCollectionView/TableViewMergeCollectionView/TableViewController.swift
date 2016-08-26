//
//  TableViewController.swift
//  TableViewMergeCollectionView
//
//  Created by Geosat-RD01 on 2016/8/25.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

  var storedOffsets = [Int: CGFloat]()
  
  let sectionName = ["Type1","Type2","Type3","Type4"]
  var items = [[UIColor]]()
  
  var data: [String:[UIColor]]!
  override func viewDidLoad() {
    super.viewDidLoad()
    items = generateRandomData()
  }
  
  
  // MARK: - Table view data source
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sectionName[section]
  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return sectionName.count
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 87
  }
  
  override func tableView(tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView,
                          cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell",
                                                           forIndexPath: indexPath)
    return cell
  }
  
  override func tableView(tableView: UITableView,
                          willDisplayCell cell: UITableViewCell,
                                          forRowAtIndexPath indexPath: NSIndexPath) {
    
    guard let tableViewCell = cell as? TableViewCell else {
      return
    }
    
    tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
    tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
  }
  
  override func tableView(tableView: UITableView,
                          didEndDisplayingCell cell: UITableViewCell,
                                               forRowAtIndexPath indexPath: NSIndexPath) {
    
    guard let tableViewCell = cell as? TableViewCell else { return }
    
    storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
  }
}

extension TableViewController{
  func generateRandomData() -> [[UIColor]] {
    let numberOfRows = sectionName.count
    let numberOfItemsPerRow = 15
    
    return (0..<numberOfRows).map { _ in
      return (0..<numberOfItemsPerRow).map { _ in UIColor.randomColor() }
    }
  }
}

extension UIColor {
  class func randomColor() -> UIColor {
    
    let hue = CGFloat(arc4random() % 100) / 100
    let saturation = CGFloat(arc4random() % 100) / 100
    let brightness = CGFloat(arc4random() % 100) / 100
    
    return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
  }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension TableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    
    return items[section].count
  }
  
  func collectionView(collectionView: UICollectionView,
                      cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell",
                                                                     forIndexPath: indexPath)
    
    cell.backgroundColor = items[indexPath.section][indexPath.item]
    
    return cell
  }
}
