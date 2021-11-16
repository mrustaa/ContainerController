



import UIKit
import ContainerControllerSwift

// MARK: - Item

class MapsRouteCellItem: TableAdapterItem {
    
    init(darkStyle: Bool = false,
         title: String? = nil,
         subtitle: String? = nil,
         separator: Bool = true,
         selected: Bool = false) {
        
        let cellData = MapsRouteCellData(title ?? "42 min",
                                          subtitle ?? "Street Polyany\nFastest",
                                          darkStyle,
                                          separator,
                                          selected)
        
        super.init(cellClass: MapsRouteCell.self, cellData: cellData)
    }
}

// MARK: - Data

class MapsRouteCellData: TableAdapterCellData {
    
    // MARK: Properties
    
    var title: String
    var subtitle: String
    var darkStyle: Bool
    var separator: Bool
    var selected: Bool
    
    // MARK: Inits
    
    init(_ title: String,
         _ subtitle: String,
         _ darkStyle: Bool,
         _ separator: Bool,
         _ selected: Bool) {
        
        self.title = title
        self.subtitle = subtitle
        self.darkStyle = darkStyle
        self.separator = separator
        self.selected = selected
        
        super.init()
    }
    
    class func height() -> CGFloat {
        return (ContainerDevice.isIphoneX ? 164.0 : 135.0)
    }
    
    override public func cellHeight() -> CGFloat {
        return MapsRouteCellData.height()
    }

}

// MARK: - Cell

class MapsRouteCell: TableAdapterCell {
    
    // MARK: Properties
    
    public var data: MapsRouteCellData?
    
    // MARK: Outlets
    
    @IBOutlet override var selectedView: UIView? {
        didSet { }
    }
    
    @IBOutlet private weak var mainView: UIView?
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var textLabel2: UILabel?
    
    
    // MARK: Initialize
    
    override func fill(data: TableAdapterCellData?) {
        guard let data = data as? MapsRouteCellData else { return }
        self.data = data
        
        titleLabel?.textColor = data.darkStyle ? .white : .black
        titleLabel?.text = data.title
        
        textLabel2?.text = data.subtitle
        
        mainView?.backgroundColor = data.selected ? Colors.rgba(155, 155, 155, 0.1) : .clear /// UIColor.black.withAlphaComponent(0.03) : .clear
        
        if data.separator {
            separatorInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 0.0)
        } else {
            separatorInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: CGFloat(Double.greatestFiniteMagnitude))
        }
    }
    
    
}
