import UIKit
import ContainerControllerSwift

extension BinaryInteger {
    func squared() -> Self {
        return self * self
    }
}

class CustomCardViewController: StoryboardController {
    
    @IBOutlet weak var tableView: TableAdapterView!
    var containers: [ContainerController] = []

    var containerTableView: TableAdapterView?
    var container: ContainerController?
    var cardView: CustomCardView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        self.navBarHide = true
        view.backgroundColor = Colors.hexStr("1E1E1E")
//        let color1 =  #colorLiteral(red: 0.1019607843, green: 0.168627451, blue: 0.4588235294, alpha: 1)
//        let img1  =   #imageLiteral(resourceName: "imgPlaylistMain")
        
        
        
//        container?.set(left: 0)
//        container?.set(right: 98)
         
        if let c1 = createContainer(mini: true, gradient: true, title: "!!") {
            c1.set(left: 0)
            c1.set(right: 248 + 4)
            
//            main(delay: p) {
//                c1.move(type: .top)
//            }
            c1.view.alpha = 0.5
            
//            let scrollV = createMapsCollectionAdapterView()
//            scrollV.alpha = 0.75
//            c1.add(scrollView: scrollV)
//            c1.backView?.y = 39
            
            containers.append( c1 )
        }
        if let c1 = createContainer(mini: true, title: "how r u?") {
            c1.set(left: ScreenSize.width - 248 + 4)
            c1.set(right: 77 + 4)
            
             
//            main(delay: p * 2) {
//                c1.move(type: .top)
//            }
            c1.view.alpha = 0.5
            
//            let scrollV = createTableViewTestItems(number: 33)
//            scrollV.alpha = 0.5
//            c1.add(scrollView: scrollV)
//            c1.backView?.y = 39
            
            containers.append( c1 )
        }
        if let c1 = createContainer(mini: true, gradient: true, title: "hey") {
            c1.set(left: ScreenSize.width - 77 + 4)
            c1.set(right: 0 )
//            main(delay: p * 3) {
//                c1.move(type: .top)
//            }
            c1.view.alpha = 0.5
            containers.append( c1 )
        }
        
        
        
        if let c1 = createContainer(gradient: true, title: "I am a") {
            c1.set(left: 0)
            c1.set(right: 98 + 8)
//            main(delay: p * 3) {
//                c1.move(type: .top)
//            }
            
//            let scrollV =  createCollectionAdapterView(width: ScreenSize.width - (98 + 8) )
//            scrollV.alpha = 0.35
//            c1.add(scrollView: scrollV)
//            c1.backView?.y = 63
            
            containers.append( c1 )
        }
        
        
        if let c1 = createContainer(title: "hi.") {
            c1.set(left: ScreenSize.width - 98)
            c1.set(right: 0)
            
            
//            let scrollV = createMapsCollectionAdapterView()
//            scrollV.alpha = 0.5
//            c1.add(scrollView: scrollV)
//            c1.backView?.y = 63i
//            main(delay: p * 4) {
//                c1.move(type: .top)
//            }
            containers.append( c1 )
        }
        
        let ccc = createContainerFull(title: "", addBackShadow: true)
        
        if let c1 = ccc.0, let t1 = ccc.1 {
            
            containerTableView = t1
            
            c1.backView?.subviews.forEach {
                $0.removeFromSuperview()
            }
            
            c1.set(bottom: 100 )
            
            
            let fr =  CGRect(x: 0, y: 0, width: ScreenSize.width, height: 161)
            let header = CustomCardHeaderMainView()
            header.onClickAt = {
                self.back()
            }
            header.frame = fr
            
            let fr3 =  CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
            let mainV = CustomCardView()
            mainV.frame = fr3
            view.insertSubview(mainV, at: 0) // addSubview(mainV)
            cardView = mainV
            
            c1.add(headerView: header)
            
            c1.set(left: 15)
            c1.set(right: 15)
            c1.set(top: 471)
            c1.view.cornerRadius = 37
            
            containers.append( c1 )
        }
        
        let pause: CGFloat = 3.5
        
