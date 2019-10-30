//
//  FeedListViewController.swift
//  TableViewMVVM
//
//  Created by Rocoo on 2019/10/15.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import UIKit
import SDWebImage
import iOSCoreLibrary

class PhotoListController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    lazy var viewModel: PhotoListViewModel = {
        return PhotoListViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initViewModel()
    }

    func initTableView() {
        self.navigationItem.title = "Popular"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 150
        tableView.rowHeight =  UITableView.automaticDimension
    }

    func initViewModel() {
//        viewModel.showAlert.addObserver { [weak self] (error) in
//            DispatchQueue.main.async {
//                print("title: \(error.title), message: \(error.message)")
//                    self?.present(alertControllerBuilder(title: error.title, message: error.message, firstButtonTitle: "OK", secondButtonTitle: nil) { (_, _) in
//
//                    }, animated: true, completion: nil)
//                }
//        }

        viewModel.showAlert.addObserver(fireNow: true) { [weak self] (alertContent) in
            DispatchQueue.main.async {
                print("message: \(alertContent.message)")
                if alertContent.message.isEmpty { return }
                self?.present(alertControllerBuilder(title: alertContent.title, message: alertContent.message, firstButtonTitle: "OK", secondButtonTitle: nil) { (_, _) in

                }, animated: true, completion: nil)
            }
        }

        viewModel.isLoading.addObserver { [weak self] (isLoading) in
            DispatchQueue.main.async {
                if isLoading {
                    self?.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tableView.alpha = 0.0
                    })
                } else {
                    self?.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tableView.alpha = 1.0
                    })
                }
            }
        }

        viewModel.cellViewModels.addObserver(fireNow: false) { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        viewModel.startFetching()
    }

}

// MARK: - TableviewDelegate
extension PhotoListController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.viewModel.userPressed(at: indexPath)
        if viewModel.isAllowSegue {
            return indexPath
        } else {
            return nil
        }
    }
}

// MARK: - UITableViewDataSource
extension PhotoListController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("viewModel.cellViewModels.value.count: \(viewModel.cellViewModels.value.count)")
        return viewModel.cellViewModels.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowViewModel = viewModel.cellViewModels.value[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier(for: rowViewModel), for: indexPath)

        if let cell = cell as? CellConfigurable {
            cell.setup(viewModel: rowViewModel)
        }
        return cell
    }

}
