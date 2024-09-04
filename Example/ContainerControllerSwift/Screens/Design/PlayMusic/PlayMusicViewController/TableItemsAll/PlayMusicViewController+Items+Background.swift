//
//  PlayMusicViewController+Ext.swift
//  ContainerControllerSwift_Example
//
//  Created by Рустам Мотыгуллин on 01.08.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import UIKit
import ContainerControllerSwift
import AVFAudio


extension PlayMusicViewController {
    
    
    //MARK: - createTable items
    
    func createTableItems(_ items: PlayMusic.TableItemsType) -> [TableAdapterItem] {
        //        return {
        switch items {
        case .backgroundTop:    createBackTopItems()
        case .backgroundBottom: createBackBottomItems()
        case .pickerAll:        createBackBottomItems(addPicker: true)
        case .popular:          createBackBottomItems(popular: true)
        case .playlist:         createPlaylistItems()
        case .playlistRetro:    createPlaylistItems(retro: true)
        case .playlistMix:      createPlaylistItems(mix: true)
        case .playpanel:        createPlayPanelItems()
        case .buyStock:         createBuyStockItems()
        case .buyStockMix:      createBuyStockMixItems()
        case .cards:            createCardsItems()
            
            
        case .playlistBoris:    createPlaylistItems(boris: true)
        case .playlistDisclosure:      createPlaylistItems(disco: true)
            
        }
        
//        }()
    }
    
    //MARK: - createCollection items
    
    func createCollectionItems(_ items: PlayMusic.CollectionItemsType) -> [CollectionAdapterItem] {
        switch items {
        case .playMusicTag: createCollectionItemsPlayMusicTags()
        case .playMusicPopular: createCollectionItemsPlayMusicPopular()
        case .cardsOne:     createCollectionItemsMyCardsOne()
        case .cardsAddons:  createCollectionItemsMyCardsAddons()
        case .filter:       createCollectionItemsFilter(color: self.redColor ? .playMusicColor : .playlistColor)
        case .sport:        createCollectionItemsSport()
        case .picker:       createCollectionItemsPicker()
        }
    }
    

    
    
    //MARK: - TableItems Background
    
    func createBackTopItems() -> [TableAdapterItem] {
        
        
        let insets3 = CollectionAdapterInsets(minSpacing: CollectionAdapterMinSpacing(cell: 20, line: 20), insets: .init(top: 0, left: 25, bottom: 0, right: 25))
        
        
        var items: [TableAdapterItem] = []
        items.append( PlaylistTitleItem(state: .init( titleText: "New Releases", subtitleText: "More", redColor: self.redColor, handlers: .init(menuClickAt: {
            
            
            self.back()
        })) ) )
        items.append(MyCardsCollectionItem(state: .init(alpha: 0.85, items: self.createCollectionItems(.playMusicTag), insets: insets3)))
        
        // Likes Views
        
        items.append( PlaylistTitleItem(state: .init(titleText: "Mix", subtitleText: "See all", redColor: self.redColor, smallType: true) ) )
        
        
        
        return items
    }
    
    
    
    
    func createBackBottomItems(addPicker: Bool = false, popular: Bool = false, other: Bool = false) -> [TableAdapterItem] {
        
        var items: [TableAdapterItem] = []
//        "Recommendations"
        let titleSize: CGFloat = 70
        
        if addPicker {
            
            items.append( PlaylistTitleItem(state: .init(titleText: "Speed ​dial", subtitleText: "More", redColor: self.redColor, smallType: true, paddingTop: titleSize, color: .green.withAlphaComponent(0.0)) ) )
            
            items.append( SportCatalogFilterItem(state: .init(alpha: 1.0, paddingTop: 380, items: self.createCollectionItems(.picker) , insets: .init(minSpacing: .init(cell: 4, line: 4), insets: .init(top: 20, left: 20, bottom: 10, right: 20), scrollDirection: .vertical)) ) )
            
        }  else if popular {
            
            items.append( PlaylistTitleItem(state: .init(titleText: "Popular", subtitleText: "RetroWave", redColor: self.redColor, smallType: true, paddingTop: titleSize, color: .yellow.withAlphaComponent(0.0)) ) )
            let insets2 = CollectionAdapterInsets(minSpacing: CollectionAdapterMinSpacing(cell: 24, line: 24), insets: .init(top: 0, left: 25, bottom: 0, right: 25))
            items.append(MyCardsCollectionItem(state: .init(alpha: 1, items:  self.createCollectionItems(.playMusicPopular), insets: insets2)))
            
            
            
        } else if other {
            
            
            let insets2 = CollectionAdapterInsets(minSpacing: CollectionAdapterMinSpacing(cell: 24, line: 24), insets: .init(top: 0, left: 25, bottom: 0, right: 25))
            items.append( PlaylistTitleItem(state: .init(titleText: "Boris Brejcha", subtitleText: "More", redColor: self.redColor, smallType: true, paddingTop: titleSize, color: .yellow.withAlphaComponent(0.0)) ) )
            items.append(MyCardsCollectionItem(state: .init(alpha: 1, items:  self.createCollectionItemsPlayMusicPopular(boris: true), insets: insets2)))
            
            
            items.append( PlaylistTitleItem(state: .init(titleText: "Disclosure", subtitleText: "More", redColor: self.redColor, smallType: true, paddingTop: titleSize, color: .yellow.withAlphaComponent(0.0)) ) )
            items.append(MyCardsCollectionItem(state: .init(alpha: 1, items:  self.createCollectionItemsPlayMusicPopular(disco: true), insets: insets2)))
        }
        else {
            
            items.append( PlaylistTitleItem(state: .init(titleText: "Your Playlist", subtitleText: "Edit", redColor: self.redColor, smallType: true, paddingTop: titleSize, color: .red.withAlphaComponent(0.0)) ) )
            
            
            items.append( SportCatalogFilterItem(state: .init(alpha: 1.0, paddingTop: 80, items: self.createCollectionItems(.filter) , insets: .init(minSpacing: .init(cell: 14, line: 14), insets: .init(top: 14, left: 26, bottom: 14, right: 26))) ) )
            
        }
        
        return items
    }
    
    
    
