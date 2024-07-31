import UIKit
import ContainerControllerSwift

// typealias CustomCardButtonActionCallback = () -> Void

class CustomCardView: XibView {
    
    // MARK: - IBOutlets
    @IBOutlet var ccardView0: UIView!
    @IBOutlet var ccardView1: UIView!
    @IBOutlet var ccardView2: UIView!
    @IBOutlet var ccardView3: UIView!
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var subtitleLabel: UILabel?
    @IBOutlet weak var label2: UILabel?
    @IBOutlet weak var label3: UILabel?
    @IBOutlet weak var label4: UILabel?
    @IBOutlet weak var label5: UILabel?
    @IBOutlet weak var imageView6: UIImageView?
    
    // @IBOutlet weak var button: DesignButton!
    @IBOutlet var cub1: DesignFigure!
    
    @IBOutlet var cub2Img: UIImageView!
    @IBOutlet var cub2: DesignFigure!
    override func loadedFromNib() {
        cub1.transform = CGAffineTransformMakeRotation(-13.0 * .pi / 180);
        cub2.transform = CGAffineTransformMakeRotation(18.0 * .pi / 180);
//        cub2Img.transform = CGAffineTransformMakeRotation(18.0 * M_PI/180);
    }
    
    // @IBAction func buttonClickAction(_ sender: DesignButton) {
    // }
}
