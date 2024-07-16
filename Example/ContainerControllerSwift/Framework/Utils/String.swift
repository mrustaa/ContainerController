//
//  String.swift
//  PlusBank
//
//  Created by Valentin Titov on 02.02.2021.
//

import UIKit

protocol Stringable {
  var stringValue:  String { get }
}

protocol OptionalStringable {
  var stringValue:  String? { get }
}

//MARK: - Constants
extension String {
  static let empty: String = ""
  static let whitespace: String = " "
  static let slash: String = "/"
  static let newLine: String = "\n"
  static let endLine: String = "\r\n"
  static let colon: String = ":"
  static let semicolon: String = ";"
  static let equal: String = "="
  static let and: String = "&"
}

extension String {
  func substringInRange(_ range: NSRange) -> String {
    let range =
      index(startIndex, offsetBy: range.location)
      ..<
      index(startIndex, offsetBy: range.location + range.length)
    return String(self[range])
  }
  
  func replaceStringInRange(
    _ range: NSRange,
    with string: String
  ) -> String {
    return (self as NSString)
      .replacingCharacters(in: range,  with: string)
      .trimmingCharacters(in: .whitespaces) as String
  }
}

extension String {
  func index(from: Int) -> Index {
    return self.index(startIndex, offsetBy: from)
  }
  
  func substring(from: Int) -> String {
    let fromIndex = index(from: from)
    return String(self[fromIndex...])
  }
  
  func substring(to: Int) -> String {
    let toIndex = index(from: to)
    return String(self[..<toIndex])
  }
  
  func substring(with r: Range<Int>) -> String {
    let startIndex = index(from: r.lowerBound)
    let endIndex = index(from: r.upperBound)
    return String(self[startIndex..<endIndex])
  }
}

extension String {
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }

    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}

//MARK: - Letters formatting
extension String {
  var firstCapitalized: String {
    prefix(1).capitalized + dropFirst()
  }
  
  var firstLowercased: String {
    prefix(1).lowercased() + dropFirst()
  }
  
  var positiveStringNumber: String {
    return "+ \(self)"
  }
  
  var negativeStringNumber: String {
    return "- \(self)"
  }
  
  var titleCase: String {
    return self
      .replacingOccurrences(of: "([A-Z])",
                            with: " $1",
                            options: .regularExpression,
                            range: range(of: self))
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .capitalized
    }
}

extension String {
  var normalizePhone: String {
    let decimalPhone = self.decimalString() as String
    let formatted: String
    if let symb = decimalPhone.first, (symb == "7" || symb == "8") {
      formatted = String(decimalPhone.dropFirst())
    } else {
      formatted = decimalPhone
    }
    return formatted
  }
  func decimalString() -> NSString  {
    return components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined() as NSString
  }

}


extension String {
  
  func addHighlight(texts: [String],
                    color: UIColor = .systemBlue) -> NSMutableAttributedString {
    
    let attr = NSMutableAttributedString(string: self, attributes: nil)
    
    for text in texts {
      let range = (attr.string as NSString).range(of: text)
      attr.setAttributes([.foregroundColor: color], range: range)
    }
    
    return attr
  }
  