    func createCardsItems() -> [TableAdapterItem] {
        
        var items: [TableAdapterItem] = []
        
        
        
        let al: CGFloat = 0.25
        
        let insets = CollectionAdapterInsets(minSpacing: CollectionAdapterMinSpacing(cell: 16, line: 16), insets: .init(top: 16, left: 21, bottom: 16, right: 21))
        
        let insets2 = CollectionAdapterInsets(minSpacing: CollectionAdapterMinSpacing(cell: 16, line: 16), insets: .init(top: 16, left: 28, bottom: 16, right: 28))
        
        
        items.append(MyCardsCollectionItem(state: .init(alpha: 0.4, items:  self.createCollectionItems(.cardsOne) , insets: insets)))
        items.append(MyCardsCollAddonsItem(state: .init(alpha: al, items: self.createCollectionItems(.cardsAddons) , insets: insets2)))
        
        items.append( SportCatalogAllItem(state: .init(alpha: al / 1.5, items:  self.createCollectionItems(.sport), insets: .init(minSpacing: .init(cell: 0, line: 16), insets: .init(top: 11, left: 32, bottom: 11, right: 32))) ) )
        
        
        return items
    }
    
    //MARK: - TableItems BuyStock
    
    
    func createBuyStockMixItems() -> [TableAdapterItem] {
        
        var itemsC: [TableAdapterItem] = []

        let types: [ViewCallsPlayerType] = [
            .cafe_del_mare,
            .ambient_techno_mix,
            .josip_petrov,
            .boris_brejcha_thunderstorm,
        ]
        
        types.forEach {
            itemsC.append( BuyStockOneItem(state: .init(dark: false, radius: 7, redColor: self.redColor, musicType: $0, handlers: .init(onClickTypeAt: {
                self.playlistSelectedItem($0)
            })) ) )
        }
        
        return itemsC
    }
    
    func createBuyStockItems() -> [TableAdapterItem] {
        
        let imgNikeItem1  =  #imageLiteral(resourceName: "imgBuyStockNike1")
        let imgNikeItem2  =  #imageLiteral(resourceName: "imgBuyStockNike2")
        let imgNikeItem3  = #imageLiteral(resourceName: "imgBuyStockNike3")
        let imgNikeItem5  = #imageLiteral(resourceName: "imgBuyStockNike5")
        
        var itemsC: [TableAdapterItem] = []
        
        
        
        itemsC.append( BuyStockOneItem(state: .init(dark: false, firstImage: imgNikeItem1) ) )
        itemsC.append( BuyStockOneItem(state: .init(dark: false, firstImage: imgNikeItem3, subtitleText: "Apple") ))
        itemsC.append( BuyStockOneItem(state: .init(dark: false, firstImage: imgNikeItem5, subtitleText: "Lyft") ) )
        itemsC.append( BuyStockOneItem(state: .init(dark: false, firstImage: imgNikeItem3, subtitleText: "Apple") ))
        itemsC.append( BuyStockOneItem(state: .init(dark: false, firstImage: imgNikeItem1) ) )
        itemsC.append( BuyStockOneItem(state: .init(dark: false, firstImage: imgNikeItem2) ) )
        
        return itemsC
    }
    
