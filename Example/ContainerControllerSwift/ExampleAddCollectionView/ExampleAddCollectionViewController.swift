//
//  ExampleAddCollectionViewController.swift
//  ContainerControllerSwift
//
//  Created by mrustaa on 09.06.2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit
import ContainerControllerSwift

class ExampleAddCollectionViewController: StoryboardController {
    
    var container: ContainerController!
    
    @IBOutlet var btnChangeTranslucent: UIButton!
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Example Add CollectionView"
        
        btnUpdateText()
        
        let layoutC = ContainerLayout()
        layoutC.positions = ContainerPosition(top: 100, middle: 250, bottom: 70)
        container = ContainerController(addTo: self, layout: layoutC)
        container.view.cornerRadius = 15
        container.view.addShadow()
        container.add(scrollView: addCollectionView())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        container.move(type: .middle)
    }
    
    @IBAction func btnChangeTranslucentAction(_ sender: UIButton) {
        
        guard let translucent = navigationController?.navigationBar.isTranslucent else { return }
        
        navigationController?.navigationBar.isTranslucent = !translucent
        
        btnUpdateText()
        
        container.move(type: container.moveType)
    }
    
    func btnUpdateText() {
        
        guard let translucent = navigationController?.navigationBar.isTranslucent else { return }
        
        btnChangeTranslucent.setTitle("NavBar isTranslucent \(translucent)", for: .normal)
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
}

// MARK: - Scroll Delegate

extension ExampleAddCollectionViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        container.scrollViewDidScroll(scrollView)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        container.scrollViewWillBeginDragging(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        container.scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        container.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    }
}


// MARK: - Collection DataSource

extension ExampleAddCollectionViewController: UICollectionViewDataSource {
    
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

extension ExampleAddCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = ((ContainerDevice.width / 2) - 1) - 22
        return CGSize(width: size, height: size)
    }
}

