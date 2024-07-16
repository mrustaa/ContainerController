import UIKit

import ContainerControllerSwift
// typealias PlaylistHeaderButtonActionCallback = () -> Void

class PlaylistHeaderView: XibView {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var subtitleLabel: UILabel?
    
    // @IBOutlet weak var button: DesignButton!
    
    override func loadedFromNib() {
        
    }
    
    // @IBAction func buttonClickAction(_ sender: DesignButton) {
    // }
}
