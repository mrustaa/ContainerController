//
//  ViewCallsPlayer.swift
//  irbis
//
//  Created by Aleksandr Lobyncev on 14.03.2022.
//  Copyright © 2022 &#1048;&#1058;&#1057;&#1086;&#1092;&#1090;. All rights reserved.
//
import Foundation
import AVFoundation
import Speech
import AVKit

import UIKit

//тип проигрываемой мелодии
@objc enum ViewCallsPlayerType: Int, CaseIterable {
    //отсутствует
    case none
    
//    case the_audio_bar
//    case funky_house_classic
//    case big_miz_aador
    
//    case disclosure_you_me
//    case disclosure_ware_running
//    case disclosure_in_my_arms
//    case disclosure_f_for_you
//    case disclosure_flume_id
//    case disclosure_whats_in_your_head
//    case disclosure_duke_dumont
    
//    case camelphat_dropit
//    case claptone_music_got_me
//    case flume_greatest_view
//    case myselor_neurolife
//    case benno_blome_botha
    
//    case ludacris_eelin_so_sexy
//    case snoop_dogg_riders_on_the_storm
//    case mark_ronson
    
    case cafe_del_mare
    case josip_petrov
    case ambient_techno_mix
    
    case boris_brejcha_thunderstorm
//    case boris_brejcha_happinezz
//    case boris_brejcha_night_owl
//    case boris_brejcha_streets_of_gold
    
//    case dymok
    
    case retroWave1
    case retroWave2
    case retroWave3
    case retroWave4
    case retroWave5
    case retroWave6
    case retroWave7
    
    
    
    var disclosure: Bool {
        false
//        ((self == .disclosure_you_me) ||
//         (self == .disclosure_ware_running) ||
//         (self == .disclosure_in_my_arms) ||
//         (self == .disclosure_f_for_you) ||
//         (self == .disclosure_flume_id) ||
//         (self == .disclosure_whats_in_your_head) ||
//         (self == .disclosure_duke_dumont)
//        )
    }
    
    
    var boris: Bool {
        false
//        ((self == .boris_brejcha_happinezz) ||
//         (self == .boris_brejcha_thunderstorm) ||
//         (self == .boris_brejcha_night_owl) ||
//         (self == .boris_brejcha_streets_of_gold))
    }
    
    
    var mix: Bool {
        ((self == .cafe_del_mare) ||
         (self == .josip_petrov) ||
         (self == .ambient_techno_mix) ||
         (self == .boris_brejcha_thunderstorm))
    }
    
    
     var retro: Bool {
        ((self == .retroWave1) ||
         (self == .retroWave2) ||
         (self == .retroWave3) ||
         (self == .retroWave4) ||
         (self == .retroWave5) ||
         (self == .retroWave6) ||
         (self == .retroWave7))
    }
    
    static var mixList: [Self] {
        return ViewCallsPlayerType.allCases.filter {
            
            ($0 != .none) && ($0.mix)
            
        }.map { $0 }
    }
    
    
    static var disclosureList: [Self] {
        return ViewCallsPlayerType.allCases.filter {
            
            ($0 != .none) && ($0.disclosure)
            
        }.map { $0 }
    }
    
    static var borisList: [Self] {
        return ViewCallsPlayerType.allCases.filter {
            
            ($0 != .none) && ($0.boris)
            
        }.map { $0 }
    }
    
    static var retroList: [Self] {
        return ViewCallsPlayerType.allCases.filter {

            ($0 != .none) && ($0.retro)
            
        }.map { $0 }
    }
    
    static var statusList: [Self] {
        return ViewCallsPlayerType.allCases.filter {
            ($0 != .none) //&& (!$0.retro) && (!$0.mix) && (!$0.boris) && (!$0.disclosure)
        }.map { $0 }
    }
}

@objcMembers
class ViewCallsPlayer: NSObject {
    static let shared = ViewCallsPlayer()
    
    var colorAnimaton: Bool = true
    var colorsTest: Bool = true
    
