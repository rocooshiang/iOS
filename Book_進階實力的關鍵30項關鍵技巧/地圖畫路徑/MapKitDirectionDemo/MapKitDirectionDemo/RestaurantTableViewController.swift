//
//  RestaurantTableViewController.swift
//  MapKitDirectionDemo
//
//  Created by Rocoo on 2016/4/22
//  Copyright (c) 2014 AppCoda. All rights reserved.
//


import UIKit

class RestaurantTableViewController: UITableViewController {
  
  var restaurants:[Restaurant] = [
    Restaurant(name: "台南歷史博物館", category: "台灣", address: "台南市安南區長和路一段250號", image: "台南歷史博物館.jpg"),
    Restaurant(name: "台南奇美博物館", category: "台灣", address: "台南市仁德區文華路二段66號", image: "台南奇美博物館.jpg")
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // Return the number of sections.
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Return the number of rows in the section.
    return restaurants.count
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
    
    // Configure the cell...
    let restaurant = restaurants[indexPath.row]
    cell.textLabel?.text = restaurant.name
    cell.detailTextLabel?.text = restaurant.category
    cell.imageView?.image = UIImage(named: restaurant.image)
    
    return cell
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 80.0
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    if segue.identifier == "showLocation" {
      if let indexPath = self.tableView.indexPathForSelectedRow {
        let destinationController = segue.destinationViewController as! UINavigationController
        let mapViewController = destinationController.childViewControllers.first as! MapViewController
        mapViewController.restaurant = restaurants[indexPath.row]
      }
    }
  }
  
  
  @IBAction func homeScreen(segue:UIStoryboardSegue) {
  }
}
