//
//  RecipeCollectionViewController.swift
//  CollectionViewDemo
//
//  Created by Rocoo on 2016/5/9.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import UIKit
import Social

private let reuseIdentifier = "Cell"

class RecipeCollectionViewController: UICollectionViewController {
  
  var recipeImages = ["angry_birds_cake", "creme_brelee", "egg_benedict", "full_breakfast", "green_tea", "ham_and_cheese_panini", "ham_and_egg_sandwich", "hamburger", "instant_noodle_with_egg.jpg", "japanese_noodle_with_pork", "mushroom_risotto", "noodle_with_bbq_pork", "starbucks_coffee", "thai_shrimp_cake", "vegetable_curry", "white_chocolate_donut"]
  
  
  @IBOutlet var myCollectionView: UICollectionView!
  @IBOutlet var shareButton: UIBarButtonItem!
  
  var shareEnabled = false
  var selectedRecipes: [String] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    
    myCollectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0), atScrollPosition: .Top, animated: true)
    myCollectionView.reloadData()
    
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier == "showRecipePhoto"{
      // 一次可以選擇很多個item，所以會是個Array
      var indexPaths = (collectionView?.indexPathsForSelectedItems())! as [NSIndexPath]
      let destinationViewController = segue.destinationViewController as! UINavigationController
      let recipeViewController = destinationViewController.viewControllers[0] as! RecipeViewController
      recipeViewController.recipeImageName = recipeImages[indexPaths[0].row]
      collectionView?.deselectItemAtIndexPath(indexPaths[0], animated: false)
    }
    
  }
  
  override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
    if identifier == "showRecipePhoto"{
      //如果已經啟用多選，表示按cell時，不要切換頁面
      if shareEnabled{
        return false
      }
    }
    return true
  }
  
  // MARK - UICollectionViewDelegate
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    if shareEnabled{
      //將選取的照片名稱放到Array
      let selectedRecipe = recipeImages[indexPath.row]
      selectedRecipes.append(selectedRecipe)
    }
  }
  
  override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
    if shareEnabled{
      let deSelectedRecipe = recipeImages[indexPath.row]
      //若選取的名稱已經在Array裡，那就從Array移除
      if let index = recipeImages.indexOf(deSelectedRecipe) {
        recipeImages.removeAtIndex(index)
      }
    }

  }
  
  // MARK - UICollectionViewDataSource
  
  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return recipeImages.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! RecipeCollectionViewCell
    
    // Configure the cell
    cell.recipeImageView.image = UIImage(named: recipeImages[indexPath.row])
    cell.backgroundView = UIImageView(image: UIImage(named: "photo-frame"))
    cell.selectedBackgroundView = UIImageView(image: UIImage(named: "photo-frame-selected"))
    
    return cell
  }
  
  @IBAction func unwindToHome(segue: UIStoryboardSegue){
    
  }
  
  @IBAction func shareButtonTapped(sender: AnyObject) {
    
    //第一次點Share button是要開啟多選功能
    guard shareEnabled else {
      shareEnabled = true
      collectionView?.allowsMultipleSelection = true
      shareButton.title = "Upload"
      shareButton.style = UIBarButtonItemStyle.Done
      return
    }
    
    // 沒有任何照片被選取，return
    guard selectedRecipes.count > 0 else {
      return
    }
    
    // Share to facebook
    if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
      let facebookComposer = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
      facebookComposer.setInitialText("Check out my recipes!")
      
      for recipePhoto in selectedRecipes {
        facebookComposer.addImage(UIImage(named: recipePhoto))
      }
      
      presentViewController(facebookComposer, animated: true, completion: nil)
    }
    
    // 取消所有選取的照片
    if let indexPaths = collectionView?.indexPathsForSelectedItems() {
      for indexPath in indexPaths {
        collectionView?.deselectItemAtIndexPath(indexPath, animated: false)
      }
    }
    
    selectedRecipes.removeAll(keepCapacity: true)
    shareEnabled = false
    collectionView?.allowsMultipleSelection = false
    shareButton.title = "Share"
    shareButton.style = UIBarButtonItemStyle.Plain
    
  }
  
}

extension RecipeCollectionViewController: UICollectionViewDelegateFlowLayout{
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    
    // iPhone Portrait
    let sideSize = (traitCollection.horizontalSizeClass == .Compact && traitCollection.verticalSizeClass == .Regular) ? 80.0: 100.0
    
    return CGSize(width: sideSize, height: sideSize)
  }
  
}


