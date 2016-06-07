//
//  Shot.swift
//  RocooShots
//
//  Created by Geosat-RD01 on 2016/6/7.
//  Copyright © 2016年 Rocoo. All rights reserved.
//

import Foundation

class Shot{
  
  var id: Int!
  var title: String!
  var date: String!
  var description: String!
  var commentCount: Int!
  var likesCount: Int!
  var viewsCount: Int!
  var commentUrl: String!
  var imageUrl: String!
  
  var imageData: NSData?
  
  var user: User!
  
  init(data: NSDictionary){
    
    self.id = data["id"] as! Int
    self.commentCount = data["comments_count"] as! Int
    self.likesCount = data["likes_count"] as! Int
    self.viewsCount = data["views_count"] as! Int
    
    self.commentUrl = Utils.getStringFromJSON(data, key: "comments_url")
    self.title = Utils.getStringFromJSON(data, key: "title")
    
    let dateInfo = Utils.getStringFromJSON(data, key: "created_at")
    self.date = dateInfo
    
    let desc = Utils.getStringFromJSON(data, key: "description")
    self.description = desc
    
    let images = data["images"] as! NSDictionary
    self.imageUrl = Utils.getStringFromJSON(images, key: "normal")
    
    if let userData = data["user"] as? NSDictionary{
      self.user = User(data: userData)
    }
    
  }
  
}