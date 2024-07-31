import UIKit
import ContainerControllerSwift

// typealias PlayMusicItGribButtonActionCallback = () -> Void

class PlayMusicItGribView: XibView {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var firstImageView: UIImageView?
    @IBOutlet private weak var secondImageView: UIImageView?
    
    // @IBOutlet weak var button: DesignButton!
    
    required public override init() {
        super.init()
        super.frame = Self.rrect()
    }
    
    class func rrect() -> CGRect {
        CGRect(x: 0, y: 0, width: ScreenSize.width, height: 87)
    }
    
    func grib(visible: Bool, open: Bool)  {
        firstImageView?.isHidden = !open
        firstImageView?.alpha = visible ? 1 : 0
        secondImageView?.isHidden = open
        secondImageView?.alpha = visible ? 1 : 0
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
