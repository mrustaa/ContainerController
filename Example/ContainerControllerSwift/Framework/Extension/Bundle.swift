//
//  Bundle.swift
//  PlusBank
//
//  Created by Valentin Titov on 02.03.2021.
//

import Foundation

extension Bundle {
    static var appName: String {
      return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? "KvantMobile"
    }
}
