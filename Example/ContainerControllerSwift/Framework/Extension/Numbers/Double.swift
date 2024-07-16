//
//  Double.swift
//  PlusBank
//
//  Created by Valentin Titov on 03.03.2021.
//

import Foundation

extension Double {
  func decimalValue() -> Decimal? {
    return Decimal(self)
  }
  
  func currencyFormatted(_ currency: CurrencyType) -> String {
    let intValue = Int(self * 100.0)
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
