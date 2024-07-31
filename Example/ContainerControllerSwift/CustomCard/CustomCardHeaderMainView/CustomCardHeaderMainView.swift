import UIKit
import ContainerControllerSwift

// typealias CustomCardHeaderMainButtonActionCallback = () -> Void

class CustomCardHeaderMainView: XibView {
    
    // MARK: - IBOutlets
    
    @IBOutlet  weak var titleLabel: UILabel?
    @IBOutlet  weak var subtitleLabel: UILabel?
    @IBOutlet  weak var imageView2: UIImageView?
    
    // @IBOutlet weak var button: DesignButton!
    
    override func loadedFromNib() {
        
    }
    
    // @IBAction func buttonClickAction(_ sender: DesignButton) {
    // }
}
