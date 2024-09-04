import UIKit
import ContainerControllerSwift

// typealias PlayMusicItGribButtonActionCallback = () -> Void

class PlayMusicItGribView: XibView {
    
    // MARK: - IBOutlets
    
    @IBOutlet var bottomPadding: NSLayoutConstraint!
    @IBOutlet  weak var firstImageView: UIImageView?
    @IBOutlet  weak var secondImageView: UIImageView?
    @IBOutlet var imageCardView: UIView!
    @IBOutlet var ccardView: UIView!
    @IBOutlet var white2View: UIView!
    
    // @IBOutlet weak var button: DesignButton!
    
    required public override init() {
        super.init()
        super.frame = Self.rrect()
        
        firstImageView?.isHidden = false //!open
        secondImageView?.isHidden = false //open
    }
    
    class func rrect() -> CGRect {
        CGRect(x: 0, y: 0, width: ScreenSize.width, height: 87)
    }
    
    func grib(visible: Bool, open: Bool)  {
        self.bottomPadding.constant = open ? 10 : 0
        
        UIView.animate(withDuration: 0.75) {
            self.layoutIfNeeded()
//            self.imageCardView.layoutIfNeeded()
            if open {
                
                self.firstImageView?.alpha = visible ? 1 : 0
                self.secondImageView?.alpha = 0
            }  else {
                self.firstImageView?.alpha = 0
                self.secondImageView?.alpha = visible ? 1 : 0
            }
            
            

        }
    }
    
    required public init(frame: CGRect) {
        super.init()
        super.frame = frame
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func loadedFromNib() {
        let al: CGFloat = 0.015
        
        if ViewCallsPlayer.shared.colorsTest {
            ccardView.backgroundColor = .playFullPanelOld
            white2View.backgroundColor = .white.withAlphaComponent(al)
//            white2View.isHidden = true
        } else {
            ccardView.backgroundColor = .playFullBackground
            white2View.backgroundColor = .white.withAlphaComponent(al)
            white2View.isHidden = false
        }
    }
    
    // @IBAction func buttonClickAction(_ sender: DesignButton) {
    // }
}
