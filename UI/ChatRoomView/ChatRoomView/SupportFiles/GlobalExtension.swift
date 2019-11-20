//
//  GlobalExtension.swift
//  ChatRoomView
//
//  Created by Rocoo on 2019/11/19.
//  Copyright © 2019 Rocoo. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    func getAge() -> Int? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: self, to: Date())
        return components.year
    }

    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }

    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }

    func isSmallerThan18() -> Bool {
      let formatter = DateFormatter()
      formatter.dateFormat = "dd MMM yyyy"
      formatter.locale = Locale(identifier: NSLocale.preferredLanguages[0] as String)

      let now = Date()
      let birthday = self as Date

      let calendar = Calendar.current
      let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
      if let age = ageComponents.year, age >= 18 {
        return false
      }

      return true
    }

    func isDayBiggerThan1() -> Bool {
      let fmt = DateFormatter()
      fmt.dateFormat = "yyyy-MM-dd"
      let today = fmt.string(from: Date())
      let goalDay = fmt.string(from: self)
      if today == goalDay {
        return false
      }

      return true
    }

    func isMoreThanToday() -> Bool {
      var calendar = Calendar.current
      calendar.locale = Locale(identifier: "en")
      let ageComponents = calendar.dateComponents([.day, .hour], from: self, to: Date())
      if let day = ageComponents.day, let hour = ageComponents.hour, day <= 0 {
        if day == 0 && hour < 0 {
         return true
        } else if day < 0 {
          return true
        } else {
          return false
        }
      }

      return false
    }
}

extension UIView {
    func rounded(corners: UIRectCorner) {
      let path = UIBezierPath(roundedRect: self.bounds,
                              byRoundingCorners: corners,
                              cornerRadii: CGSize(width: 8.0, height: 8.0))

      let layer = CAShapeLayer()
      layer.frame = self.bounds
      layer.path = path.cgPath
      self.layer.mask = layer
    }
}
