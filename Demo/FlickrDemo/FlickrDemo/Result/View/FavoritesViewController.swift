//
//  FavoritesViewController.swift
//  FlickrDemo
//
//  Created by Rocoo on 2020/3/4.
//  Copyright © 2020 rocoo. All rights reserved.
//

import UIKit
import iOSCoreLibrary

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    lazy var viewModel: ResultViewModel = {
        return ResultViewModel.share
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    
    func initView() {
        self.navigationController?.navigationItem.title = "我的最愛"
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {        
        return viewModel.favorites.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let photo = viewModel.favorites.value[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesPhotoCVCell", for: indexPath) as! FavoritesPhotoCVCell
        cell.setup(photo: photo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.bounds.width - 10) / 2
        return CGSize(width: width, height: width + 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did select: \(indexPath.row)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
}
