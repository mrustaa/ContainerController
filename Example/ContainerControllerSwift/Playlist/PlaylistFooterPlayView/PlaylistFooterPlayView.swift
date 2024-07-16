import UIKit
import ContainerControllerSwift

// typealias PlaylistFooterPlayButtonActionCallback = () -> Void

class PlaylistFooterPlayView: XibView {
    
    // MARK: - IBOutlets
    public var clickCallback: (() -> Void)?
    
    
    @IBOutlet var buttonn: UIButton!
    @IBOutlet private weak var firstImageView: UIImageView?
    @IBOutlet private weak var secondImageView: UIImageView?
    @IBOutlet private weak var imageView2: UIImageView?
    @IBOutlet private weak var label3: UILabel?
    @IBOutlet private weak var label4: UILabel?
    
    // @IBOutlet weak var button: DesignButton!
    
    override func loadedFromNib() {
        
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        self.clickCallback?()
    }
    // @IBAction func buttonClickAction(_ sender: DesignButton) {
    // }
}
