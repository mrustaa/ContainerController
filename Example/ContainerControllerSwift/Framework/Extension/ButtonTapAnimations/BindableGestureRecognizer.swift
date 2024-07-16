//
//  BindableGestureRecognizer.swift
//  ButtonLayersClickStyle
//
//  Created by Рустам Мотыгуллин on 09.03.2022.
//

import UIKit

final class BindableGestureRecognizer: UITapGestureRecognizer {
  private var action: (UITapGestureRecognizer) -> Void
  
  init(action: @escaping (UITapGestureRecognizer) -> Void) {
    self.action = action
    super.init(target: nil, action: nil)
    self.addTarget(self, action: #selector(execute(_:)))
  }
  
  @objc private func execute(_ sender: UITapGestureRecognizer) {
    action(sender)
  }
}

