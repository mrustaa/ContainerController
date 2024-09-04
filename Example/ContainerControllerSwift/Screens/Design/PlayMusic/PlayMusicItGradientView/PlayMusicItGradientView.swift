import UIKit
import ContainerControllerSwift

// typealias PlayMusicItGradientButtonActionCallback = () -> Void

class PlayMusicItGradientView: XibView {
    
    // MARK: - IBOutlets
    
    @IBOutlet var ccardView: UIView!
    @IBOutlet var white2View: UIView!
    
    // @IBOutlet weak var button: DesignButton!
    
    required public override init() {
        super.init()
        let fr =  CGRect(x: 0, y: 0, width: ScreenSize.width, height: 818.0)
        super.frame = fr
    }
    
    required public init(frame: CGRect) {
        super.init()
        super.frame = frame
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func loadedFromNib() {
        
        if ViewCallsPlayer.shared.colorsTest {
            ccardView.backgroundColor = .playFullPanelOld
            white2View.backgroundColor = .white.withAlphaComponent(0.015)
//            white2View.isHidden = true
        } else {
            ccardView.backgroundColor = .playFullBackground
            white2View.backgroundColor = .white.withAlphaComponent(0.03)
            white2View.isHidden = false
        }
        
    }
    
    // @IBAction func buttonClickAction(_ sender: DesignButton) {
    // }
}
