//
//  ChatRoomComment.swift
//  ChatRoomView
//
//  Created by Rocoo on 2019/11/19.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import Foundation

struct FoodElement: Codable {
    let foodLogID: Int
    let nickName: String
    let tags: [String]
    let bld: String
    let calories: Int
    let isFood: Bool
    let pictureURL: String
    let comments: [[String: Comment]]
    let createDate, rate, serviceAccount, dietitian: String

    enum CodingKeys: String, CodingKey {
        case foodLogID = "foodLogId"
        case nickName, tags, bld, calories, isFood
        case pictureURL = "pictureUrl"
        case comments, createDate, rate, serviceAccount, dietitian
    }
}

struct Comment: Codable {
    let nickName, comment, serviceAccount: String
    let profileImage: String
    let isCoachComment: Bool
}

typealias Food = [FoodElement]
