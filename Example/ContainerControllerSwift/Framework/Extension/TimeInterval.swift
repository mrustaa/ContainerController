//
//  TimeInterval.swift
//  PlusBank
//
//  Created by Valentin Titov on 02.02.2021.
//

import Foundation

typealias Interval = TimeInterval

enum Speed: Interval {
  case zero = 0.0
  case ms1 = 0.001
  case ms50 = 0.05
  case ms100 = 0.1
  case ms200 = 0.2
  case ms300 = 0.3
  case ms350 = 0.35
  case ms400 = 0.4
  case ms450 = 0.45
  case ms500 = 0.5
  case s1 = 1.0
  case s2 = 2.0
  case s3 = 3.0
  case s4 = 4.0
  case s5 = 5.0
}

enum Delay: Interval {
  case ms1 = 0.001
  case ms100 = 0.1
  case ms200 = 0.2
  case ms300 = 0.3
  case ms400 = 0.4
  case ms500 = 0.5
  case s1 = 1.0
  case s2 = 2.0
  case s3 = 3.0
  case s4 = 4.0
  case s5 = 5.0
}