    //MARK: - TagsItems PlayMusic Popular
    
    
    func createCollectionItemsPlayMusicPopular(new: Bool = true, boris: Bool = false, disco: Bool = false) -> [CollectionAdapterItem] {
        
        
        var itemsC: [CollectionAdapterItem] = []
        
        var retroTypes: [ViewCallsPlayerType] = []
        
        
        if new {
            retroTypes  = [
                .retroWave1,
                .retroWave2,
                .retroWave3,
                .retroWave4,
                .retroWave5,
                .retroWave6,
                .retroWave7,
            ]
        } 
        if boris {
            retroTypes  = [
//                .boris_brejcha_night_owl,
                .boris_brejcha_thunderstorm,
//                .boris_brejcha_happinezz,
//                .boris_brejcha_streets_of_gold,
            ]
        }
        if disco {
            retroTypes  = [
//                .disclosure_you_me,
//                .disclosure_ware_running,
//                .disclosure_flume_id,
//                .disclosure_duke_dumont,
//                .disclosure_f_for_you,
//                .disclosure_in_my_arms,
//                .disclosure_whats_in_your_head,
            ]
            
        }
        
        retroTypes.forEach {
            
            itemsC.append(PlayMusicTgItem(state: .init(
                type: $0,
                firstImage: ViewCallsPlayer.getImage($0),
                subtitleText: ViewCallsPlayer.getTitle($0),
                text2: ViewCallsPlayer.getSubtitle($0) ,
                text3: "",
                handlers: .init(onClickAt: { type in
                    self.playlistSelectedItem(type)
                })
            )))
        }
        
        
        
    if !new && !boris && !disco {
            
            let img_big_0  =   #imageLiteral(resourceName: "imgPlaylistLandscape")
            let img_big_1  =   #imageLiteral(resourceName: "img_big_1")
            let img_big_2  =   #imageLiteral(resourceName: "img_big_2")
            let img_big_3  =   #imageLiteral(resourceName: "img_big_3")
            let img_big_4  =   #imageLiteral(resourceName: "img_big_4")
            
            itemsC.append(PlayMusicTgItem(state: .init(firstImage: img_big_1, subtitleText: "Mountain Chillout", text2: "Bali, Indonesia", text3: " $499")))
            itemsC.append(PlayMusicTgItem(state: .init(firstImage: img_big_0, subtitleText: "Mountain - MRusta", text2: "Moscow, Russia", text3: "-$0")))
            itemsC.append(PlayMusicTgItem(state: .init(firstImage: img_big_2, subtitleText: "Chillout at the Be:", text2: "Hawaii, USA", text3: "$576")))
            itemsC.append(PlayMusicTgItem(state: .init(firstImage: img_big_3, subtitleText: "Near The Lake", text2: "Wyoming, USA", text3: "$299")))
            itemsC.append(PlayMusicTgItem(state: .init(firstImage: img_big_4, subtitleText: "Exploring Japan", text2: "Tokyo, Japan", text3: "$895")))
        }
        
        return itemsC
    }
    
    //MARK: - TagsItems PlayMusic Tag
    
