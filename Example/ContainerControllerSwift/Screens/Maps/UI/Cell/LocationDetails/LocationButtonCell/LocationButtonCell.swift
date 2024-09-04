



import UIKit
import ContainerControllerSwift

enum LocationButtonCellType {
    case blue // 0 122 255
    case gray // 0 0 0 9%
}

// MARK: - Item

class LocationButtonCellItem: TableAdapterItem {
    
    init(title: String? = nil,
         subtitle: String? = nil,
         type: LocationButtonCellType,
         clickCallback: (() -> ())? = nil) {
        
        let cellData = LocationButtonCellData(title, subtitle, type, clickCallback)
        
        super.init(cellClass: LocationButtonCell.self, cellData: cellData)
    }
}

// MARK: - Data

open class LocationButtonCellData: TableAdapterCellData {
    
    // MARK: Properties
    
    var title: String?
    var subtitle: String?
    var type: LocationButtonCellType
    var clickCallback: (() -> ())?
    
    // MARK: Inits
    
    init(_ title: String? = nil,
         _ subtitle: String? = nil,
         _ type: LocationButtonCellType,
         _ clickCallback:(() -> ())?) {
        
        self.title = title
        self.subtitle = subtitle
        self.type = type
        self.clickCallback = clickCallback
        
        super.init()
    }
    
    override public func cellHeight() -> CGFloat {
        return 62
    }

}

// MARK: - Cell

class LocationButtonCell : TableAdapterCell {
    
    // MARK: Properties
    
    public var data: LocationButtonCellData?
    
    // MARK: Outlets
    
    @IBOutlet override var selectedView: UIView? {
        didSet { }
    }
    
    @IBOutlet private weak var button: DesignButton?
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet private weak var titleLabel2: UILabel?
    
    @IBOutlet weak var view: UIView!
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var subtitleLabel: UILabel?
    
    // MARK: Initialize
    
    override func awakeFromNib() {
        separatorInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: CGFloat(Double.greatestFiniteMagnitude))
    }
    
    override func fill(data: TableAdapterCellData?) {
        guard let data = data as? LocationButtonCellData else { return }
        self.data = data
        
        
        switch data.type {
        case .blue:
            view.alpha = 1.0
            view2.alpha = 0.0
            
            titleLabel?.text = data.title ?? ""
            subtitleLabel?.text = data.subtitle ?? ""
//            titleLabelY?.constant = 15
//            titleLabel?.textColor = .white
//            subtitleLabel?.textColor = .white
//            button?.fillColor = .systemBlue
//            button?.hideAnimation = false
            
        case .gray:
            
            view.alpha = 0.0
            view2.alpha = 1.0
            titleLabel2?.text = data.title ?? ""
//            titleLabelY?.constant = 23
//            titleLabel?.textColor = .systemBlue
//            subtitleLabel?.textColor = .systemBlue
//            button?.fillColor = Colors.rgba(130, 130, 130, 0.15)
//            button?.hideAnimation = true
        }
        
        
    }
    
    @IBAction func buttonClickAction(_ sender: Any) {
        data?.clickCallback?()
    }
    
    
}
