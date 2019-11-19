//
//  RowViewModel.swift
//  ChatRoomView
//
//  Created by Rocoo on 2019/11/19.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import Foundation

protocol RowViewModel {}

/// Conform this protocol to handles user press action
protocol ViewModelPressible {
    var cellPressed: (() -> Void)? { get set }
}
