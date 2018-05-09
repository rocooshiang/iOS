//
//  TagsViewController.swift
//  TagsListView
//
//  Created by Rocoo on 09/05/2018.
//  Copyright © 2018 rocoo. All rights reserved.
//

import UIKit

class TagsViewController: UIViewController {

  @IBOutlet weak var tagsViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var tagsView: UIView!
  
  var tags: [String]!
  override func viewDidLoad() {
    super.viewDidLoad()
    tags = ["Do", "any", "additional", "setup", "after", "loading", "the", "view", ",", "typically", "from", "a", "nib", ".", "Dispose", "of", "any", "resources", "that", "can", "be", "recreated", "."]
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  override func viewDidLayoutSubviews() {
    initTagsListView()
  }
  
  
  fileprivate func initTagsListView(){
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
    
    
    if tags.count != 0{
      
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
        tagsView.addSubview(label)
        if leftEdge + width + referXValue + rightEdge <= tagsViewWidth{
          referXValue += (width + 5)
        }
      }
      
      tagsViewHeightConstraint.constant = tags.count > 0 ? topEdge + bottomEdge + (tagLine * height) + ((tagLine - 1) * verticalSpace) : 0
      print("tagsViewHeightConstraint.constant: \(tagsViewHeightConstraint.constant)")
      self.view.layoutIfNeeded()
    }
  }

}
