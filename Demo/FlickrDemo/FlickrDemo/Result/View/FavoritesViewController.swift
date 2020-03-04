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
        initBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {        
        viewModel.fetchFavorites()
    }
    
    func initBinding() {
        viewModel.favorites.value.removeAll()
        viewModel.favorites.addObserver(fireNow: false) { [weak self] _ in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func initView() {
        self.tabBarController?.navigationItem.title = "我的最愛"
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
    
}