    func createCollectionItemsPlayMusicTags() -> [CollectionAdapterItem] {
        
//        let img1  =   #imageLiteral(resourceName: "imgPlaylistLandscape")
        
        let img_chill_techno  =   #imageLiteral(resourceName: "img_big_chill_techno")
        let img_deep_boris_br  =   #imageLiteral(resourceName: "img_big_deep_boris_br")
        let img_big_phonk_skeler  =   #imageLiteral(resourceName: "img_big_car")
//        let img_big_1  =   #imageLiteral(resourceName: "img_big_1")
//        let img_big_2  =   #imageLiteral(resourceName: "img_big_2")
//        let img_big_3  =   #imageLiteral(resourceName: "img_big_3")
//        let img_big_4  =   #imageLiteral(resourceName: "img_big_4")
        let imgDeep =  #imageLiteral(resourceName: "img_big_deep")
        let imgPumpUpPop =  #imageLiteral(resourceName: "img_big_pump_up_pop")
        let imgAmbient =  #imageLiteral(resourceName: "img_big_ambient_techno")
//        let imgHiphop =  #imageLiteral(resourceName: "img_big_hiphop")
        
        
        var tagC: [CollectionAdapterItem] = []
        tagC.append(PlayMusicCatalogItem(state: .init(firstImage: img_chill_techno, handlers: .init(onClickAt: {
            print(" PlayMusicCatalogItem  cafe_del_mare")
            
            self.playlistSelectedItem(.cafe_del_mare)
        }))))
        
        
        tagC.append(PlayMusicCatalogItem(state: .init(firstImage: img_deep_boris_br, handlers: .init(onClickAt: {
            self.playlistSelectedItem(.boris_brejcha_thunderstorm)
        }))))
        tagC.append(PlayMusicCatalogItem(state: .init(firstImage: imgAmbient, handlers: .init(onClickAt: {
            self.playlistSelectedItem(.ambient_techno_mix)
        }))))
        
        tagC.append(PlayMusicCatalogItem(state: .init(firstImage: imgDeep, handlers: .init(onClickAt: {
            self.playlistSelectedItem(.josip_petrov)
        }))))
        tagC.append(PlayMusicCatalogItem(state: .init(firstImage: imgPumpUpPop, handlers: .init(onClickAt: {
            self.playlistSelectedItem(.boris_brejcha_thunderstorm )
        }))))
        
//        tagC.append(PlayMusicCatalogItem(state: .init(firstImage: img1)))
//        tagC.append(PlayMusicCatalogItem(state: .init(firstImage: img_big_3)))
        //        tagC.append(PlayMusicCatalogItem(state: .init(firstImage: img_big_disclosure)))
        
//        tagC.append(PlayMusicCatalogItem(state: .init(firstImage: imgHiphop, handlers: .init(onClickAt: {
//            print(" PlayMusicCatalogItem  snoop_dogg_riders_on_the_storm")
//            self.playlistSelectedItem(.josip_petrov)
//        }))))
        
        
//        tagC.append(PlayMusicCatalogItem(state: .init(firstImage: img_big_1)))
        tagC.append(PlayMusicCatalogItem(state: .init(firstImage: img_big_phonk_skeler)))
//        tagC.append(PlayMusicCatalogItem(state: .init(firstImage: img_big_2)))
//        tagC.append(PlayMusicCatalogItem(state: .init(firstImage: img_big_4)))
        
        return tagC
    }
    
    //MARK: - TagsItems MyCardsOne
    
    func createCollectionItemsMyCardsOne() -> [CollectionAdapterItem] {
        
        var tagY: [CollectionAdapterItem] = []
        tagY.append(MyCardsAddCardItem(state: .init()))
        tagY.append(MyCardsOneCardItem(state: .init(visa: false)))
        tagY.append(MyCardsOneCardItem(state: .init(visa: true)))
        tagY.append(MyCardsOneCardItem(state: .init(visa: true, ccolor: .playMusicColor.withAlphaComponent(0.5))))
        tagY.append(MyCardsOneCardItem(state: .init(visa: true, ccolor: .playlistColor.withAlphaComponent(0.5))))
        return tagY
    }
    
    func createCollectionItemsMyCardsAddons() -> [CollectionAdapterItem] {
        
        var tagR: [CollectionAdapterItem] = []
        tagR.append(MyCardsAddonsItem(state: .init()))
        tagR.append(MyCardsAddonsItem(state: .init()))
        tagR.append(MyCardsAddonsItem(state: .init()))
        tagR.append(MyCardsAddonsItem(state: .init()))
        
        return tagR
    }
    
    
    
    //MARK: - TagsItems Picker
    
