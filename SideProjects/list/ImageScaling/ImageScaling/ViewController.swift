//
//  ViewController.swift
//  ImageScaling
//
//  Created by Rocoo on 2016/5/13.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var myImage: UIImageView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
  @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
  @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
  
  override func viewDidLoad() {

    updateMinZoomScaleForSize(view.bounds.size)
  }
  
  private func updateMinZoomScaleForSize(size: CGSize){
    let widthScale = size.width / myImage.bounds.width
    let heightScale = size.height / myImage.bounds.height
    let minScale = min(widthScale, heightScale)
    
    scrollView.minimumZoomScale = minScale
    scrollView.zoomScale = minScale
  }
  
  private func updateConstraintsForSize(size: CGSize){
    let yOffset = max(0, (size.height - myImage.frame.height)/2 )
    imageViewTopConstraint.constant = yOffset
    imageViewBottomConstraint.constant = yOffset
    
    let xOffset = max(0, (size.width - myImage.frame.width)/2 )
    imageViewLeadingConstraint.constant = xOffset
    imageViewTrailingConstraint.constant = xOffset
    
    view.layoutIfNeeded()
    
  }
  
}

extension ViewController: UIScrollViewDelegate{

  func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
    return myImage
  }
  
  func scrollViewDidZoom(scrollView: UIScrollView) {
    updateConstraintsForSize(view.bounds.size)
  }
  
}

