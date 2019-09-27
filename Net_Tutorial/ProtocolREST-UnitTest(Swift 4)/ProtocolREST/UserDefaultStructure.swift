//
//  UserDefaultStructure.swift
//  ProtocolREST
//
//  Created by Rocoo on 2017/5/30.
//  Copyright © 2017年 rocoo. All rights reserved.
//

import Foundation

enum TemperatureNotation: Int {
  case fahrenheit
  case celsius
}

extension UserDefaults {

  //    /*** UserDefault store enum ***/
  //
  //    // Store Temperature Notation
  //    UserDefaults.set(temperatureNotation: .celsius)
  //
  //    // Fetch Temperature Notation
  //    let type = UserDefaults.temperatureNotation

  struct Keys {

    // MARK: - Constants

    static let temperatureNotation = "temperatureNotation"

  }

  // MARK: - Temperature Notation

  class var temperatureNotation: TemperatureNotation {
    let storedValue = UserDefaults.standard.integer(forKey: UserDefaults.Keys.temperatureNotation)
    return TemperatureNotation(rawValue: storedValue) ?? TemperatureNotation.fahrenheit
  }

  class func set(temperatureNotation: TemperatureNotation) {
    UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaults.Keys.temperatureNotation)
  }

}

func set(temperatureNotation: TemperatureNotation) {
  UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaults.Keys.temperatureNotation)
}

var temperatureNotation: TemperatureNotation {
  let storedValue = UserDefaults.standard.integer(forKey: UserDefaults.Keys.temperatureNotation)
  return TemperatureNotation(rawValue: storedValue) ?? TemperatureNotation.fahrenheit
}
