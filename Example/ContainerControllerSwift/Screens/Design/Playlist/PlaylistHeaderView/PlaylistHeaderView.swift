import UIKit

import ContainerControllerSwift
// typealias PlaylistHeaderButtonActionCallback = () -> Void

class PlaylistHeaderView: XibView {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var subtitleLabel: UILabel?
    
    @IBOutlet var ccardView2: DesignFigure!
    @IBOutlet var ccardVjj: UIView!
    @IBOutlet var ccardView: DesignFigure!
    var callbackAt: (() -> Void)? = nil
    // @IBOutlet weak var button: DesignButton!
    @IBOutlet var btn: UIButton!
    
    
    required public override init() {
        super.init()
        super.frame = Self.rrect()
    }
    
    class func rrect() -> CGRect {
        CGRect(x: 0, y: 0, width: ScreenSize.width, height: 77)
    }
    
    
    required public init(frame: CGRect) {
        super.init()
        super.frame = frame
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadedFromNib() {
        
        
        btn?.tapHideAnimation(
            view: ccardVjj,
            type: .pulsate(new: true),
            callback: { [weak self]
                type in
                if type == .touchUpInside {
//                    main(delay: 0.4) {
                        self?.callbackAt?()
//                    }
                }
            }
        )
    }
    
    func updateSelected(red: Bool) {
        
        self.ccardView?.fillColor = .playlistColor // red ? .playMusicColor : .playlistColor
        self.ccardView?.layoutSubviews()
        self.ccardView?.layoutIfNeeded()
    }
    // @IBAction func buttonClickAction(_ sender: DesignButton) {
    // }
}
