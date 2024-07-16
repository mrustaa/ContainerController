//
//  Decimal.swift
//  PlusBank
//
//  Created by Valentin Titov on 03.03.2021.
//

import Foundation

extension Decimal {
  var intValue: Int {
    return (self as NSDecimalNumber).intValue
  }
  
  var doubleValue: Double {
    return (self as NSDecimalNumber).doubleValue
  }
  
  func formatWith(currency: CurrencyType) -> String {
    currencyFormatted(currency)
  }
}

extension Decimal {
  
  func currencyFormatted(_ currency: CurrencyType) -> String {
    let value = self * 100.0
    let floatValue = (value as NSDecimalNumber).floatValue
    let intValue = Int(floatValue)
    var stringValue: String = String(intValue)
    while stringValue.count < 3 {
      stringValue.insert("0", at: stringValue.startIndex)
    }
    var result: String = currency.symbol
    result.insert(" ", at: result.startIndex)
    var cents: String = String(stringValue.removeLast())
    cents.insert(stringValue.removeLast(), at: cents.startIndex)
    result = cents + result
    result.insert(",", at: result.startIndex)
    let characters: [Character] = Array(stringValue) as [Character]
    var j = 1
    for i in (0..<characters.count).reversed() {
      let character = characters[i]
      result.insert(character, at: result.startIndex)
      if j%3 == 0, i != 0 {result.insert(" ", at: result.startIndex)}
      j += 1
    }
    return result
  }
}

extension String {
  var decimalValue: Decimal? {
    let formattedStr =
      replacingOccurrences(of: " ", with: "")
      .replacingOccurrences(of: ",", with: ".")
    return Decimal(string: formattedStr)
  }
}
