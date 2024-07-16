//
//  Jailbreak.swift
//  PlusBank
//
//  Created by Рустам Мотыгуллин on 20.05.2021.
//

import Foundation
import UIKit

class JailbreakCheck {
  
  public static func jailbroken() -> Bool {
    guard let cydiaUrlScheme = URL(string: "cydia://package/com.example.package") else { return isJailbroken() }
    return UIApplication.shared.canOpenURL(cydiaUrlScheme) || isJailbroken()
  }
  
  static func isJailbroken() -> Bool {
    
    if Device.isSimulator {
      return false
    }
    
    let fileManager = FileManager.default
    if fileManager.fileExists(atPath: "/Applications/Cydia.app") ||
        fileManager.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib") ||
        fileManager.fileExists(atPath: "/bin/bash") ||
        fileManager.fileExists(atPath: "/usr/sbin/sshd") ||
        fileManager.fileExists(atPath: "/etc/apt") ||
        fileManager.fileExists(atPath: "/usr/bin/ssh") {
      return true
    }
    
    if canOpen("/Applications/Cydia.app") ||
        canOpen("/Library/MobileSubstrate/MobileSubstrate.dylib") ||
        canOpen("/bin/bash") ||
        canOpen("/usr/sbin/sshd") ||
        canOpen("/etc/apt") ||
        canOpen("/usr/bin/ssh") {
      return true
    }
    
    let path = "/private/" + UUID().uuidString
    do {
      try "anyString".write(toFile: path, atomically: true, encoding: .utf8)
      try fileManager.removeItem(atPath: path)
      return true
    } catch {
      return false
    }
  }
  
  static func canOpen(_ path: String) -> Bool {
    let file = fopen(path, "r")
    guard file != nil else { return false }
    fclose(file)
    return true
  }
  
}

