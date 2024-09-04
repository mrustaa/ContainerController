



import UIKit
import ContainerControllerSwift

// MARK: - Item

class LocationCoordinateCellItem: TableAdapterItem {
    
    init(title: String? = nil,
         subtitle: String? = nil,
         darkStyle: Bool = false) {
        
        let cellData = LocationCoordinateCellData(title, subtitle, darkStyle)
        
        super.init(cellClass: LocationCoordinateCell .self, cellData: cellData)
    }
}

// MARK: - Data

class LocationCoordinateCellData: TableAdapterCellData {
    
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
        return 89
    }

}

// MARK: - Cell

class LocationCoordinateCell : TableAdapterCell {
    
    // MARK: Properties
    
    public var data: LocationCoordinateCellData?
    
    // MARK: Outlets
    
    @IBOutlet override var selectedView: UIView? {
        didSet { }
    }
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var latitudeValueLabel: UILabel!
    
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var longitudeValueLabel: UILabel!
    
    
    @IBOutlet public weak var separatorView: UIView?
    @IBOutlet weak var separatorHeight: NSLayoutConstraint?
    
    // MARK: Initialize
    
    override func awakeFromNib() {
        separatorHeight?.constant = 0.5
        separatorInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: CGFloat(Double.greatestFiniteMagnitude))
    }
    
    override func fill(data: TableAdapterCellData?) {
        guard let data = data as? LocationCoordinateCellData else { return }
        self.data = data
        
        let color: UIColor = data.darkStyle ? .white : .black
        
        latitudeLabel.text = _L("LNG_MAPS_LOCATION_LATITUDE")
        longitudeLabel.text = _L("LNG_MAPS_LOCATION_LONGITUDE")
        
        latitudeLabel.textColor = color
        latitudeValueLabel.textColor = color
        
        longitudeLabel.textColor = color
        longitudeValueLabel.textColor = color
        
        
    }
    
    
}
