//
//  RecipeViewController.swift
//  CollectionViewDemo
//
//  Created by Geosat-RD01 on 2016/5/9.
//  Copyright © 2016年 AppCoda. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {

  @IBOutlet var recipeImageView: UIImageView!
  var recipeImageName: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
      recipeImageView.image = UIImage(named: recipeImageName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}
