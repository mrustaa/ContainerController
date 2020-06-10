



import UIKit
import ContainerControllerSwift

// MARK: - Item

class MapsCollectionsCellItem: TableAdapterItem {
    
    init() {
        let cellData = MapsCollectionsCellData()
        super.init(cellClass: MapsCollectionsCell .self, cellData: cellData)
    }
}

// MARK: - Data

class MapsCollectionsCellData: TableAdapterCellData {
    
    // MARK: Inits
    
    override public func cellHeight() -> CGFloat {
        return 98
    }
}

// MARK: - Cell

class MapsCollectionsCell : TableAdapterCell {
    
    // MARK: Properties
    
    public var data: MapsCollectionsCellData?
    
    // MARK: Outlets
    
    @IBOutlet override var selectedView: UIView? {
        didSet { }
    }
    
    @IBOutlet private weak var titleLabel: UILabel?
    
    var collView: MapsCollectionCellView!
    
    // MARK: Initialize
    
    override func awakeFromNib() {
        separatorInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: CGFloat(Double.greatestFiniteMagnitude))
    }
    
    override func fill(data: TableAdapterCellData?) {
        guard let data = data as? MapsCollectionsCellData else { return }
        self.data = data
        
        titleLabel?.text = _L("LNG_MAPS_NEW_COLLECTION")
        
    }
}
