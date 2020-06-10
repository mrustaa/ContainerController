//
//  ExamplesAddTableViewController.swift
//  ContainerControllerSwift
//
//  Created by mrustaa on 09.06.2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit
import ContainerControllerSwift

class ExamplesAddTableViewController: StoryboardController {

    var containerTable: ContainerController!
    var containerCollection: ContainerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let layout = ContainerLayout()
        layout.backgroundShadowShow = true
        layout.positions = ContainerPosition(top: 70, middle: 250, bottom: 100)
        containerTable = ContainerController(addTo: self, layout: layout)
        containerTable.view.cornerRadius = 15
        containerTable.view.addShadow()
        containerTable.add(scrollView: addTableView())
        
        
        let layoutC = ContainerLayout()
        layoutC.positions = ContainerPosition(top: 100, middle: 250, bottom: 70)
        containerCollection = ContainerController(addTo: self, layout: layoutC)
        containerCollection.view.cornerRadius = 15
        containerCollection.view.addShadow()
        containerCollection.add(scrollView: addCollectionView())
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        containerTable.move(type: .top, completion: { [weak self] in
            guard let _self = self else { return }
            _self.containerCollection.move(type: .middle)
        })
    }
    
    func addTableView() -> UITableView {
        
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }
    
    func addCollectionView() -> UICollectionView {
        
        let layout = UICollectionViewFlowLayout()
        
        let padding: CGFloat = 15
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.minimumLineSpacing = padding
        layout.minimumInteritemSpacing = padding
        
        let colletion = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        colletion.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        colletion.backgroundColor = .clear
        colletion.delegate = self
        colletion.dataSource = self
        return colletion
    }
    
    func changeViewParametrs() {
        
        containerTable.view.cornerRadius = 15 // Change cornerRadius global
        containerTable.view.addShadow(opacity: 0.1) // Add layer shadow
        containerTable.view.addBlur(style: .dark) // Add background blur UIVisualEffectView
    }
    
    func changeViewCustom() {
        
        // Add custom shadow
        let layer = containerTable.view.layer
        layer.shadowOpacity = 0.5
        layer.shadowColor = UIColor.red.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 4)
        layer.shadowRadius = 5
        
        // Add view in container.view
        let viewRed = UIView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        viewRed.backgroundColor = .systemRed
        containerTable.view.addSubview(viewRed)
        
        // Add view under scrollView container.view
        let viewGreen = UIView(frame: CGRect(x: 25, y: 25, width: 50, height: 50))
        viewGreen.backgroundColor = .systemGreen
        containerTable.view.insertSubview(viewGreen, at: 0)
    }
    
    
    // MARK: - Settings
    

    
    func createLayout() {
        
        let layout = ContainerLayout()
        layout.startPosition = .hide
        layout.backgroundShadowShow = false
        layout.positions = ContainerPosition(top: 70, middle: 250, bottom: 70)
        
    }
    
    // MARK: - change settings right away
    
    func changeRightAway() {
        
        // Properties
        containerTable.set(movingEnabled: true)
        containerTable.set(trackingPosition: false)
        containerTable.set(footerPadding: 100)

        // Add ScrollInsets Top/Bottom
        containerTable.set(scrollIndicatorTop: 5) // ↓
        containerTable.set(scrollIndicatorBottom: 5) // ↑

        // Positions
        containerTable.set(top: 70) // ↓
        containerTable.set(middle: 250) // ↑
        containerTable.set(bottom: 80) // ↑

        // Middle Enable/Disable
        containerTable.set(middle: 250)
        containerTable.set(middle: nil)

        // Background Shadow
        containerTable.set(backgroundShadowShow: true)

        // Insets View
        containerTable.set(left: 5) // →
        containerTable.set(right: 5) // ←

        // Landscape params
        containerTable.setLandscape(top: 30)
        containerTable.setLandscape(middle: 150)
        containerTable.setLandscape(bottom: 70)
        containerTable.setLandscape(middle: nil)

        containerTable.setLandscape(backgroundShadowShow: false)

        containerTable.setLandscape(left:  10)
        containerTable.setLandscape(right: 100)
    }
        
    

}

// MARK: - Scroll Delegate

extension ExamplesAddTableViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let table = scrollView as? UITableView {
            containerTable.scrollViewDidScroll(table)
        }
        if let colletion = scrollView as? UICollectionView {
            containerCollection.scrollViewDidScroll(colletion)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if let table = scrollView as? UITableView {
            containerTable.scrollViewWillBeginDragging(table)
        }
        if let colletion = scrollView as? UICollectionView {
            containerCollection.scrollViewWillBeginDragging(colletion)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let table = scrollView as? UITableView {
            containerTable.scrollViewDidEndDecelerating(table)
        }
        if let colletion = scrollView as? UICollectionView {
            containerCollection.scrollViewDidEndDecelerating(colletion)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if let table = scrollView as? UITableView {
            containerTable.scrollViewDidEndDragging(table, willDecelerate: decelerate)
        }
        if let colletion = scrollView as? UICollectionView {
            containerCollection.scrollViewDidEndDragging(colletion, willDecelerate: decelerate)
        }
    }
}


// MARK: - Collection DataSource

extension ExamplesAddTableViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let randomInt = Int.random(in: 0..<6)
        
        var color: UIColor = .systemBlue
        
        switch randomInt {
        case 0: color = .systemBlue
        case 1: color = .systemRed
        case 2: color = .systemGray
        case 3: color = .systemGreen
        case 4: color = .systemYellow
        case 5: color = .systemOrange
        default: break
        }
        
        cell.backgroundColor = color
        cell.layer.cornerRadius = 12
        return cell
    }
}


// MARK: - Collection Layout

extension ExamplesAddTableViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = ((ContainerDevice.width / 2) - 1) - 22
        return CGSize(width: size, height: size)
    }
}



// MARK: - Table Delegate

extension ExamplesAddTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// MARK: - Table DataSource

extension ExamplesAddTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 21
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "item \(indexPath.row)"
        cell.backgroundColor = .clear
        return cell
    }
}