    static private let disclosure_you_me = "Disclosure_You_Me.mp3"
    static private let disclosure_ware_running = "Disclosure_Ware_Running.mp3"
    static private let disclosure_in_my_arms = "Disclosure - In My Arms.mp3"
    static private let disclosure_f_for_you = "Disclosure - F For You.mp3"
    static private let disclosure_flume_id  = "Disclosure x Flume - ID (BBC Radio I RIP).mp3"
    static private let disclosure_whats_in_your_head = "Disclosure - What's In Your Head.mp3"
    static private let disclosure_duke_dumont = "Duke Dumont, A-M-E - Need U (100) (Original Mix).mp3"
    
    static private let flume_greatest_view = "Flume_ID.mp3"
    static private let flume_sleepless = "Flume_Sleepless.mp3"
    static private let camelphat_dropit = "camelphat_dropit.mp3"
    
    
    static private let the_audio_bar = "the_audio_bar.mp3"
    static private let funky_house_classic = "funky_house_classic.mp3"
    static private let big_miz_aador = "big_miz_aador.mp3"
    static private let claptone_music_got_me = "claptone_music_got_me.mp3"
    static private let myselor_neurolife = "myselor_neurolife.mp3"
    static private let  benno_blome_botha = "benno_blome_botha.mp3"
    
    static private let  cafe_del_mare = "cafe_del_mare.mp3"
    static private let  ludacris_eelin_so_sexy = "ludacris_eelin_so_sexy.mp3"
    static private let  snoop_dogg_riders_on_the_storm = "snoop_dogg_riders_on_the_storm.mp3"
    static private let  josip_petrov = "josip_petrov.mp3"
    static private let  ambient_techno_mix = "ambient_techno_mix.mp3"
    
    static private let  boris_brejcha_thunderstorm = "boris_brejcha_thunderstorm.mp3"
    static private let  boris_brejcha_happinezz = "boris_brejcha_happinezz.mp3"
    static private let  boris_brejcha_night_owl = "boris_brejcha_night_owl.mp3"
    static private let  boris_brejcha_streets_of_gold = "boris_brejcha_streets_of_gold.mp3"
    
    static private let  mark_ronson_mystikal_feel_right = "mark_ronson_mystikal_feel_right.mp3"
    
    
    static private let  retroWave1 = "retroWave1.mp3"
    static private let  retroWave2 = "retroWave2.mp3"
    static private let  retroWave3 = "retroWave3.mp3"
    static private let  retroWave4 = "retroWave4.mp3"
    static private let  retroWave5 = "retroWave5.mp3"
    static private let  retroWave6 = "retroWave6.mp3"
    static private let  retroWave7 = "retroWave7.mp3"
    
    static private let  dymok = "dymok.mp3"
    
    
    static var mp3FilesFull: [ (String, String, String, URL) ] = []
//    static private let callingFileName = "call_ring_ringing.wav"
//    static private let busyFileName = "call_ring_busy.wav"
//    static private let holdFileName = "call_hold.wav"
//    static private let flume_sleepless = "call_ring_second_alert.wav"
//    static private let errorAlertFileName = "call_ring_error_alert.wav"
    
    //тип мелодии
    private(set) var playerType: ViewCallsPlayerType = .none
    var avPlayer: AVAudioPlayer?
    
    func play(interval: TimeInterval? = nil) {
        guard let avPlayer = avPlayer else { return }
        print("viewCallsPlayer pause")
        if let interval = interval { 
            avPlayer.play(atTime: interval)
            
        } else { avPlayer.play() }
    }
    
    //проиграть
    func play(_ newPlayerType: ViewCallsPlayerType) {
        guard playerType != newPlayerType else { return }
        playerType = newPlayerType
        if playerType == .none {
            stop()
        } else {
            prepareAndPlay()
        }
    }
    
    //остановить
    func stop() {
        guard let avPlayer = avPlayer else { return }
        print("viewCallsPlayer stop")
        avPlayer.stop()
        self.avPlayer = nil
    }
    
    func pause() {
        guard let avPlayer = avPlayer else { return }
        print("viewCallsPlayer pause")
        avPlayer.pause()
    }
    
