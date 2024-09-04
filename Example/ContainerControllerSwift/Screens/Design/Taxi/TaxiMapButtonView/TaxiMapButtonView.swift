import UIKit
import ContainerControllerSwift

// typealias TaxiMapButtonButtonActionCallback = () -> Void

class TaxiMapButtonView: XibView {
    
    // MARK: - IBOutlets
    
    @IBOutlet var imgIcon: UIImageView!
    
    var onClickAt: (()->(Void))?
    
    @IBOutlet var btn: UIButton!
    
    override func loadedFromNib() {
        
        btn?.tapHideAnimation(
            view: imgIcon,
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
