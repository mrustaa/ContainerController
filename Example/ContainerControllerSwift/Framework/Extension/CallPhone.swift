//
//  CallPhone.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 24.05.2021.
//

import Foundation
import UIKit

class CallPhone {
  
  class func call(phoneNumber:String) {
    let cleanPhoneNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
    let urlString:String = "tel://\(cleanPhoneNumber)"
    if let phoneCallURL = URL(string: urlString) {
      if (UIApplication.shared.canOpenURL(phoneCallURL)) {
        UIApplication.shared.open(phoneCallURL, options: [:], completionHandler: nil)
      }
    }
  }
}
