//
//  TagsTableViewController.swift
//  TagsListView
//
//  Created by Rocoo on 09/05/2018.
//  Copyright © 2018 rocoo. All rights reserved.
//

import UIKit

class TagsTableViewController: UITableViewController {
  
  var tags: [String]!
  
  var tagLine: CGFloat = 0
  let tagsViewWidth: CGFloat = Device.screenWidth
  var referXValue: CGFloat = 0
  var referYValue: CGFloat = 0
  let leftEdge: CGFloat = 20
  let rightEdge: CGFloat = 20
  let topEdge: CGFloat = 10
  let bottomEdge: CGFloat = 10
  var height: CGFloat = 0
  let verticalSpace: CGFloat = 5
  
  var isInitTags = false
  
  override func viewDidLoad() {
    super.viewDidLoad()

    tags = ["Uncomment", "the", "following", "line", "to", "loading", "preserve", "selection", "between", "presentations", "self.clearsSelectionOnViewWillAppear", "=", "false", "Uncomment", "the", "following", "line", "to", "display", "an", "Edit", "button", "in", "the", "navigation", "bar", "for", "this", "view", "controller", ".", "self.navigationItem.rightBarButtonItem", "=", "self.editButtonItem", "Uncomment", "the", "following", "line", "to", "loading", "preserve", "selection", "between", "presentations", "self.clearsSelectionOnViewWillAppear", "=", "false", "Uncomment", "the", "following", "line", "to", "display", "an", "Edit", "button", "in", "the", "navigation", "bar", "for", "this", "view", "controller", ".", "self.navigationItem.rightBarButtonItem", "=", "self.editButtonItem"]
  }
  
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  fileprivate func getTagsViewHeight() -> CGFloat{
    
    if tags.count != 0{
      
      referXValue = 0
      referYValue = 0
      
      tagLine = 1
      
      for tag in tags{
        let size = tag.size(withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)])
        let width = size.width + 10
        height = size.height + 15
        
        if leftEdge + width + referXValue + rightEdge > tagsViewWidth{
          tagLine += 1
          referYValue += (height + verticalSpace)
          referXValue = 0
        }
        if leftEdge + width + referXValue + rightEdge <= tagsViewWidth{
          referXValue += (width + 5)
        }
      }
 
      return topEdge + bottomEdge + (tagLine * height) + ((tagLine - 1) * verticalSpace)
      
    }
    
    return 0
  }
  
}


// MARK: - TableviewDelegate
extension TagsTableViewController{
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return getTagsViewHeight()
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
}

// MARK: - UITableViewDataSource
extension TagsTableViewController{
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    return tagsView(indexPath: indexPath)
    
  }
  
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
    
    
  }
  
}

// MARK: - Cell
extension TagsTableViewController{
  
  func tagsView(indexPath: IndexPath) -> DynamicTagsViewCell{
    
    let reuseId = "DynamicTagsViewCell"
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! DynamicTagsViewCell
    
    if tags.count != 0 && !isInitTags{
      isInitTags = true
      
      referXValue = 0
      referYValue = 0
      
      tagLine = 1
      
      for tag in tags{
        
        let size = tag.size(withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)])
        let width = size.width + 10
        height = size.height + 15
        
        if leftEdge + width + referXValue + rightEdge > tagsViewWidth{
          tagLine += 1
          referYValue += (height + verticalSpace)
          referXValue = 0
        }
        
        let label = UILabel(frame: CGRect(x: leftEdge + referXValue, y: topEdge + referYValue, width: width, height: height))
        label.text = tag
        label.font = UIFont.systemFont(ofSize: 18)
        label.layer.cornerRadius = 7.rescaleCornerRadius()
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 1
        label.clipsToBounds = true
        label.textColor = UIColor.white
        label.textAlignment = .center
        cell.contentView.addSubview(label)
        if leftEdge + width + referXValue + rightEdge <= tagsViewWidth{
          referXValue += (width + 5)
        }
      }
      
    }
    
    return cell
  }
  
}
