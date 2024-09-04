



import UIKit
import ContainerControllerSwift

// MARK: - Item

class MapsSearchCellItem: TableAdapterItem {
    
    init(darkStyle: Bool = false,
         title: String? = nil,
         color: UIColor? = nil,
         separator: Bool = true) {
        
        let cellData = MapsSearchCellData(title ?? "",
                                          color ?? UIColor.systemBlue,
                                          darkStyle,
                                          separator)
        
        super.init(cellClass: MapsSearchCell.self, cellData: cellData)
    }
}

// MARK: - Data

class MapsSearchCellData: TableAdapterCellData {
    
    // MARK: Properties
    
    var title: String
    var color: UIColor
    var darkStyle: Bool
    var separator: Bool
    
    // MARK: Inits
    
    init(_ title: String,
         _ color: UIColor,
         _ darkStyle: Bool,
         _ separator: Bool) {
        
        self.title = title
        self.color = color
        self.darkStyle = darkStyle
        self.separator = separator
        
        super.init()
    }
    
    override public func cellHeight() -> CGFloat {
        return 59
    }

}

// MARK: - Cell

class MapsSearchCell: TableAdapterCell {
    
    // MARK: Properties
    
    public var data: MapsSearchCellData?
    
    // MARK: Outlets
    
    @IBOutlet override var selectedView: UIView? {
        didSet { }
    }
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet weak var colorView: DesignView!
    
    // MARK: Initialize
    
    override func fill(data: TableAdapterCellData?) {
        guard let data = data as? MapsSearchCellData else { return }
        self.data = data
        
        titleLabel?.textColor = data.darkStyle ? .white : .black
        
        titleLabel?.text = data.title
        colorView.fillColor = data.color
        
        
        if data.separator {
            separatorInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 0.0)
        } else {
            separatorInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: CGFloat(Double.greatestFiniteMagnitude))
        }
    }
    
    
}
