//
//  ChatRoomViewController.swift
//  ChatRoomView
//
//  Created by Rocoo on 2019/11/19.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import UIKit
import iOSCoreLibrary
class ChatRoomViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputbox: BasicUITextView!
    @IBOutlet weak var send: BasicUIButton!

    lazy var viewModel: ChatRoomViewModel = {
        return ChatRoomViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initBinding()
    }

    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableView.automaticDimension
    }

    func initBinding() {
        viewModel.rowViewModels.addObserver(fireNow: false) { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.fetchData()
    }

}


// MARK: - TableviewDelegate
extension ChatRoomViewController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

}

// MARK: - UITableViewDataSource
extension ChatRoomViewController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowViewModels.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let rowViewModel = viewModel.rowViewModels.value[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier(for: rowViewModel), for: indexPath)

        // TODO: 
        if let cell = cell as? CellConfigurable {
            cell.setup(viewModel: rowViewModel)
        }

        return cell
    }
}


// MARK: - Cell
extension ChatRoomViewController{

}

