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
        
        
        
        let imggAppleMaps =  #imageLiteral(resourceName: "imgAppAppleMaps")
        let imggPlayMusic =  #imageLiteral(resourceName: "imgAppPlayMusic")
        let imggTaxi =  #imageLiteral(resourceName: "imgAppTaxi")
        let imgAppBuyStock =  #imageLiteral(resourceName: "imgAppBuyStock")
        let imgAppCrypto =  #imageLiteral(resourceName: "imgAppCrypto")
        let imgAppCustomCard =  #imageLiteral(resourceName: "imgAppCustomCard")
        let imgAppMapParking =  #imageLiteral(resourceName: "imgAppMapParking")
        let imgAppSport =  #imageLiteral(resourceName: "imgAppSport")
        let imgAppWallets1 =  #imageLiteral(resourceName: "imgAppWallets1")
        
        
        title = "ContainerController"
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.view.backgroundColor = .systemGroupedBackground
        items = [
            
            PlaylistTitleItem(state: .init( titleText:"Add & Customize as you wish", subtitleText: "...", smallType: true, blackType: true)),
            
            TitleTextxItem(title: "Visually adding and customizing components", subtitle: "+ All Settings", clss: ExamplesSettingsViewController.self),
            
            
          PlaylistTitleItem(state: .init( titleText:"Examples Adding ScrollViews", subtitleText: "", smallType: true, blackType: true)),
            
            TitleTextxItem(subtitle: "+ UITableView", clss: ExampleAddTableViewController.self),
            TitleTextxItem(subtitle: "+ UICollectionView", clss: ExampleAddCollectionViewController.self),
            TitleTextxItem(subtitle: "+ UITextView", clss: ExampleTextViewController.self),
            TitleTextxItem(subtitle: "+ Alert Popup", clss: ExampleAlertPopupController.self),
            
            
            PlaylistTitleItem(state: .init( titleText:"Many Desing.Examples of using the component in App Store apps" , smallType: true, blackType: true)),
            
           
            
            TitleTextxItem(title: "+Apple.Maps", subtitle: "Maps", clss: MapsViewController.self, img: imggAppleMaps),
            TitleTextxItem(title: "+Youtube.Music +Apple.Music", subtitle: "PlayMusic ", clss: PlayMusicViewController.self, img: imggPlayMusic),
            
            TitleTextxItem(title: "Multiple components in 1 screen", subtitle: "Wallets", clss: WalletsViewController.self, img:   imgAppWallets1),
            TitleTextxItem(title:nil, subtitle: "Buy Stock", clss: BuyStockViewController.self, img:   imgAppBuyStock),
            TitleTextxItem(title:nil, subtitle: "Sport", clss: SporViewController.self, img:   imgAppSport),
            TitleTextxItem(title:nil, subtitle: "Taxi", clss: TaxiViewController.self, img: imggTaxi),
            TitleTextxItem(title:nil, subtitle: "Map Parking", clss: MapParkingViewController.self, img:   imgAppMapParking),
            
            TitleTextxItem(title: "Multiple components in 1 screen anim", subtitle: "Custom Card (Notes)", clss: CustomCardViewController.self, img:   imgAppCustomCard),
            TitleTextxItem(title:nil, subtitle: "Crypto", clss: CryptoViewController.self, img:   imgAppCrypto),
            
        ]
        
        tableView?.set(items: items, animated: true)
        
        
        tableView?.selectIndexCallback = { [weak self] (index: Int) in
            guard let _self = self else { return }
            
            guard let data = _self.tableView?.items[index].cellData as? TitleTextxCellData else { return }
            guard let storyboardClass = data.clss as? StoryboardController.Type else { return }
            
            
            
            let vc = storyboardClass.instantiate()
            
            
            if let _ = vc as? PlayMusicViewController {
                ViewCallsPlayer.shared.colorsTest = !ViewCallsPlayer.shared.colorsTest
                ViewCallsPlayer.shared.colorAnimaton = !ViewCallsPlayer.shared.colorAnimaton
            }
            
            _self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}

extension ViewController: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
