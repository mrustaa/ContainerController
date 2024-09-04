import UIKit
import ContainerControllerSwift

// typealias CustomCardHeaderMainButtonActionCallback = () -> Void

class CustomCardHeaderMainView: XibView {
    
    // MARK: - IBOutlets
    
    @IBOutlet  weak var titleLabel: UILabel?
    @IBOutlet  weak var subtitleLabel: UILabel?
    @IBOutlet  weak var imageView2: UIImageView!
     
    
    var onClickAt: (()->(Void))?
    
    @IBOutlet var btn: UIButton!
    
    override func loadedFromNib() {
        
        btn?.tapHideAnimation(
            view: imageView2,
            type: .alpha(0.5), //  .androidStyle(color: .systemPink),
            callback: { [weak self] type in
                if type == .touchUpInside {
                    self?.onClickAt?()
                }
            }
        )
    }
    // @IBAction func buttonClickAction(_ sender: DesignButton) {
    // }
}
