//
//  SearchViewModel.swift
//  FlickrDemo
//
//  Created by Rocoo on 2020/3/3.
//  Copyright © 2020 rocoo. All rights reserved.
//

import Foundation

class SearchViewModel {    
    
    let viewController: SearchViewController!
    init(viewController: SearchViewController) {
        self.viewController = viewController
    }
    
    func gotoResultPage(searchContent: String, countOfDisplayed: String) {
        
//        if let vc = viewController.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController {
//            vc.photosRequestModel = PhotosRequestModel(searchContent: searchContent, countOfDisplayed: countOfDisplayed)
//            viewController.navigationController?.pushViewController(vc, animated: true)
//        }

        if let vc = viewController.storyboard?.instantiateViewController(withIdentifier: "ResultTabBarController") as? ResultTabBarController {
            vc.photosRequestModel = PhotosRequestModel(searchContent: searchContent, countOfDisplayed: countOfDisplayed)
            
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}


