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

    @IBOutlet weak var inputboxParentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputbox: RoundCornerTextView!
    @IBOutlet weak var send: RoundCornerUIButton!
    @IBOutlet weak var inputboxParentViewBottomCT: NSLayoutConstraint!

    var isScrollToBottom = false

    lazy var viewModel: ChatRoomViewModel = {
        return ChatRoomViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initBinding()
        keyboardRegistration()
    }

    func initView() {
        self.view.backgroundColor = UIColor(hex: 0xEDEDED)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableView.automaticDimension
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    func initBinding() {
        viewModel.rowViewModels.addObserver(fireNow: false) { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.scrollToBottom()
            }
        }
        viewModel.fetchData()
    }

    @objc func dismissKeyboard() {
      view.endEditing(true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        checkingIsTableViewScrollToBottom(scrollView: scrollView)
    }

    func checkingIsTableViewScrollToBottom(scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom <= height {
            isScrollToBottom = true
        } else {
            isScrollToBottom = false
        }
    }

    func scrollToBottom() {
        let row = self.viewModel.rowViewModels.value.count - 1
        self.tableView.scrollToRow(at: IndexPath(row: row, section: 0), at: .bottom, animated: false)
    }

}

// MARK: - TableviewDelegate
extension ChatRoomViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

}

// MARK: - UITableViewDataSource
extension ChatRoomViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowViewModels.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let rowViewModel = viewModel.rowViewModels.value[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier(for: rowViewModel), for: indexPath)

        if let cell = cell as? CellConfigurable {
            cell.setup(viewModel: rowViewModel)
        }
        return cell
    }
}

// MARK: - Keyboard registration and behavior
extension ChatRoomViewController {
    func keyboardRegistration() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {

        if let info = notification.userInfo, let keyboardFrame = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {

            let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.25

            UIView.animate(withDuration: duration) {
                // change position of inputbox, 37 is height of home indicator
                let homeIndicatorHeight: CGFloat = UIDevice.hasHomeIndicator ? 37 : 0
                self.inputboxParentViewBottomCT.constant = (0 - (keyboardFrame.height - homeIndicatorHeight))
                self.view.layoutIfNeeded()

                // tableview's row scroll to bottom
                if self.isScrollToBottom { self.scrollToBottom() }
            }
      }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if let info = notification.userInfo {
            let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.25

            UIView.animate(withDuration: duration) {
                self.inputboxParentViewBottomCT.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
}
