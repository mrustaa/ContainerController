//
//  Bool.swift
//  PlusBank
//
//  Created by Valentin Titov on 03.03.2021.
//

import Foundation


extension Bool {
  static func from(string: String) -> Bool {
    if string == "true" { return true }
    return false
  }
}

extension Bool: Stringable {
  var stringValue: String {
    if self { return "true" }
    return "false"
  }
}
