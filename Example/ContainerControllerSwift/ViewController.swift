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
        
        title = "ContainerController"
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.view.backgroundColor = .systemGroupedBackground
        items = [
            TitleTextxItem(title: "Maps.app",                      clss: MapsViewController.self),
            TitleTextxItem(title: "Example. Settings",             clss: ExamplesSettingsViewController.self),
            TitleTextxItem(title: "Example. Add UITableView",      clss: ExampleAddTableViewController.self),
            TitleTextxItem(title: "Example. Add UICollectionView", clss: ExampleAddCollectionViewController.self),
            
//            TitleTextxItem(title: "Imagine", clss: ImagineViewController.self),
            
            TitleTextxItem(title: "Playlist", clss: PlaylistViewController.self),
            TitleTextxItem(title: "Crypto", clss: CryptoViewController.self),
            
            TitleTextxItem(title: "Wallets", clss: WalletsViewController.self),
            TitleTextxItem(title: "Sport", clss: SporViewController.self),
            TitleTextxItem(title: "Taxi ", clss: TaxiViewController.self),
            
            TitleTextxItem(title: "Map Parking", clss: MapParkingViewController.self),
            TitleTextxItem(title: "Buy Stock", clss: BuyStockViewController.self),
            
            TitleTextxItem(title: "Custom Card", clss: CustomCardViewController.self),
            
            
            
            
        ]
        
        tableView?.set(items: items, animated: true)
        
        
        tableView?.selectIndexCallback = { [weak self] (index: Int) in
            guard let _self = self else { return }
            
            guard let data = _self.tableView?.items[index].cellData as? TitleTextxCellData else { return }
            guard let storyboardClass = data.clss as? StoryboardController.Type else { return }
            let vc = storyboardClass.instantiate()
            
            _self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}

extension ViewController: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
