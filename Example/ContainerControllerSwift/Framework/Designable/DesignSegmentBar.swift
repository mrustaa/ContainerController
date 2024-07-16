//
//  DesignTest.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 28.07.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit

private extension UIButton {
  
  func style(selected: Bool) {
    if selected {
      self.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    } else {
      self.setTitleColor(#colorLiteral(red: 0.3098039216, green: 0.3098039216, blue: 0.3098039216, alpha: 1), for: .normal)
    }
  }
  
}

private extension UIView {
  
  func selectedView() {
    
    self.layer.cornerRadius = 8
    self.layer.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.3137254902, blue: 0, alpha: 1).cgColor
    
    self.add(shadow: 6 / 2, offset: CGSize(width: -4, height: -4), color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    
    self.addInnerShadow(color: #colorLiteral(red: 0.4784313725, green: 0.1960784314, blue: 0.01568627451, alpha: 0.3674445752),
                        radius: 9 / 2,
                        offset: CGSize(width: -4, height: -4),
                        cornerRadius: 8)
    
    self.addInnerShadow(color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3720056395),
                        radius: 8 / 2,
                        offset: CGSize(width: 4, height: 4),
                        cornerRadius: 8)
  }
  
}


@IBDesignable
class DesignSegmentBar: UIView {
  
  @IBInspectable var textItems: String = ""
  @IBInspectable var index: Int = 0
  
  private var views: [UIView] = []
  private var buttons: [UIButton] = []
  private var stackView: UIStackView!
  private var seView: UIImageView!
  
  var changeIndex: ((Int) -> ())?
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    layer.cornerRadius = 8
    layer.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9529411765, alpha: 1).cgColor
    
    for view in buttons {
      view.removeFromSuperview()
    }
    for view in views {
      view.removeFromSuperview()
    }
    for view in subviews {
      view.removeFromSuperview()
    }
    
    let items = textItems.components(separatedBy: ",")
    let width = (self.frame.width / CGFloat(items.count))
    let frame = CGRect(x: (width * CGFloat(index)), y: 0, width: width, height: self.frame.height)
    
    views = []
    buttons = []
    
    for i in 0..<items.count {
      
      let x = ((width * CGFloat(i+1)) - 0.5)
      
      if (i+1) != items.count {
        let separatorView = UIView(frame: CGRect(x: x, y: 11, width: 1, height: self.frame.height - 22))
        separatorView.backgroundColor = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        separatorView.layer.cornerRadius = 0.5
        addSubview(separatorView)
      }
    }
    
    
    var i = 0
    for oneText in items {
      let x = (width * CGFloat(i))
      
      let view = UIView(frame: frame)
      view.set(x: x)
      let oneButton = UIButton(type: .system)
      oneButton.frame = view.bounds
      view.addSubview(oneButton)
      
      /// Btn Size
      
      view.backgroundColor = .clear
      oneButton.backgroundColor = .clear
      oneButton.style(selected: false)
      
      /// Btn
      oneButton.setTitle(oneText , for: .normal)
      oneButton.contentVerticalAlignment = .center
      
      if let font = UIFont(name: "TTNorms-Regular", size: 18) {
        oneButton.titleLabel?.font = font
      }
      
      if i == index {
        oneButton.style(selected: true)
      }
      
      oneButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
      
      //oneButton.set(width: width)
      views.append(view)
      buttons.append(oneButton)
      //self.addSubview(oneButton)
      i += 1
    }
    
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    
    for btn in views {
      stackView.addArrangedSubview(btn)
    }
    
    
    seView = UIImageView(frame: frame)
    seView.selectedView()
    addSubview(seView)
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(stackView)
    
    stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    self.stackView = stackView
  }
  
  @objc func buttonAction(_ button: UIButton) {
    
    var i = 0
    for btn in buttons {
      btn.style(selected: false)
      
      if btn == button {
        self.index = i
        changeIndex?(i)
        let x = (btn.frame.width * CGFloat(i))
        UIView.animate(withDuration: 0.35) {
          self.seView.set(x: x)
        }
        btn.style(selected: true)
      }
      
      i += 1
    }
  }
}

