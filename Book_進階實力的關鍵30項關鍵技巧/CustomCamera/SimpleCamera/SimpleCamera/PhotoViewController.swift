//
//  PhotoViewController.swift
//  SimpleCamera
//
//  Created by Rocoo on 2016/4/23.
//  Copyright (c) 2016 Rocoo. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    @IBOutlet weak var imageView:UIImageView!

    var image:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
      dismissViewControllerAnimated(true, completion: nil)
    }
  

}