    //проиграть второй входящий
    func playSecondIncoming() {
        let url = URL(fileURLWithResource: ViewCallsPlayer.flume_sleepless)
        guard let player = try? AVAudioPlayer(contentsOf: url) else { return }
        player.numberOfLoops = 0
        player.volume = 1
        player.prepareToPlay()
        player.play()
    }

    class func getMp3Files() {
        
        
        var mp3FilesUrl: [URL] = []
        
        if let files = try? FileManager.default.contentsOfDirectory(at: Bundle.main.bundleURL, includingPropertiesForKeys: nil) {
//        if let files = try? FileManager.default.contentsOfDirectory(atPath: Bundle.main.bundlePath ){
            mp3FilesUrl = files.filter { $0.pathExtension == "mp3" }
            for file in files {
                print(file)
            }
        }
        
//        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let directoryContents = try? FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
//        let mp3Files = directoryContents?.filter{ $0.pathExtension == "mp3" } ?? []
        
        Self.mp3FilesFull = []
        
        for file in mp3FilesUrl.enumerated() {
            let index = file.0
            let url = file.1
            let nameType = url.lastPathComponent
//            let url2 = URL(fileURLWithResource: nameType )
            
            
            var artistt = ""
            var albumm = ""
            
            let asset = AVAsset(url: url)
            
            print(" - \(index)")
            let metaData = asset.metadata
            if let artist = metaData.first(where: {$0.commonKey == .commonKeyArtist}), 
                let value = artist.value as? String {
                print("Artist:",value)
                artistt = value
            }
            if let album = metaData.first(where: {$0.commonKey == .commonKeyAlbumName}),
               let value = album.value as? String {
                print("Album:",value)
                albumm = value
            }
            print("Url:",url)
            
            Self.mp3FilesFull.append( (artistt, albumm, nameType, url) )
            
            
        }
    }
    
    class func getSubtitle(_ playerType: ViewCallsPlayerType) -> String {
        
        switch playerType {
            
        case .cafe_del_mare: return "[Lounge Chillout Del Mar Cafe Mix]" //  "Don't let me pass you by "
        case .josip_petrov: return "Satis"
        case .ambient_techno_mix: return "mix 014 by Rob Jenkins (cut)"
        case .boris_brejcha_thunderstorm: return "Thunderstorm"
            
        case .retroWave1: return "Highway"
        case .retroWave2: return "Space Break"
        case .retroWave3: return "Resonance"
        case .retroWave4: return "Accelerated"
        case .retroWave5: return "High Tide"
        case .retroWave6: return "Crystalis"
        case .retroWave7: return "Riot"
            
//        case .disclosure_you_me:
//            return "You Me"
//        case .flume_greatest_view:
//            return "ID" // "Greatest View"
//        case .disclosure_ware_running:
//            return "Ware Running"
//            
//        case .disclosure_in_my_arms: return "In My Arms"
//        case .disclosure_f_for_you: return "F For You"
//        case .disclosure_flume_id: return "ID (BBC Radio I RIP)"
//        case .disclosure_whats_in_your_head: return "What's In Your Head"
//        case .disclosure_duke_dumont: return "Need U (100)"
//            
//
//        case .camelphat_dropit:
//            return "Drop It"
//        case .the_audio_bar: return "Harlequins"
//        case .funky_house_classic: return "ID Mix"
//        case .big_miz_aador: return "Renegade"
//        case .claptone_music_got_me: return "The Music Got Me (Darius Syrossian Remix)"
//        case .myselor_neurolife: return "Neurolife"
//        case .benno_blome_botha: return "Abotha"
//
//        case .snoop_dogg_riders_on_the_storm: return "Riders on the Storm"
//        case .ludacris_eelin_so_sexy: return "Feelin So Sexy"
//
//        case .boris_brejcha_happinezz: return "Happinezz (Happiness)"
//        case .boris_brejcha_night_owl: return "Night Owl"
//        case .boris_brejcha_streets_of_gold: return "Streets of Gold"
//            
//        case .mark_ronson: return " Feel Right"
//            
//        case .dymok: return "Дымок" // Ицык Цыпер feat. Игорь цыба
            
        default:
            return ""
        }
    }
    
