//
//  PhotoListViewController_Pad.swift
//  TableViewMVVM
//
//  Created by Rocoo on 2019/11/7.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import UIKit
import SDWebImage
import iOSCoreLibrary

class PhotoListViewController_Pad: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    lazy var viewModel: PhotoListViewModel = {
        return PhotoListViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("run pad")
        initLayout()
        initBinding()
    }

    func initLayout() {
        self.navigationItem.title = "Popular"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 250
        tableView.rowHeight =  UITableView.automaticDimension
    }

    func initBinding() {
        viewModel.showAlert.addObserver { [weak self] (alertContent) in
            DispatchQueue.main.async {
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

        viewModel.sectionViewModels.addObserver(fireNow: false) { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }


        viewModel.cellPressed.addObserver { [weak self] (content) in
            if content.photoName.isEmpty { return }
            DispatchQueue.main.async {
                self?.present(alertControllerBuilder(title: content.photoName, message: content.photoDesc, firstButtonTitle: "Okay", secondButtonTitle: nil), animated: true, completion: nil)
            }
        }

        viewModel.startFetching()
    }

}

// MARK: - TableviewDelegate
extension PhotoListViewController_Pad: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionViewModel = viewModel.sectionViewModels.value[indexPath.section]
        if let rowViewModel = sectionViewModel.rowViewModels[indexPath.row] as? ViewModelPressible {
            rowViewModel.cellPressed?()
        }
    }
}

// MARK: - UITableViewDataSource
extension PhotoListViewController_Pad: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionViewModels.value.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionViewModel = viewModel.sectionViewModels.value[section]
        return sectionViewModel.rowViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionViewModel = viewModel.sectionViewModels.value[indexPath.section]
        let rowViewModel = sectionViewModel.rowViewModels[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier(for: rowViewModel), for: indexPath)

        if let cell = cell as? CellConfigurable {
            cell.setup(viewModel: rowViewModel)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionViewModels.value[section].headerTitle
    }
}