  func addUnderline() -> NSMutableAttributedString  {
    
    let textRange = NSRange(location: 0, length: self.count)
    let attr = NSMutableAttributedString(string: self)
    attr.addAttribute(.underlineStyle,
                      value: NSUnderlineStyle.single.rawValue,
                      range: textRange)
    
    return attr
  }
  
//  func remove(currency: CurrencyType) -> String {
//    let value = self
//      .replacingOccurrences(of: currency.symbol, with: "")
//      .replacingOccurrences(of: " ", with: "")
//    return value
//  }
//  
//  func formattingRemoveSpaces() -> String {
//    return removeSpaces().findReplace(find: " ", replace: "", all: true)
//  }
//  
//  func currencyInputFormatting() -> String {
//    
//    func formatting(text: String, digits: Int) -> String {
//      let formatting =
//      text.currencyInputFullFormatting(digits: digits, spaces: false)
//        .remove(currency: .rub)
//        .removeSpaces()
//      return formatting
//    }
//    
//    let removeSpace = self.formattingRemoveSpaces()
//    
//    let needle: Character = ","
//    if let idx = removeSpace.firstIndex(of: needle) {
//      let pos = removeSpace.distance(from: removeSpace.startIndex, to: idx)
//      
//      
//      let result1 = removeSpace.components(separatedBy: ",")
//      
//      if result1.count > 2 {
//        
//        let result = String(removeSpace.dropLast())
//        return result
//        
//      } else if result1.count > 1 {
//        
//        let components = result1[1]
//        print("components \(components.count) ")
//        
//        if components.count != 0 {
//          
//          var digits = 0
//          let digitsMax = 2
//          if components.count > digitsMax {
//            let newComponents = String(components.prefix(2))
//            let text = result1[0] + newComponents
//            
//            return formatting(text: text, digits: digitsMax)
//          }
//          else if digitsMax >= components.count {
//            digits = components.count
//          }
//          
//          let text = result1[0] + components
//          return formatting(text: text, digits: digits)
//        } else {
//          return removeSpace // formatting(text: removeSpace, digits: 0)
//        }
//        
//        
//      }
//      
//      print("Found \(needle) at position \(pos) -- \(result1.count) ")
//      
//      return removeSpace // formatting(text: removeSpace, digits: 0)
//    }
//    else {
//      print("Not found")
//      return removeSpace
//    }
//  }
  
  
//  func currencyInputFullFormatting(digits: Int, spaces: Bool = true) -> String {
//    
//    var number: NSNumber!
//    let formatter = NumberFormatter()
//    formatter.numberStyle = .currencyAccounting
//    formatter.currencySymbol = "₽"
//    formatter.maximumFractionDigits = digits
//    formatter.minimumFractionDigits = digits
//    
//    var amountWithPrefix = self
//    
//    // remove from String: "$", ".", ","
//    let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
//    amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
//    
//    var value: Double = 100
//    if digits == 1 {
//      value = 10
//    } else if digits == 0 {
//      value = 1
//    }
//    
//    let double = (amountWithPrefix as NSString).doubleValue
//    number = NSNumber(value: (double / value))
//    
//    // if first number is 0 or all numbers were deleted
//    guard number != 0 as NSNumber else {
//      return ""
//    }
//    
//    let result = formatter.string(from: number)!
//    if !spaces {
//      return result.formattingRemoveSpaces()
//    }
//    return result
//  }
}

extension String {
  
  func find(_ find: String) -> Bool {
    range(of: find) != nil
  }
  
  func indexInt(of char: Character, last: Bool = false) -> (index: Index, number: Int)? {
    if last {
      guard let index = lastIndex(of: char) else { return nil }
      return ( index, index.utf16Offset(in: self) )
    } else {
      guard let index = firstIndex(of: char) else { return nil }
      return ( index, index.utf16Offset(in: self) )
    }
  }
  
  func findReplace(find: String, replace: String, all: Bool = false) -> String {
    if all {
      return replacingOccurrences(of: find, with: replace, options: .literal, range: nil)
    } else {
      return replacingOccurrences(of: find, with: replace)
    }
  }
  
  func removeSpaces() -> String  {
    trimmingCharacters(in: .whitespaces)
  }
  
}

extension String {
  func removingEmoji() -> String {
    return String(self.filter { !$0.isEmoji() })
  }
  func removeEmoji() -> String {
    return self.components(separatedBy: CharacterSet.symbols).joined()
  }
}

extension Character {
  fileprivate func isEmoji() -> Bool {
    return
     Character(UnicodeScalar(UInt32(0x1d000))!) <= self && self <= Character(UnicodeScalar(UInt32(0x1f77f))!) ||
     Character(UnicodeScalar(UInt32(0x2100))!) <= self && self <= Character(UnicodeScalar(UInt32(0x26ff))!)  ||
    
    Character(UnicodeScalar(UInt32(0x1f600))!) <= self && self <= Character(UnicodeScalar(UInt32(0x1f64f))!) ||
    Character(UnicodeScalar(UInt32(0x1f300))!) <= self && self <= Character(UnicodeScalar(UInt32(0x1f5ff))!) ||
    Character(UnicodeScalar(UInt32(0x1f680))!) <= self && self <= Character(UnicodeScalar(UInt32(0x1f5ff))!) ||
    Character(UnicodeScalar(UInt32(0x2600))!) <= self && self <= Character(UnicodeScalar(UInt32(0x2600))!) ||
    Character(UnicodeScalar(UInt32(0x2700))!) <= self && self <= Character(UnicodeScalar(UInt32(0x27bf))!) ||
    Character(UnicodeScalar(UInt32(0xfe00))!) <= self && self <= Character(UnicodeScalar(UInt32(0xfe0f))!)
  }
}

// MARK: - Name Of Class

extension NSObject {
  class var nameClss: String{
    return NSStringFromClass(self).components(separatedBy: ".").last!
  }
  var nameClss: String{
    return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
  }
  var nameObj: String{
    return String(describing: type(of: Self.self))
  }
    func fontSize(se: Bool = false) -> UIFont {
        return UIFont.systemFont(ofSize: se && Device.SE ? 16 : 18)
    }
}
