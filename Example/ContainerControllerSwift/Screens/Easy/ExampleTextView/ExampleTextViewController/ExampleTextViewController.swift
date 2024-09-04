import UIKit
import ContainerControllerSwift


class ExampleAlertPopupController: ExampleTextViewController {
    override func viewDidLoad() {
        self.alert = true
        super.viewDidLoad()
        
    }
}
    
    

class ExampleTextViewController: StoryboardController {
    
    @IBOutlet weak var tableView: TableAdapterView!
    var containers: [ContainerController] = []

    var alert: Bool = false
    
    var  textVieww: UITextView?
    var container: ContainerController?
    
    var containerTable2: TableAdapterView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        title =  alert ? "Example Alert Popup" : "Example Add TextView" 
        
        let color1 =  #colorLiteral(red: 0.4980392157, green: 0.4980392157, blue: 0.4980392157, alpha: 1)
        view.backgroundColor = color1
        
        var items: [TableAdapterItem] = []
        items.append( PlaylistTitleItem(state: .init(titleText: "") ) )
        tableView.set(items: items, animated: true)
        
        
        if alert {
            
            let header = ExampleTextHeaderView(frame:  CGRect(x: 0, y: 0, width: ScreenSize.width, height: 337))
            
            header.subtitleLabel?.text = _L("LNG_ALERT_POPUP_TITLE")
            
            let footer = ExampleTextButtonBottomView(frame: CGRect(x: 0, y: 0, width: ScreenSize.width, height: 104))
            footer.titleLabel?.text = _L("LNG_ALERT_POPUP_BOTTOM")
            
            let topS = 227 - topbarHeight
            let ccc = addContainer(position: .init(top: topS, bottom: topS), radius: 25, header: header, footer: footer)
            container = ccc.0
            
            
            let textView = createTextView2()
            textView.text =  _L("LNG_ALERT_POPUP_TEXT")
            self.container?.add(scrollView: textView)
            self.textVieww = textView
            
            
            containers.append( ccc.0 )
            
            main(delay: 0.5) {
                self.container?.move(type: .top)
            }
            
//            main(delay: 2.5) {
//                self.container?.move(type: .top)
//            }
//            
//            main(delay: 4.5) {
//                self.container?.move(type: .hide)
//            }
            
        } else {
            
            
            let ccc2 = createContainerFull(title: "", addBackShadow: true)
            
            if let c1 = ccc2.0, let t1 = ccc2.1 {
                
                containerTable2 = t1
                
                c1.backView?.subviews.forEach {
                    $0.removeFromSuperview()
                }
                
                c1.set(bottom: 100 )
                
                
                let fr =  CGRect(x: 0, y: 0, width: ScreenSize.width, height: 161)
                let header = CustomCardHeaderMainView()
                header.onClickAt = {
                    self.back()
                }
                header.titleLabel?.text = "HeaderView"
                header.subtitleLabel?.text = "Added UITextView"
                header.frame = fr
                
                
                c1.add(headerView: header)
                
                c1.set(left: 15)
                c1.set(right: 15)
                c1.set(top: 40)
                c1.view.cornerRadius = 37
                
                containers.append( c1 )
                
                c1.set(top: 40)
                let scrollV = createTextView()
                scrollV.alpha = 0.0
                c1.add(scrollView: scrollV)
                UIView.animate(withDuration: 0.35) {
                    scrollV.alpha = 1.0
                }
                
                main {
                    c1.move(type: .top)
                }
                
//                main(delay: 2.0) {
//                    c1.move(type: .hide)
//                }
//                
//                main(delay: 4.5) {
//                    c1.move(type: .top)
//                }
                
            }
        }
    }

    
    func createTextView2() -> UITextView {
        
        let textView = UITextView()
        textView.returnKeyType = .done
        textView.backgroundColor = .clear
        textView.textContainerInset = .init(top: 10, left: 16, bottom: 5, right: 16)
        textView.font = UIFont.mediumSystemFont(ofSize: 15)
        return textView
    }
    
    
    func createContainerFull(mini: Bool = false, gradient: Bool = false, title: String? = nil, addBackShadow: Bool = false) -> (ContainerController?, TableAdapterView?) {
        
        let items: [TableAdapterItem] = []
        // items.append( PlaylistTitleItem(state: .init() ) )
        tableView.set(items: items, animated: true)
        
        
        let itemsC: [TableAdapterItem] = []
        
        
        let ccc = addContainer(position: .init(top: mini ? 241 : 350, bottom:  mini ? 223 : 173), radius: mini ? 22 : 37, items: itemsC, addBackShadow: addBackShadow)
        
        
        let frr =  CGRect(x: 0, y: 0, width: ccc.0.backView?.width ?? 0, height: ccc.0.backView?.height ?? 0)
        let gradientV = CustomCardGradientMainView()
        gradientV.gr1.isHidden = !gradient
        gradientV.gr2.isHidden = gradient
        gradientV.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleLeftMargin,
                                      .flexibleRightMargin, .flexibleTopMargin]
        gradientV.frame = frr
        
        ccc.0.backView?.addSubview( gradientV )
        
        
        
        
        if !mini {
            let fr =  CGRect(x: 0, y: 0, width: ScreenSize.width, height: 63)
            let header = CustomCardHeaderView()
            header.titleLabel?.text = title ?? ""
            header.frame = fr
            
            ccc.0.add(headerView: header)
        } else {
            
            let fr =  CGRect(x: 0, y: 0, width: ScreenSize.width, height: 39)
            let header = CustomCardHeaderMiniView()
            header.frame = fr
            header.titleLabel?.text = title ?? ""
            ccc.0.add(headerView: header)
        }
        
        
        ccc.0.move(type: .hide)
        
        
        
        return ccc
    }
}
