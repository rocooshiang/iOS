//
//  ResultViewController.swift
//  FlickrDemo
//
//  Created by Rocoo on 2020/3/3.
//  Copyright © 2020 rocoo. All rights reserved.
//

import UIKit
// 065058019
class ResultViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var photosRequestModel: PhotosRequestModel!
    
    lazy var viewModel: ResultViewModel = {
        return ResultViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initBinding()
    }
    
    func initBinding() {
        viewModel.photos.addObserver(fireNow: false) { [weak self] _ in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        viewModel.fetchPhotos(requestModel: photosRequestModel)
    }
    
    func initView() {
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
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.bounds.width - 10) / 2
        print("width: \(width)")
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


