//
//  Movies.swift
//  GetValuesFromAnotherViewController
//
//  Created by Rocoo on 2016/5/10.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import UIKit

class Movies{
  
  var list: [String] = []
  
  init(names: String...){
    for name in names{
      if !name.isEmpty{
        list.append(name)
      }
    }
  }
  
  func addMovie(name: String){
    if !name.isEmpty {
      list.append(name)
    }
  }
  
}
