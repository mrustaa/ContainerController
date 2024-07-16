import UIKit
import ContainerControllerSwift

// typealias CryptoHeaderButtonActionCallback = () -> Void

class CryptoHeaderView: XibView {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var subtitleLabel: UILabel?
    @IBOutlet private weak var label2: UILabel?
    
    // @IBOutlet weak var button: DesignButton!
    
    override func loadedFromNib() {
        
    }
    
    // @IBAction func buttonClickAction(_ sender: DesignButton) {
    // }
}
