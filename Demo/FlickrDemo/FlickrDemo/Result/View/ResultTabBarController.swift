//
//  ResultTabBarController.swift
//  FlickrDemo
//
//  Created by Rocoo on 2020/3/4.
//  Copyright © 2020 rocoo. All rights reserved.
//

import UIKit

class ResultTabBarController: UITabBarController {

    var resultVC: ResultViewController!
    var photosRequestModel: PhotosRequestModel!
    var favoritesVC: FavoritesViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initResultVC()
        initFavoritesVC()
        initViewControllers()
    }
    
    func initResultVC() {
        resultVC = (self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController)
        resultVC.photosRequestModel = photosRequestModel
        resultVC.tabBarItem = UITabBarItem(title: "Photos", image: "star".image(), selectedImage: nil)      
    }
     
    func initFavoritesVC() {
        favoritesVC = (self.storyboard?.instantiateViewController(withIdentifier: "FavoritesViewController") as! FavoritesViewController)
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: "star".image(), selectedImage: nil)
    }

    func initViewControllers() {
        self.viewControllers = [resultVC, favoritesVC]
    }
}