    class func getFileUrl(_ playerType: ViewCallsPlayerType) -> String {
        
        switch playerType {
            
        case .cafe_del_mare:
            print("viewCallsPlayer cafe_del_mare")
            return ViewCallsPlayer.cafe_del_mare
        case .josip_petrov:
            print("viewCallsPlayer josip_petrov")
            return ViewCallsPlayer.josip_petrov
        case .ambient_techno_mix:
            print("viewCallsPlayer ambient_techno_mix")
            return ViewCallsPlayer.ambient_techno_mix
            
        case .retroWave1: return ViewCallsPlayer.retroWave1
        case .retroWave2: return ViewCallsPlayer.retroWave2
        case .retroWave3: return ViewCallsPlayer.retroWave3
        case .retroWave4: return ViewCallsPlayer.retroWave4
        case .retroWave5: return ViewCallsPlayer.retroWave5
        case .retroWave6: return ViewCallsPlayer.retroWave6
        case .retroWave7: return ViewCallsPlayer.retroWave7
            
            
        case .boris_brejcha_thunderstorm:  return ViewCallsPlayer.boris_brejcha_thunderstorm
//            
//        case .disclosure_you_me:
//            print("viewCallsPlayer disclosure_you_me")
//            return ViewCallsPlayer.disclosure_you_me
//        case .flume_greatest_view:
//            print("viewCallsPlayer flume_greatest_view")
//           return ViewCallsPlayer.flume_greatest_view
//        case .disclosure_ware_running:
//            print("viewCallsPlayer disclosure_ware_running")
//            return ViewCallsPlayer.disclosure_ware_running
//            
//        case .disclosure_in_my_arms:         return ViewCallsPlayer.disclosure_in_my_arms
//        case .disclosure_f_for_you:         return ViewCallsPlayer.disclosure_f_for_you
//        case .disclosure_flume_id:         return ViewCallsPlayer.disclosure_flume_id
//        case .disclosure_whats_in_your_head:         return ViewCallsPlayer.disclosure_whats_in_your_head
//        case .disclosure_duke_dumont:         return ViewCallsPlayer.disclosure_duke_dumont
//            
//        case .camelphat_dropit:
//            print("viewCallsPlayer camelphat_dropit")
//            return ViewCallsPlayer.camelphat_dropit
//            
//        case .the_audio_bar:
//            print("viewCallsPlayer the_audio_bar")
//            return ViewCallsPlayer.the_audio_bar
//        case .funky_house_classic:
//            print("viewCallsPlayer funky_house_classic")
//            return ViewCallsPlayer.funky_house_classic
//        case .big_miz_aador:
//            print("viewCallsPlayer big_miz_aador")
//            return ViewCallsPlayer.big_miz_aador
//        case .claptone_music_got_me:
//            print("viewCallsPlayer claptone_music_got_me")
//            return ViewCallsPlayer.claptone_music_got_me
//        case .myselor_neurolife:
//            print("viewCallsPlayer myselor_neurolife")
//            return ViewCallsPlayer.myselor_neurolife
//        case .benno_blome_botha:
//            print("viewCallsPlayer benno_blome_botha")
//            return ViewCallsPlayer.benno_blome_botha
//        case .snoop_dogg_riders_on_the_storm:
//            print("viewCallsPlayer snoop_dogg_riders_on_the_storm")
//            return ViewCallsPlayer.snoop_dogg_riders_on_the_storm
//        case .ludacris_eelin_so_sexy:
//            print("viewCallsPlayer ludacris_eelin_so_sexy")
//            return ViewCallsPlayer.ludacris_eelin_so_sexy
//            
//      
//        case .boris_brejcha_happinezz:  return ViewCallsPlayer.boris_brejcha_happinezz
//        case .boris_brejcha_night_owl:  return ViewCallsPlayer.boris_brejcha_night_owl
//        case .boris_brejcha_streets_of_gold:  return ViewCallsPlayer.boris_brejcha_streets_of_gold
//            
//        case .mark_ronson: return ViewCallsPlayer.mark_ronson_mystikal_feel_right
//            
//        case .dymok: return ViewCallsPlayer.dymok
            
            
        default:
            return ""
        }
        
        
    }
    
