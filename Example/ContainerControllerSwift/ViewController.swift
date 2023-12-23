//
//  ViewController.swift
//  ContainerController
//
//  Created by mrustaa on 12/05/2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import UIKit
import ContainerControllerSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: TableAdapterView?
    var items: [TableAdapterItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar(largeTitleColor: .label, backgoundColor: .systemGroupedBackground, tintColor: .systemBlue, title: "ContainerController", preferredLargeTitle: false)
        
        title = "ContainerController"
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        items = [
            TitleTextItem(title: "Maps.app",                      clss: MapsViewController.self),
            TitleTextItem(title: "Example. Settings",             clss: ExamplesSettingsViewController.self),
            TitleTextItem(title: "Example. Add UITableView",      clss: ExampleAddTableViewController.self),
            TitleTextItem(title: "Example. Add UICollectionView", clss: ExampleAddCollectionViewController.self)
        ]
        
        tableView?.set(items: items, animated: true)
        
        
        tableView?.selectIndexCallback = { [weak self] (index: Int) in
            guard let _self = self else { return }
            
            guard let data = _self.tableView?.items[index].cellData as? TitleTextCellData else { return }
            guard let storyboardClass = data.clss as? StoryboardController.Type else { return }
            let vc = storyboardClass.instantiate()
            
            _self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}

extension ViewController {
    func configureNavigationBar(largeTitleColor: UIColor, backgoundColor: UIColor, tintColor: UIColor, title: String, preferredLargeTitle: Bool) {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor]
            navBarAppearance.titleTextAttributes = [.foregroundColor: largeTitleColor]
            navBarAppearance.backgroundColor = backgoundColor
            
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.compactAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            
            navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = tintColor
            navigationItem.title = title
            
        } else {
            // Fallback on earlier versions
            navigationController?.navigationBar.barTintColor = backgoundColor
            navigationController?.navigationBar.tintColor = tintColor
            navigationController?.navigationBar.isTranslucent = false
            navigationItem.title = title
        }
    }
}

extension ViewController: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