    func createCollectionItemsPicker() -> [CollectionAdapterItem] {
        
        let arrTypes: [ViewCallsPlayerType] = [
            
            .ambient_techno_mix,
//            .dymok,
            .boris_brejcha_thunderstorm,
//            .camelphat_dropit,
            .cafe_del_mare,
//            .ludacris_eelin_so_sexy,
//            .boris_brejcha_happinezz,
            .retroWave1,
            .retroWave2,
            .retroWave3,
            .retroWave4,
            .retroWave5,
            .retroWave7,
        ]
        
//        let itemsFilter = dict.keys.enumerated().map {
//            PlayMusicTagPickerItem(state: .init(type: arrTypes[$0], firstImage: dict[$1], subtitleText: $1, handlers: .init(onClickAt: { type in
//                if let type = type { self.playlistSelectedItem(type) }
//            })))
//        }
        
        
        let itemsFilter2 = arrTypes.map {
            PlayMusicTagPickerItem(state: .init(type: $0, handlers: .init(onClickAt: { type in
                if let type = type { self.playlistSelectedItem(type) }
            })))
        }
        
        
        return itemsFilter2
    }
    
    //MARK: - TagsItems Filter
    
    func createCollectionItemsFilter(color: UIColor? = nil) -> [CollectionAdapterItem] {
        
        let imgg  =   #imageLiteral(resourceName: "iconSportCatalogStars")
        let imgg2  =   #imageLiteral(resourceName: "iconSportCatalog1")
        let imgg3  =   #imageLiteral(resourceName: "iconSportLove")
        let imgg4  =   #imageLiteral(resourceName: "iconImagineProgramming")
        let r: CGFloat = 20
        
        let arr = [
            _L("LNG_FILTER_FUN"),
            _L("LNG_FILTER_ROMANCE"),
            _L("LNG_FILTER_RELAX"),
            _L("LNG_FILTER_SAD"),
            _L("LNG_FILTER_CONCENTRATION"),
            _L("LNG_FILTER_SLEEP"),
        ]
        
        var itemsFilter: [CollectionAdapterItem] = []
        
        
        
        itemsFilter += arr.map {
            PlayMusicTagFilterItem(state: .init(titleText: $0))
        }
        
        
//        itemsFilter.append( PlayMusicNewTagItem(state: .init(titleText: "AFFWFAW")) )
//        itemsFilter.append( PlayMusicNewTagItem(state: .init(titleText: "1245125")) )
        
        itemsFilter += arr.map {
            SportTagFilterItem(state: .init(titleText: $0, new: true, radius: r))
        }
        
        
        itemsFilter.append( SportTagFilterItem(state: .init(new: true, radius: r)))
        itemsFilter.append( SportTagSizeColorItem(state: .init(index: 1, selectted: true, selecttedColor: color, icon: imgg, radius: r )))
        itemsFilter.append( SportTagSizeColorItem(state: .init(index: 2, selectted: true, selecttedColor: color, icon: imgg4, radius: r )))
        itemsFilter.append( SportTagSizeColorItem(state: .init(index: 3, selectted: false, selecttedColor: color, icon: imgg2, radius: r )))
        itemsFilter.append( SportTagSizeColorItem(state: .init(index: 4, selectted: false, selecttedColor: color, icon: imgg , radius: r)))
        itemsFilter.append( SportTagSizeColorItem(state: .init(index: 2, selectted: true, selecttedColor: color, icon: imgg3, radius: r )))
        
        return itemsFilter
    }
    
    //MARK: - TagsItems Sport
    
    func createCollectionItemsSport() -> [CollectionAdapterItem] {
        
        let imgg11  =   #imageLiteral(resourceName: "imgSportCatalogProduct1")
        let imgg12  =   #imageLiteral(resourceName: "imgSportCatalogProduct2")
        let imgg13  =   #imageLiteral(resourceName: "imgSportCatalogProduct3")
        let imgg14  =  #imageLiteral(resourceName: "imgSportCatalogProduct4")
        
        var itemsProducts: [CollectionAdapterItem] = []
        itemsProducts.append( SportCatalogOneItem(state: .init(secondImage: imgg11, text2: "Adidas\nHuman Race", text3: "$280")))
        itemsProducts.append( SportCatalogOneItem(state: .init(secondImage: imgg12, text2: "Nike\nJoyraide", text3: "$320")))
        itemsProducts.append( SportCatalogOneItem(state: .init(secondImage: imgg13, text2: "Nike\nZoom Pegasus", text3: "$250")))
        itemsProducts.append( SportCatalogOneItem(state: .init(fav: true, secondImage: imgg14, text2: "Adidas\nStreet Ball", text3: "$160")))
        itemsProducts.append( SportCatalogOneItem(state: .init(secondImage: imgg11, text2: "Adidas\nHuman Race", text3: "$280")))
        
        return itemsProducts
    }
    
    
}
