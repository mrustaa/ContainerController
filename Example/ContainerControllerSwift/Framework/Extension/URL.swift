//
//  URL.swift
//  PlusBank
//
//  Created by Valentin Titov on 19.04.2021.
//

import Foundation

extension URL {
  subscript(queryParam:String) -> String? {
    guard let url = URLComponents(string: self.absoluteString) else { return nil }
    return url.queryItems?.first(where: { $0.name == queryParam })?.value
  }
}