    class func getDuration(_ playerType: ViewCallsPlayerType, callback: ((Int) -> Void)? = nil ) {
        
        
        let url: URL
        
        url = URL(fileURLWithResource: Self.getFileUrl(playerType) )
        
        let asset = AVURLAsset(url: url, options: nil)
        
        asset.loadValuesAsynchronously(forKeys: ["duration"]) {
            var error: NSError? = nil
            let status = asset.statusOfValue(forKey: "duration", error: &error)
            switch status {
            case .loaded: // Sucessfully loaded. Continue processing.
                let duration = asset.duration
                let durationInSeconds = CMTimeGetSeconds(duration)
                callback?(Int(durationInSeconds))
                return
                
            case .failed: break // Handle error
            case .cancelled: break // Terminate processing
            default: break // Handle all other cases
            }
        }
        
        
    }
    
    class func getTitle(_ playerType: ViewCallsPlayerType) -> String {
        
        switch playerType {
            
        case .cafe_del_mare: return "Cafe Del Mare"
        case .josip_petrov:  return "Josip Petrov"
        case .ambient_techno_mix:  return "AMBIENT TECHNO"
            
        case .boris_brejcha_thunderstorm:  return "Boris Brejcha"
        case .retroWave1: return "F.O.O.L"
        case .retroWave2: return "Pengus"
        case .retroWave3: return "HOME"
        case .retroWave4: return "Miami Nights 1984"
        case .retroWave5: return "Brothertiger "
        case .retroWave6: return "Time Travel"
        case .retroWave7: return "Dance With the Dead"
            
//        case .disclosure_you_me:
//            return "Disclosure"
//        case .flume_greatest_view:
//            return "Flume"
//        case .disclosure_ware_running:
//            return "Disclosure"
//            
//        case .disclosure_in_my_arms: return "Disclosure"
//        case .disclosure_f_for_you: return "Disclosure"
//        case .disclosure_flume_id: return "Disclosure"
//        case .disclosure_whats_in_your_head: return "Disclosure"
//        case .disclosure_duke_dumont: return "Disclosure"
//            
//        case .camelphat_dropit:
//            return "CamelPhat"
//        case .the_audio_bar: return "The Audio Bar"
//        case .funky_house_classic: return "Funky House Classic vinyl"
//        case .big_miz_aador: return "Big Miz, A.D.O.R."
//        case .claptone_music_got_me: return "Claptone"
//        case .myselor_neurolife: return "Myselor"
//        case .benno_blome_botha: return "Benno Blome"
//        case .snoop_dogg_riders_on_the_storm: return "Snoop Dogg feat. The Doors"
//        case .ludacris_eelin_so_sexy: return "Ludacris"
//     
//        case .boris_brejcha_happinezz:  return "Boris Brejcha ft. Ginger"
//        case .boris_brejcha_night_owl:  return "Boris Brejcha"
//        case .boris_brejcha_streets_of_gold:  return "Boris Brejcha"
//            
//            
//        case .mark_ronson: return "Mark Ronson feat. Mystikal"
//   
//            
//        case .dymok: return "Ицык Цыпер feat. Игорь цыба"
        default:
            return ""
        }
    }
    
