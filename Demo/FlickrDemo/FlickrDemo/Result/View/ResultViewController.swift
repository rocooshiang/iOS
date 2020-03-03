//
//  ResultViewController.swift
//  FlickrDemo
//
//  Created by Rocoo on 2020/3/3.
//  Copyright © 2020 rocoo. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var photosRequestModel: PhotosRequestModel!
    
    lazy var viewModel: ResultViewModel = {
        return ResultViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBinding()
    }
    
    func initBinding() {
        viewModel.photos.addObserver(fireNow: false) { (photos) in
            for photo in photos {
                print("title: \(photo.title)")
            }
        }
        
        viewModel.fetchPhotos(requestModel: photosRequestModel)
    }
    
    
        
}
