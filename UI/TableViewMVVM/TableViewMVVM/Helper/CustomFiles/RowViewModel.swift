//
//  RowViewModel.swift
//  TableViewMVVM
//
//  Created by Rocoo on 2019/10/30.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import Foundation

protocol RowViewModel {}

/// Conform this protocol to handles user press action
protocol ViewModelPressible {
    var cellPressed: (() -> Void)? { get set }
}
