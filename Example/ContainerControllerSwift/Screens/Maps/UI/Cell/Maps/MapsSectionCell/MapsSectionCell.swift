



import UIKit
import ContainerControllerSwift

// MARK: - Item

class MapsSectionCellItem: TableAdapterItem {
    
    init(title: String? = nil,
         textButton: String? = nil) {
        
        let cellData = MapsSectionCellData(title ?? "", textButton ?? _L("LNG_MAPS_SECTION_SEE_ALL"))
        
        super.init(cellClass: MapsSectionCell.self, cellData: cellData)
    }
}

// MARK: - Data

class MapsSectionCellData: TableAdapterCellData {
    
    // MARK: Properties
    
    var title: String
    var textButton: String
    
    // MARK: Inits
    
    init(_ title: String,
         _ textButton: String) {
        
        self.title = title
        self.textButton = textButton
        
        super.init()
    }
    
    override public func cellHeight() -> CGFloat {
        return 30
    }

}

// MARK: - Cell

class MapsSectionCell: TableAdapterCell {
    
    // MARK: Properties
    
    public var data: MapsSectionCellData?
    
    // MARK: Outlets
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var textButton: UIButton?
    
    // MARK: Initialize
    
    override func fill(data: TableAdapterCellData?) {
        guard let data = data as? MapsSectionCellData else { return }
        self.data = data
        
        titleLabel?.text = data.title
        textButton?.setTitle( data.textButton, for: .normal)
        
    }
    
    
}
