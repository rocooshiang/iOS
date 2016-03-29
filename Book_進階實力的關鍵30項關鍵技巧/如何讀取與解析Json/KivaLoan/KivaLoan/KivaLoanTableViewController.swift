//
//  KivaLoanTableViewController.swift
//  KivaLoan
//
//  Created by Simon Ng on 20/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

import UIKit

class KivaLoanTableViewController: UITableViewController {
  
  let kivaLoadURL = "http://api.kivaws.org/v1/loans/newest.json"
  var loans = [Loan]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
      getLatestLoans()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return loans.count
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! KivaLoanTableViewCell
    
    cell.nameLabel.text = loans[indexPath.row].name
    cell.countryLabel.text = loans[indexPath.row].country
    cell.useLabel.text = loans[indexPath.row].use
    cell.amountLabel.text = "$\(loans[indexPath.row].amount)"
    
    
    return cell
  }
  
  func getLatestLoans(){
    let request = NSURLRequest(URL: NSURL(string: kivaLoadURL)!)
    let urlSession = NSURLSession.sharedSession()
    
    let task = urlSession.dataTaskWithRequest(request, completionHandler: { (data, response , error) -> Void in
      
      if error != nil{
        print(error?.localizedDescription)
      }
      
      // 解析Json資料
      self.loans = self.parseJsonData(data!)
      
      // 重新載入表格視圖
      dispatch_async(dispatch_get_main_queue(), { () -> Void in
        self.tableView.reloadData()
      })
      
    })
    
    task.resume()
  }
  
  func parseJsonData(data: NSData) -> [Loan]{
    var loans = [Loan]()
    
    do{
      let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? NSDictionary
      
      let jsonLoans = jsonResult?["loans"] as! [AnyObject]
      
      for jsonLoan in jsonLoans{
        let loan = Loan()
        loan.name = jsonLoan["name"] as! String
        loan.amount = jsonLoan["loan_amount"] as! Int
        loan.use = jsonLoan["use"] as! String
        
        let location = jsonLoan["location"] as! [String: AnyObject]
        loan.country = location["country"] as! String
        
        loans.append(loan)
      }
      
    }catch let error as NSError{
      print("Error in parseJson: \(error.localizedDescription)")
    }
    
    return loans
  }
  
}