    class func getImage(_ playerType: ViewCallsPlayerType) -> UIImage? {
        
//        let img1  =   #imageLiteral(resourceName: "img_Disclosure_You_Me")
//        let img2  =   #imageLiteral(resourceName: "img_Flume_Greatest_View")
//        let img3  =   #imageLiteral(resourceName: "img_Disclosure_Ware_Running")
//        let img4  =   #imageLiteral(resourceName: "img_camelphat_dropit")
//        
//        
//        let img5  =  #imageLiteral(resourceName: "img_the_audio_bar")
//        let img6  =  #imageLiteral(resourceName: "img_funky_house_classic")
//        let img7  =  #imageLiteral(resourceName: "img_big_miz_aador")
//        let img8  =  #imageLiteral(resourceName: "img_claptone_music_got_me")
//        let img9  =  #imageLiteral(resourceName: "img_myselor_neurolife")
//        let img10 =  #imageLiteral(resourceName: "img_benno_blome_botha")
//       let img12 =  #imageLiteral(resourceName: "img_snoop_dogg_riders_on_the_storm")
//        let img13 =  #imageLiteral(resourceName: "img_ludacris_eelin_so_sexy")
//        
//        
//        let imgBorisBr2 =  #imageLiteral(resourceName: "img_big_deep_boris_br1")
//        let imgBorisBr3 =  #imageLiteral(resourceName: "img_big_deep_boris_br2")
//        
//        
//        let imgMarkRonson =  #imageLiteral(resourceName: "img_big_mark_ronson")
//        
//        let imgDymok = #imageLiteral(resourceName: "img_dymok")
//        
        
        let imgRetro1  =  #imageLiteral(resourceName: "retroWave1")
        let imgRetro2  =  #imageLiteral(resourceName: "retroWave2")
        let imgRetro3  =  #imageLiteral(resourceName: "retroWave3")
        let imgRetro4  =  #imageLiteral(resourceName: "retroWave4")
        let imgRetro5  =  #imageLiteral(resourceName: "retroWave5")
        let imgRetro6  =  #imageLiteral(resourceName: "retroWave6")
        let imgRetro7  =  #imageLiteral(resourceName: "retroWave7")
        
        
        let img11 =  #imageLiteral(resourceName: "img_big_chill_techno")
        let imgDeep =  #imageLiteral(resourceName: "img_big_deep")
        let imgAmbient =  #imageLiteral(resourceName: "img_big_ambient_techno")
        let imgBorisBr =  #imageLiteral(resourceName: "img_big_deep_boris_br")
        
        switch playerType {
            
        
        case .cafe_del_mare: return img11
        case .josip_petrov: return imgDeep
        case .ambient_techno_mix: return imgAmbient
            
        case .boris_brejcha_thunderstorm: return imgBorisBr
        case .retroWave1: return imgRetro1
        case .retroWave2: return imgRetro2
        case .retroWave3: return imgRetro3
        case .retroWave4: return imgRetro4
        case .retroWave5: return imgRetro5
        case .retroWave6: return imgRetro6
        case .retroWave7: return imgRetro7
//        case .disclosure_you_me:
//            return img1
//        case .flume_greatest_view:
//            return img2
//        case .disclosure_ware_running:
//            return img3
//            
//        case .disclosure_in_my_arms:
//            return img3
//        case .disclosure_f_for_you:
//            return img1
//        case .disclosure_flume_id:
//            return img1
//        case .disclosure_whats_in_your_head:
//            return img3
//        case .disclosure_duke_dumont:
//            return img3
//            
//        case .camelphat_dropit:
//            return img4
//        case .the_audio_bar: return img5
//        case .funky_house_classic: return img6
//        case .big_miz_aador: return img7
//        case .claptone_music_got_me: return img8
//        case .myselor_neurolife: return img9
//        case .benno_blome_botha: return img10
//        case .snoop_dogg_riders_on_the_storm: return img12
//        case .ludacris_eelin_so_sexy: return img13
//     
//        case .boris_brejcha_happinezz: return imgBorisBr3
//        case .boris_brejcha_night_owl: return imgBorisBr2
//        case .boris_brejcha_streets_of_gold: return imgBorisBr2
//            
//        case .mark_ronson: return imgMarkRonson
//            
//        case .dymok: return imgDymok
            
        default:
            return nil
        }
    }
    
    
    private func prepareAndPlay() {
        stop()
        let url: URL
        
        url = URL(fileURLWithResource: Self.getFileUrl(self.playerType) )
        
        guard let player = try? AVAudioPlayer(contentsOf: url) else { return }
        avPlayer = player
        
        player.numberOfLoops = -1
        player.volume = 1
        player.prepareToPlay()
        player.play()
    }
}

extension URL {
    init(fileURLWithResource resource: String) {
        self.init(fileURLWithPath: "\(Bundle.main.resourcePath ?? "")/\(resource)")
    }
}
