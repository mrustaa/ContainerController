import UIKit
import ContainerControllerSwift

// typealias SportSelectProductButtonActionCallback = () -> Void

class SportSelectProductView: XibView {
    
    // MARK: - IBOutlets
    @IBOutlet var paddingTopImg: NSLayoutConstraint!
    @IBOutlet var imagesView: UIView!
    
    @IBOutlet weak var firstImageView: UIImageView?
    @IBOutlet weak var firstImageView2: UIImageView?
    @IBOutlet weak var firstImageView3: UIImageView?
    @IBOutlet weak var firstImageView4: UIImageView?
    @IBOutlet var secondImageView: UIImageView!
    @IBOutlet private weak var imageView2: UIImageView?
    
    var onClickAt: (()->(Void))?
    
    // @IBOutlet weak var button: DesignButton!
    @IBOutlet var backButton: UIButton!
    
    override func loadedFromNib() {
        buttonClickNumber(0)
        
        backButton?.tapHideAnimation(
            view: secondImageView,
            type: .alpha(0.5), //  .androidStyle(color: .systemPink),
            callback: { [weak self] type in
                if type == .touchUpInside {
                    self?.onClickAt?()
                }
            }
        )
    }
    
    
    func imagesAlpha(_ alpha: CGFloat) {
        
        self.imagesView?.alpha = alpha
//        self.firstImageView2?.alpha = alpha
//        self.firstImageView3?.alpha = alpha
//        self.firstImageView4?.alpha = alpha
        
        
    }
    
    func buttonClickNumber(_ number: Int) {
        
        self.firstImageView?.isHidden = true
        self.firstImageView2?.isHidden = true
        self.firstImageView3?.isHidden = true
        self.firstImageView4?.isHidden = true
        
//        let imgg111  =   #imageLiteral(resourceName: "imgSportSelectProduct1")
//        let imgg122  =   #imageLiteral(resourceName: "imgSportSelectProduct2")
//        let imgg133  =   #imageLiteral(resourceName: "imgSportSelectProduct3")
//        let imgg144  =  #imageLiteral(resourceName: "imgSportSelectProduct4")
        main {
            
            switch number {
            case 0: self.firstImageView?.isHidden = false
            case 1: self.firstImageView2?.isHidden = false
            case 2:  self.firstImageView3?.isHidden = false
            case 3: self.firstImageView4?.isHidden = false
            default:   break
            }
            
//            switch number {
//            case 0: self.firstImageView?.image = imgg111
//            case 1: self.firstImageView?.image = imgg122
//            case 2:  self.firstImageView?.image = imgg133
//            case 3: self.firstImageView?.image = imgg144
//            default:   break
//            }
        }
         
    }
    // @IBAction func buttonClickAction(_ sender: DesignButton) {
    // }
}
