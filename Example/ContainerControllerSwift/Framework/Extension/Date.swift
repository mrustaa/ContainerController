//
//  Date.swift
//  CarLoan
//
//  Created by Valentin Titov on 28/11/2019.
//  Copyright © 2019 Valentin Titov. All rights reserved.
//

import Foundation

enum DateFormatType: String {
  case shortSlash = "dd/MM/yyyy"
  case shortDot = "dd.MM.yyyy"
  case shortHyphen = "yyyy-MM-dd"
  case utc = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
  case dayMonth = "d MMMM"
}

extension Date {
  func formatted(by type: DateFormatType) -> String {
    return toString(with: type.rawValue)
  }
  
  func toString(with dateFormat: String, ru: Bool = false) -> String {
    let formatter = DateFormatter()
    if ru { formatter.locale = Locale(identifier: "ru_RU") }
    formatter.dateFormat = dateFormat
    return formatter.string(from: self)
  }
}

extension String {
  func localDateAsString(with dateFormat: DateFormatType = .shortHyphen) -> String {
    if let date = localDate(dateFormat: dateFormat) {
      return date.toString(with: dateFormat.rawValue)
    }
    return .empty
  }
  
  func localDate(dateFormat: DateFormatType = .shortHyphen) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat.rawValue
    dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
    let date = dateFormatter.date(from: self)
    return date
  }
}
