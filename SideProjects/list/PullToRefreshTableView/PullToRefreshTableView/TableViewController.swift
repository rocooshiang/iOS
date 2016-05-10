//
//  TableViewController.swift
//  PullToRefreshTableView
//
//  Created by Geosat-RD01 on 2016/5/9.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
  
  var nameList = ["Rocoo","Irving","Curry","Iversion"]
  let identifier = "Cell"
  var refreshControler: UIRefreshControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    refreshControler = UIRefreshControl()
    refreshControler.addTarget(self, action: #selector(TableViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
    tableView.addSubview(refreshControler)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  func refresh(sender:AnyObject) {
    nameList += ["Kobe","James","T-Mac"]
    tableView.reloadData()
  }
  
  // MARK: - UITableViewDataSource
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return nameList.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
    cell.accessoryType = .DisclosureIndicator
    cell.textLabel?.text = "row \(indexPath.row)"
    
    return cell
  }
  
  // MARK: - UITableViewDelegate
  override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    
    guard refreshControler.refreshing else{
      return
    }
    refreshControler.endRefreshing()
  }
  
}
