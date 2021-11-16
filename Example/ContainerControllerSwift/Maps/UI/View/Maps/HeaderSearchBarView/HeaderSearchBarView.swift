//
//  HeaderSearchBarView.swift
//  GTDriver
//
//  Created by mrustaa on 16/01/2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit

class HeaderSearchBarView: XibView {
    
    var searchBarBeginEditingCallback: (() -> Void)?
    var searchBarCancelButtonClickedCallback: (() -> Void)?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet public weak var separatorView: UIView?
    @IBOutlet weak var separatorHeight: NSLayoutConstraint?
    
    override func loadedFromNib() {
        separatorHeight?.constant = 0.5
        separatorView?.alpha = 0.0
        
        searchBar.placeholder = _L("LNG_MAPS_SEARCH_PLACE_ADDRESS")
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        let imageV = textFieldInsideSearchBar?.leftView as! UIImageView
        imageV.image = imageV.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
//        imageV.image = imageV.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        imageV.tintColor = Colors.rgb(128, 128, 128)
    }
    
    func set(darkStyle: Bool) {
        
        searchBar.keyboardAppearance = darkStyle ? .dark : .light
        
        let textFieldInsideSearchBar = searchBar.value(forKey:"searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = darkStyle ? .white : .black
    }
    
}



extension HeaderSearchBarView: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        searchBarBeginEditingCallback?()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        
        searchBar.text = ""
        
        searchBarCancelButtonClickedCallback?()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
//        guard let text = searchBar.text, !text.isEmpty else {
//            searchBar.setShowsCancelButton(false, animated: true)
//            return
//        }
//        searchBar.setShowsCancelButton(true, animated: true)
    }
    
}
