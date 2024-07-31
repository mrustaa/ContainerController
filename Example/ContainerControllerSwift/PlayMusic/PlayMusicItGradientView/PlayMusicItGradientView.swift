import UIKit
import ContainerControllerSwift

// typealias PlayMusicItGradientButtonActionCallback = () -> Void

class PlayMusicItGradientView: XibView {
    
    // MARK: - IBOutlets
    
    
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
        
    }
    
    // @IBAction func buttonClickAction(_ sender: DesignButton) {
    // }
}