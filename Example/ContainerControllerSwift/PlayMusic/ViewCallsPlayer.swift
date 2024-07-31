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

//тип проигрываемой мелодии
@objc enum ViewCallsPlayerType: Int {
    //отсутствует
    case none
    case the_audio_bar
    case funky_house_classic
    case big_miz_aador
    case disclosure_you_me
    case disclosure_ware_running
    case camelphat_dropit
    case claptone_music_got_me
    case flume_greatest_view
    case myselor_neurolife
    case benno_blome_botha
}

@objcMembers
class ViewCallsPlayer: NSObject {
    static let shared = ViewCallsPlayer()
    
    static private let disclosure_you_me = "Disclosure_You_Me.mp3"
    static private let disclosure_ware_running = "Disclosure_Ware_Running.mp3"
    static private let flume_greatest_view = "Flume_Greatest_View.mp3"
    static private let flume_sleepless = "Flume_Sleepless.mp3"
    static private let camelphat_dropit = "CamelPhat_DropIt.mp3"
    
    
    static private let the_audio_bar = "the_audio_bar.mp3"
    static private let funky_house_classic = "funky_house_classic.mp3"
    static private let big_miz_aador = "big_miz_aador.mp3"
    static private let claptone_music_got_me = "claptone_music_got_me.mp3"
    static private let myselor_neurolife = "myselor_neurolife.mp3"
    static private let  benno_blome_botha = "benno_blome_botha.mp3"
    
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

    
    class func getSubtitle(_ playerType: ViewCallsPlayerType) -> String {
        
        switch playerType {
            
            
        case .disclosure_you_me:
            return "You Me"
        case .flume_greatest_view:
            return "Greatest View"
        case .disclosure_ware_running:
            return "Ware Running"
        case .camelphat_dropit:
            return "Drop It"
        case .the_audio_bar: return "Harlequins"
        case .funky_house_classic: return "ID Mix"
        case .big_miz_aador: return "Renegade"
        case .claptone_music_got_me: return "The Music Got Me (Darius Syrossian Remix)"
        case .myselor_neurolife: return "Neurolife"
        case .benno_blome_botha: return "Abotha"
        default:
            return ""
        }
    }
    
    
    class func getTitle(_ playerType: ViewCallsPlayerType) -> String {
        
        switch playerType {
            
            
        case .disclosure_you_me:
            return "Disclosure"
        case .flume_greatest_view:
            return "Flume"
        case .disclosure_ware_running:
            return "Disclosure"
        case .camelphat_dropit:
            return "CamelPhat"
        case .the_audio_bar: return "The Audio Bar"
        case .funky_house_classic: return "Funky House Classic vinyl"
        case .big_miz_aador: return "Big Miz, A.D.O.R."
        case .claptone_music_got_me: return "Claptone"
        case .myselor_neurolife: return "Myselor"
        case .benno_blome_botha: return "Benno Blome"
        default:
            return ""
        }
    }
    
    class func getImage(_ playerType: ViewCallsPlayerType) -> UIImage? {
        
        let img1  =   #imageLiteral(resourceName: "img_Disclosure_You_Me")
        let img2  =   #imageLiteral(resourceName: "img_Flume_Greatest_View")
        let img3  =   #imageLiteral(resourceName: "img_Disclosure_Ware_Running")
        let img4  =   #imageLiteral(resourceName: "img_CamelPhat_DropIt")
        
        
        let img5  =  #imageLiteral(resourceName: "img_the_audio_bar")
        let img6  =  #imageLiteral(resourceName: "img_funky_house_classic")
        let img7  =  #imageLiteral(resourceName: "img_big_miz_aador")
        let img8  =  #imageLiteral(resourceName: "img_claptone_music_got_me")
        let img9  =  #imageLiteral(resourceName: "img_myselor_neurolife")
        let img10 =  #imageLiteral(resourceName: "img_benno_blome_botha")
        
        switch playerType {
            
        
        case .disclosure_you_me:
            return img1
        case .flume_greatest_view:
            return img2
        case .disclosure_ware_running:
            return img3
        case .camelphat_dropit:
            return img4
        case .the_audio_bar: return img5
        case .funky_house_classic: return img6
        case .big_miz_aador: return img7
        case .claptone_music_got_me: return img8
        case .myselor_neurolife: return img9
        case .benno_blome_botha: return img10
        default:
            return nil
        }
    }
    
    
    private func prepareAndPlay() {
        stop()
        let url: URL
        switch playerType {
            case .disclosure_you_me:
            print("viewCallsPlayer disclosure_you_me")
                url = URL(fileURLWithResource: ViewCallsPlayer.disclosure_you_me)
            case .flume_greatest_view:
            print("viewCallsPlayer flume_greatest_view")
                url = URL(fileURLWithResource: ViewCallsPlayer.flume_greatest_view)
            case .disclosure_ware_running:
            print("viewCallsPlayer disclosure_ware_running")
                url = URL(fileURLWithResource: ViewCallsPlayer.disclosure_ware_running)
            case .camelphat_dropit:
            print("viewCallsPlayer camelphat_dropit")
                url = URL(fileURLWithResource: ViewCallsPlayer.camelphat_dropit)
            
        case .the_audio_bar:
            print("viewCallsPlayer the_audio_bar")
            url = URL(fileURLWithResource: ViewCallsPlayer.the_audio_bar)
        case .funky_house_classic:
            print("viewCallsPlayer funky_house_classic")
            url = URL(fileURLWithResource: ViewCallsPlayer.funky_house_classic)
        case .big_miz_aador:
            print("viewCallsPlayer big_miz_aador")
            url = URL(fileURLWithResource: ViewCallsPlayer.big_miz_aador)
        case .claptone_music_got_me:
            print("viewCallsPlayer claptone_music_got_me")
            url = URL(fileURLWithResource: ViewCallsPlayer.claptone_music_got_me)
        case .myselor_neurolife:
            print("viewCallsPlayer myselor_neurolife")
            url = URL(fileURLWithResource: ViewCallsPlayer.myselor_neurolife)
        case .benno_blome_botha:
            print("viewCallsPlayer benno_blome_botha")
            url = URL(fileURLWithResource: ViewCallsPlayer.benno_blome_botha)
            
            default:
                return
        }
        
        
        
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
