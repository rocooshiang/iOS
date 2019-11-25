//
//  ChatRoomViewModel.swift
//  ChatRoomView
//
//  Created by Rocoo on 2019/11/19.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import Foundation
import iOSCoreLibrary

class ChatRoomViewModel {

    let rowViewModels = Observable<[RowViewModel]>(value: [])

    func fetchData() {
        if let data = loadJson(forFilename: "DemoFood") {
            do {
                var rowViewModels = [RowViewModel]()
                let food = try JSONDecoder().decode(Food.self, from: data)

                for dictionary in food.first!.comments {
                    guard let timeString = dictionary.keys.first, let timeInterval = TimeInterval(timeString) else {
                        return
                    }

                    guard let first = dictionary.values.first else {
                        return
                    }

                    let time = getCurrentFormatTime(time: Date(timeIntervalSince1970: timeInterval))
                    let comment = first.comment
                    let isCoach = first.isCoachComment
                    let avatarURL = URL(string: first.profileImage)

                    if isCoach {
                        let coachComment = ChatRoomCommentCoachViewModel(message: comment, time: time, avatarURL: avatarURL)
                        rowViewModels.append(coachComment)
                    } else {
                        let userComment = ChatRoomCommentUserViewModel(message: comment, time: time)
                        rowViewModels.append(userComment)
                    }
                }

                self.rowViewModels.value = rowViewModels
            } catch {
                print("Have some errors found from decode data")
            }

        }
    }

    func cellIdentifier(for viewModel: RowViewModel) -> String {
        switch viewModel {
        case is ChatRoomCommentCoachViewModel:
            return "ChatRoomCommentCoachCell"
        case is ChatRoomCommentUserViewModel:
            return "ChatRoomCommentUserCell"
        default:
            fatalError("Unexpected view model type: \(viewModel)")
        }
    }

    func getCurrentFormatTime(time: Date) -> String {
      let fmt = DateFormatter()
      fmt.locale = Locale(identifier: "en_US_POSIX")
      if !time.isToday() {
        fmt.dateFormat = "MM/dd/yyyy hh:mm a"
      } else {
        fmt.dateFormat = "hh:mm a"
      }
      return fmt.string(from: time)
    }

}
