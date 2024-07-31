import UIKit
import ContainerControllerSwift

// typealias CryptoHeaderButtonActionCallback = () -> Void

class CryptoHeaderView: XibView {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var secondImageView: UIImageView?
    @IBOutlet private weak var label2: UILabel?
    @IBOutlet private weak var imageView3: UIImageView?
    @IBOutlet private weak var label4: UILabel?
    @IBOutlet private weak var imageView5: UIImageView?
    
    // @IBOutlet weak var button: DesignButton!
    
    override func loadedFromNib() {
        
    }
    
    // @IBAction func buttonClickAction(_ sender: DesignButton) {
    // }
}