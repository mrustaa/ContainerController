



import UIKit
import ContainerControllerSwift

// MARK: - Item

class MapsMenuSpaceCellItem: TableAdapterItem {
    
    init(cellHeight: Int = 7) {
        
        let cellData = MapsMenuSpaceCellData(cellHeight)
        
        super.init(cellClass: MapsMenuSpaceCell.self, cellData: cellData)
    }
}

// MARK: - Data

class MapsMenuSpaceCellData: TableAdapterCellData {
    
    // MARK: Properties
    
    var cheight: Int
    
    // MARK: Inits
    
    init(_ cellHeight: Int = 7) {
        
        self.cheight = cellHeight
        
        super.init()
    }
    
    override public func cellHeight() -> CGFloat {
        return CGFloat(cheight)
    }

}

// MARK: - Cell

class MapsMenuSpaceCell: TableAdapterCell {
    
    // MARK: Properties
    
    public var data: MapsMenuSpaceCellData?
    
    // MARK: Outlets
    
    override func awakeFromNib() {
        separatorInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: CGFloat(Double.greatestFiniteMagnitude))
    }
    // MARK: Initialize
    
    override func fill(data: TableAdapterCellData?) {
        guard let data = data as? MapsMenuSpaceCellData else { return }
        self.data = data
        
    }
    
    
}
