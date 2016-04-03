//
//  ViewController.swift
//  ContainerViewDemo
//
//  Created by Geosat-RD01 on 2016/3/30.
//  Copyright © 2016年 Geosat-RD01. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var containerView: UIView!
  weak var currentViewController: UIViewController?
  
  override func viewDidLoad() {
    //隱藏navigationBar
    self.navigationController?.navigationBarHidden = true
    
    self.currentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Page1")
    self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
    self.addChildViewController(self.currentViewController!)
    self.addSubview(self.currentViewController!.view, toView: self.containerView)
    
    super.viewDidLoad()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //隱藏status bar
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  func addSubview(subView:UIView, toView parentView:UIView) {
    parentView.addSubview(subView)
    
    var viewBindingsDict = [String: AnyObject]()
    viewBindingsDict["subView"] = subView
    parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[subView]|",
      options: [], metrics: nil, views: viewBindingsDict))
    parentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[subView]|",
      options: [], metrics: nil, views: viewBindingsDict))
  }
  
  @IBAction func showComponent(sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 0 {
      let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Page1")
      newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
      self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
      self.currentViewController = newViewController
    } else if sender.selectedSegmentIndex == 1{
      let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Page2")
      newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
      self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
      self.currentViewController = newViewController
    }else{
      let newViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Page3")
      newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
      self.cycleFromViewController(self.currentViewController!, toViewController: newViewController!)
      self.currentViewController = newViewController
    }
  }
  
  func cycleFromViewController(oldViewController: UIViewController, toViewController newViewController: UIViewController) {
    oldViewController.willMoveToParentViewController(nil)
    self.addChildViewController(newViewController)
    self.addSubview(newViewController.view, toView:self.containerView!)
    // TODO: Set the starting state of your constraints here
    newViewController.view.layoutIfNeeded()
    
    // TODO: Set the ending state of your constraints here
    
    UIView.animateWithDuration(0.5, animations: {
      // only need to call layoutIfNeeded here
      newViewController.view.layoutIfNeeded()
      },
      completion: { finished in
        oldViewController.view.removeFromSuperview()
        oldViewController.removeFromParentViewController()
        newViewController.didMoveToParentViewController(self)
    })
  }



}

