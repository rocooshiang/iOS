//
//  ViewController.swift
//  BasicTableVIew
//
//  Created by Geosat-RD01 on 2016/5/3.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var tableView: UITableView!
  let nameList = ["Rocoo","Irving","Iversion"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
}

// MARK: - UITableViewDelegate
extension ViewController : UITableViewDelegate{
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 60
  }
}

// MARK: - UITableViewDataSource
extension ViewController : UITableViewDataSource{
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return nameList.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    //Default cell
    var cell = tableView.dequeueReusableCellWithIdentifier("Cell")
    if cell == nil {
      cell = UITableViewCell(style: .Default ,reuseIdentifier: "Cell")
    }
    cell?.accessoryType = .DisclosureIndicator
    cell?.textLabel?.text = nameList[indexPath.row]
    
    return cell!
  }
  
}

