//
//  NSData+JsonRu.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 08.06.2021.
//

import Foundation

// MARK: - Convert Json RU

func convertJsonRU(to data: Data, encoding: String.Encoding = .utf8) -> String {
  
  guard let temp: String = String(data: data as Data, encoding: encoding) else { return "" }
  
  let arr = Array(temp)
  
  var tab = 0
  var findLeft = false
  var findRight = false
  var findNote = false
  //      var array = false
  
  var result: [Character] = []
  let count = arr.count
  let countMinus = count-1
  for i in 0..<count {
    
    let charr = arr[i]
    var nextChar: Character = " "
    let y = (i + 1)
    if y < count {
      nextChar = arr[y]
    }
    
    if (charr != "\"") {
      
      if ((charr == "{") && (i == 0)) ||
          ((charr == "{") && (nextChar == "\"")) ||
          ((charr == "[") && (nextChar == "\"")) ||
          ((charr == "[") && (nextChar == "{" )) ||
          ((charr == "[") && (nextChar == "]" )) {
        tab += 1
        findLeft = true
        result.append(charr)
        if (charr == "[") {
          //              array = true
          result += (" " + "🔢 " + "A" + "r" + "r" + "a" + "y")
        }
      }
      else if ((charr == "}") && (i == countMinus)) ||
                ((charr == "}") && (nextChar == ",")) ||
                ((charr == "}") && (nextChar == "}")) ||
                ((charr == "}") && (nextChar == "]")) ||
                ((charr == "]") && (nextChar == ",")) ||
                ((charr == "]") && (nextChar == "}"))   {
        if 0 < tab {
          tab -= 1
        }
        findRight = true
        if (charr == "]") {
          //              array = false
        }
      }
      else if (charr == ",") {
        findNote = true
        result.append(charr)
      } else if (charr == ":") {
        result.append(" ")
        result.append(charr)
        result.append(" ")
        //result.append("👉")
        //            result.append("〰️")
        //            result.append("〰️")
        //            result.append("➰")
      } else {
        result.append(charr)
      }
      
      if findLeft || findRight || findNote {
        
        let tabb = "   "
        var t = ""
        for _ in 0..<tab {
          t += tabb
        }
        
        result.append("🔴")
        for _ in 0..<t.count {
          result.append(" ")
        }
        //            result.append("|")
        
        findLeft = false
        findNote = false
        
        if findRight {
          result.append(charr)
          findRight = false
        }
      }
    }
  }
  
  var str = String(result)
  str = str.replacingOccurrences(of: "🔴", with: "\n | ")
  str = str.replacingOccurrences(of: "false", with: " ❌")
  str = str.replacingOccurrences(of: "true", with: " ✅")
  
  return str
}

