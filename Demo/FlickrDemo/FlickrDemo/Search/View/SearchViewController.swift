//
//  SearchViewController.swift
//  FlickrDemo
//
//  Created by Rocoo on 2020/3/3.
//  Copyright © 2020 rocoo. All rights reserved.
//

import UIKit
import iOSCoreLibrary

class SearchViewController: UIViewController {

    @IBOutlet weak var searchContent: BasicUITextField!
    @IBOutlet weak var countOfDisplayed: BasicUITextField!
    @IBOutlet weak var search: BasicUIButton!
    
    @IBAction func searchAction(_ sender: Any) {
        viewModel.gotoResultPage(searchContent: searchContent.text!, countOfDisplayed: countOfDisplayed.text!)
    }
    
    lazy var viewModel: SearchViewModel = {
        return SearchViewModel(viewController: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView() {
        adjustSearchButton(enable: false)
        searchContent.addTarget(self, action: #selector(editChanged), for: .editingChanged)
        countOfDisplayed.addTarget(self, action: #selector(editChanged), for: .editingChanged)
        countOfDisplayed.keyboardType = .numberPad
    }
    
    @objc func editChanged() {
        if searchContent.text!.trimming().isEmpty || countOfDisplayed.text!.trimming().isEmpty {
            adjustSearchButton(enable: false)
        } else {
            adjustSearchButton(enable: true)
        }
    }
    
    func adjustSearchButton(enable: Bool) {
        search.isUserInteractionEnabled = enable
        search.backgroundColor = enable ? MyColor.enableBlue : MyColor.disableGray
    }
        
    
}
