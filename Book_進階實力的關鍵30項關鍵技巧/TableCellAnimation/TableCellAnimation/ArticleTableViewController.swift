//
//  ArticleTableViewController.swift
//  TableCellAnimation
//
//  Created by Simon Ng on 18/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController {
  let postTitles = ["Use Background Transfer Service To Download File in Background",
    "First Time App Developer Success Stories Part 1",
    "Adding Animated Effects to iOS App Using UIKit Dynamics",
    "Working with Game Center and Game Kit Framework",
    "How to Access iOS Calendar, Events and Reminders",
    "Creating Circular Profile Image"];
  
  let postImages = ["bts.jpg", "first-time-developer.jpg", "uidynamics.jpg", "gamecenter.jpg", "event-kit.jpg", "circular-image.jpg"];
  
  var cellDisplayFlag = [Bool]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    cellDisplayFlag = [Bool](count: postTitles.count, repeatedValue: true)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // Return the number of sections.
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Return the number of rows in the section.
    return postTitles.count
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ArticleTableViewCell
    
    // Configure the cell...
    cell.titleLabel.text = postTitles[indexPath.row]
    cell.postImageView.image = UIImage(named: postImages[indexPath.row])
    
    return cell
  }
  
  
  
  override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    
    // Fade - In
    //fadeInCell(cell)
    
    // Rotate
    //rotateCell(cell)
    
    // Each cell just show once animate
    if cellDisplayFlag[indexPath.row] {
      // Late
      lateCell(cell)
      cellDisplayFlag[indexPath.row] = false
    }
    
  }
  
  func fadeInCell(cell: UITableViewCell){
    /*** Before animate ***/
    cell.alpha = 0
    
    /*** After animate ***/
    UIView.animateWithDuration(1.0, animations: {
      cell.alpha = 1
    })
    
  }
  
  func rotateCell(cell: UITableViewCell){
    
    /*** Before animate ***/
     
     // Angle transform into radians
    let rotationAngleInRadians = 90.0 * CGFloat(M_PI/180.0)
    
    // Use CATransform3DMakeRotation to build rotate status
    let rotationTransform = CATransform3DMakeRotation(rotationAngleInRadians, -500, 100, 0)
    
    cell.layer.transform = rotationTransform
    
    /*** After animate ***/
    UIView.animateWithDuration(1.0, animations: {
      cell.layer.transform = CATransform3DIdentity
    })
    
  }
  
  func lateCell(cell: UITableViewCell){
    
    /*** Before animate ***/
     
     // Use CATransform3DTranslate to build cell enter delay status
    let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 100, 0)
    
    cell.layer.transform = rotationTransform
    
    /*** After animate ***/
    UIView.animateWithDuration(1.0, animations: {
      cell.layer.transform = CATransform3DIdentity
    })
    
  }
  
}
