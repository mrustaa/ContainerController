



import UIKit
import ContainerControllerSwift

enum MapsLocationCellColorType {
    case red
    case black
}

// MARK: - Item

class MapsLocationCellItem: TableAdapterItem {
    
    init(title: String? = nil,
         subtitle: String? = nil,
         colorType: MapsLocationCellColorType,
         darkStyle: Bool = false) {
        
        
        let cellData = MapsLocationCellData(title, subtitle, colorType, darkStyle)
        
        super.init(cellClass: MapsLocationCell.self, cellData: cellData)
    }
}

// MARK: - Data

class MapsLocationCellData: TableAdapterCellData {
    
    // MARK: Properties
    
    var title: String?
    var subtitle: String?
    var colorType: MapsLocationCellColorType
    var darkStyle: Bool
    
    // MARK: Inits
    
    init(_ title: String? = nil,
         _ subtitle: String? = nil,
         _ colorType: MapsLocationCellColorType,
         _ darkStyle: Bool) {
        
        self.title = title
        self.subtitle = subtitle
        self.colorType = colorType
        self.darkStyle = darkStyle
        
        super.init()
    }
    
    override public func cellHeight() -> CGFloat {
        return 75
    }

}

// MARK: - Cell

class MapsLocationCell: TableAdapterCell {
    
    // MARK: Properties
    
    public var data: MapsLocationCellData?
    
    // MARK: Outlets
    
    @IBOutlet override var selectedView: UIView? {
        didSet { }
    }
    
    @IBOutlet weak var circleBlackView: DesignView!
    @IBOutlet weak var circleView: DesignView!
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var subtitleLabel: UILabel?
    
    // MARK: Initialize
    
    override func awakeFromNib() {
    }
    
    // MARK: Initialize
    
    override func fill(data: TableAdapterCellData?) {
        guard let data = data as? MapsLocationCellData else { return }
        self.data = data
        
        titleLabel?.textColor = data.darkStyle ? .white : .black
    
        
        if data.colorType == .red {
            circleView.alpha = 1.0
            circleBlackView.alpha = 0.0
        } else {
            circleView.alpha = 0.0
            circleBlackView.alpha = 1.0
        }
        
        titleLabel?.text = data.title ?? ""
        subtitleLabel?.text = data.subtitle ?? ""
        
    }
    
    
}
