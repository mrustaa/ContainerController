



import UIKit
import ContainerControllerSwift

// MARK: - Item

class LocationAddressCellItem: TableAdapterItem {
    
    init(title: String? = nil,
         subtitle: String? = nil,
         darkStyle: Bool = false) {
        
        let cellData = LocationAddressCellData(title, subtitle, darkStyle)
        
        super.init(cellClass: LocationAddressCell .self, cellData: cellData)
    }
}

// MARK: - Data

class LocationAddressCellData: TableAdapterCellData {
    
    // MARK: Properties
    
    var title: String?
    var subtitle: String?
    var darkStyle: Bool
    
    // MARK: Inits
    
    init(_ title: String? = nil,
         _ subtitle: String? = nil,
         _ darkStyle: Bool) {
        
        self.title = title
        self.subtitle = subtitle
        self.darkStyle = darkStyle
        
        super.init()
    }
    
    override public func cellHeight() -> CGFloat {
        return 159
    }

}

// MARK: - Cell

class LocationAddressCell : TableAdapterCell {
    
    // MARK: Properties
    
    public var data: LocationAddressCellData?
    
    // MARK: Outlets
    
    @IBOutlet override var selectedView: UIView? {
        didSet { }
    }
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var textLabel2: UILabel?
    
    // MARK: Initialize
    
    override func awakeFromNib() {
        separatorInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: CGFloat(Double.greatestFiniteMagnitude))
    }
    
    override func fill(data: TableAdapterCellData?) {
        guard let data = data as? LocationAddressCellData else { return }
        self.data = data
        
        titleLabel?.text = _L("LNG_MAPS_ADDRESS")
        textLabel2?.text = "\(_L("LNG_MAPS_STREET")), 16c2, .....\n\(_L("LNG_MAPS_CITY"))\n\(_L("LNG_MAPS_COUNTRY"))\n101000"
        
        textLabel2?.textColor = data.darkStyle ? .white : .black
    }
    
    
}
