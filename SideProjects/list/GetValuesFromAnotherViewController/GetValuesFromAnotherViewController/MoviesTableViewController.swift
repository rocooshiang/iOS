//
//  MoviesTableViewController.swift
//  GetValuesFromAnotherViewController
//
//  Created by Rocoo on 2016/5/10.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {
  
    let identifier = "Cell"
    var movies : Movies?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      movies = Movies(names: "Movie1","Movie2","Movie3")
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "newMovie"{
      let vc = segue.destinationViewController as! NewMoviesViewController
      vc.delegate = self
    }
  }

    // MARK: - UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return movies!.list.count
    }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
    
    cell.textLabel?.text = movies?.list[indexPath.row]
    
    return cell
  }
}

// MARK - NewMoviesViewControllerDelegate
extension MoviesTableViewController: NewMoviesViewControllerDelegate{
  func didDisappearViewController(controller: NewMoviesViewController, movie: String) {
    
    movies?.addMovie(movie)
    self.tableView.reloadData()
    
    controller.navigationController?.popViewControllerAnimated(true)
  }
}
