//
//  ResultViewController.swift
//  FlickrDemo
//
//  Created by Rocoo on 2020/3/3.
//  Copyright © 2020 rocoo. All rights reserved.
//

import UIKit
class ResultViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var photosRequestModel: PhotosRequestModel!
    
    lazy var viewModel: ResultViewModel = {
        return ResultViewModel.share
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initBinding()
    }
    
    func initBinding() {
        viewModel.photos.value.removeAll()
        viewModel.photos.addObserver(fireNow: false) { [weak self] _ in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        viewModel.fetchPhotos(requestModel: photosRequestModel)
    }
    
    func initView() {
        self.tabBarController?.navigationItem.title = "收尋結果 美食"
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ResultViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let photo = viewModel.photos.value[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCVCell", for: indexPath) as! PhotosCVCell
        cell.setup(photo: photo)
        cell.add.tag = indexPath.row
        cell.add.addTarget(self, action: #selector(addToFavoriteList(sender:)), for: .touchUpInside)
        return cell
    }
    
    @objc func addToFavoriteList(sender: UIButton) {        
        viewModel.addPhotoToFavoriteList(tag: sender.tag)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.bounds.width - 10) / 2        
        return CGSize(width: width, height: width + 30)
    }


}


