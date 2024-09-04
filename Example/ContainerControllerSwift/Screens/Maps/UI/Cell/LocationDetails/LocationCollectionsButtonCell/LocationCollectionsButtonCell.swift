



import UIKit
import ContainerControllerSwift

// MARK: - Item

class LocationCollectionsButtonCellItem: TableAdapterItem {
    
    init() {
        
        let cellData = LocationCollectionsButtonCellData()
        
        super.init(cellClass: LocationCollectionsButtonCell .self, cellData: cellData)
    }
}

// MARK: - Data

class LocationCollectionsButtonCellData: TableAdapterCellData {
    
    override public func cellHeight() -> CGFloat {
        return 124
    }

}

// MARK: - Cell

class LocationCollectionsButtonCell : TableAdapterCell {
    
    // MARK: Properties
    
    public var data: LocationCollectionsButtonCellData?
    
    // MARK: Outlets
    
    @IBOutlet private weak var removeLabel: UILabel?
    @IBOutlet private weak var addtoLabel: UILabel?
    @IBOutlet private weak var shareLabel: UILabel?
    
    // MARK: Initialize
    
    override func awakeFromNib() {
        separatorInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: CGFloat(Double.greatestFiniteMagnitude))
    }
    
    override func fill(data: TableAdapterCellData?) {
        guard let data = data as? LocationCollectionsButtonCellData else { return }
        self.data = data
        
        removeLabel?.text = _L("LNG_MAPS_REMOVE")
        addtoLabel?.text = "\(_L("LNG_MAPS_ADD")) \(_L("LNG_MAPS_TO"))..."
        shareLabel?.text = _L("LNG_MAPS_SHARE")
    }
}
