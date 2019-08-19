//
//  Room.swift
//  ProtocolREST
//
//  Created by Rocoo on 2019/8/18.
//  Copyright © 2019 rocoo. All rights reserved.
//

import Foundation
import SwiftyJSON


struct Rooms {
  
  let rooms: [Room]
  
  init?(data: Data){
    
    guard let roomArray = JSON(data)["items"].array else{
      self.rooms = [Room]()
      return
    }
    
    var rooms = [Room]()
    
    for roomJSON in roomArray{
      rooms.append(Room(json: roomJSON))
    }
    
    self.rooms = rooms
  }
  
}

struct Room {
  
  let id: String
  let imageUrl: String
  let normalDayPrice: Int
  let holidayPrice: Int
  let name: String
  
  init(json: JSON) {
    let id = json["id"].stringValue
    let imageUrl = json["imageUrl"].stringValue
    let normalDayPrice = json["normalDayPrice"].intValue
    let holidayPrice = json["holidayPrice"].intValue
    let name = json["name"].stringValue
    
    self.id = id
    self.imageUrl = imageUrl
    self.normalDayPrice = normalDayPrice
    self.holidayPrice = holidayPrice
    self.name = name
  }
  
}



extension Rooms: Decodable {
  static func parse(data: Data) -> Rooms? {
    return Rooms(data: data)
  }
}