        background {
            
            main {
                self.cardView?.ccardView0.alpha = 1.0
            }
            
            self.containers.forEach { c1 in
                
                main {
                    c1.move(type: .hide)
                }
            }
            
            Thread.sleep(forTimeInterval: pause / 3)
            
            main {
                UIView.animate(withDuration: 1.0) {
                    self.cardView?.ccardView1.alpha = 1.0
                    self.cardView?.ccardView0.alpha = 0.0
                }
            }
            
            Thread.sleep(forTimeInterval: pause)
            
            
            
            main {
                UIView.animate(withDuration: 1.0) {
                    self.cardView?.ccardView1.alpha = 0.0
                    self.cardView?.ccardView2.alpha = 1.0
                }
            }
            
            Thread.sleep(forTimeInterval: 1.0)
            
            self.containers.forEach { c1 in
                main {
                    c1.move(type: .bottom)
                }
            }
            
            Thread.sleep(forTimeInterval: 1.0)
            
            self.containers.enumerated().forEach { i, c1 in
                
                Thread.sleep(forTimeInterval: ((self.containers.count - 1) == i) ? 0.35 : 0.15)
                
                main {
                    c1.move(type: .top)
                }
            }
            
            Thread.sleep(forTimeInterval: pause / 3)
            
            let reversContainers = self.containers.reversed()
            
            reversContainers.enumerated().forEach { i, c1 in
                
//                Thread.sleep(forTimeInterval: 0.15)
                
                main {
                    switch i {
                    case 5:
                        let scrollV = createMapsCollectionAdapterView()
                        scrollV.alpha = 0.0
                        c1.add(scrollView: scrollV)
                        c1.backView?.y = 39
                        UIView.animate(withDuration: 0.35) {
                            scrollV.alpha = 0.75
                        }
                    case 4:
                        let scrollV = createTableViewTestItems(number: 33)
                        scrollV.alpha = 0.0
                        c1.add(scrollView: scrollV)
                        c1.backView?.y = 39
                        UIView.animate(withDuration: 0.35) {
                            scrollV.alpha = 0.5
                        }
                    case 2:
                        let scrollV =  createCollectionAdapterView(width: ScreenSize.width - (98 + 8) )
                        scrollV.alpha = 0.0
                        c1.add(scrollView: scrollV)
                        c1.backView?.y = 63
                        UIView.animate(withDuration: 0.35) {
                            scrollV.alpha = 0.35
                        }
                    case 1:
                        let scrollV = createMapsCollectionAdapterView()
                        scrollV.alpha = 0.0
                        c1.add(scrollView: scrollV)
                        c1.backView?.y = 63
                        UIView.animate(withDuration: 0.35) {
                            scrollV.alpha = 0.5
                        }
                    case 0:
                        c1.set(top: 241)
                        let scrollV = createTextView()
                        scrollV.alpha = 0.0
                        c1.add(scrollView: scrollV)
                        UIView.animate(withDuration: 0.35) {
                            scrollV.alpha = 1.0
                        }
                    default: break
                    }
                    
                }
                
                Thread.sleep(forTimeInterval: 0.25 )
                
                main {
                    c1.move(type: .bottom)
                }
            }
            
            
            
            
            main {
                UIView.animate(withDuration: 1.0) {
                    self.cardView?.ccardView1.alpha = 0.0
                    self.cardView?.ccardView2.alpha = 0.0
                    self.cardView?.ccardView3.alpha = 1.0
                }
            }
            
            
//            Thread.sleep(forTimeInterval: 3.5)
            
//            main {
//                self.containers.last?.set(top: 241)
//                let scrV = createTextView()
//                scrV.alpha = 0.0
//                self.containers.last?.add(scrollView: scrV)
//                
//                UIView.animate(withDuration: 1.0) {
//                    scrV.alpha = 1.0
//                }
//            }
            
            self.containers.enumerated().forEach { i, c1 in
                Thread.sleep(forTimeInterval: 0.15)
                main {
                    c1.move(type: ((self.containers.count - 1) == i) ? .top : .bottom)
                }
            }
        }
        
//        container = ccc.0
//        containerTableView = ccc.1
    }
    
    func createContainer(mini: Bool = false, gradient: Bool = false, title: String? = nil) -> ContainerController? {
        
        let ccc = createContainerFull(mini: mini, gradient: gradient, title: title)
        return ccc.0
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
