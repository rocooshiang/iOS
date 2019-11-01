//
//  CellConfigurable.swift
//  TableViewMVVM
//
//  Created by Rocoo on 2019/10/30.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import Foundation

protocol CellConfigurable {
    func setup(viewModel: RowViewModel)
}
