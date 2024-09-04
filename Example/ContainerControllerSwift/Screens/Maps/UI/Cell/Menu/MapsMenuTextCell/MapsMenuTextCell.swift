



import UIKit
import ContainerControllerSwift


// MARK: - Item

class MapsMenuTextCellItem: TableAdapterItem {
    
    init(title: String? = nil, switchShow: Bool = false, darkStyle: Bool = false, separator: Bool = true) {
        
        let cellData = MapsMenuTextCellData(title, switchShow, darkStyle, separator)
        
        super.init(cellClass: MapsMenuTextCell.self, cellData: cellData)
    }
}

// MARK: - Data

class MapsMenuTextCellData: TableAdapterCellData {
    
    // MARK: Properties
    
    var title: String?
    var switchShow: Bool
    var separator: Bool
    var darkStyle: Bool
    
    // MARK: Inits
    
    init(_ title: String? = nil, _ switchShow: Bool, _ darkStyle: Bool, _ separator: Bool) {
        
        self.title = title
        self.switchShow = switchShow
        self.separator = separator
        self.darkStyle = darkStyle
        
        super.init()
    }
    
    override public func cellHeight() -> CGFloat {
        return 48
    }

}

// MARK: - Cell

class MapsMenuTextCell: TableAdapterCell {
    
    // MARK: Properties
    
    public var data: MapsMenuTextCellData?
    
    // MARK: Outlets
    
    @IBOutlet override var selectedView: UIView? {
        didSet { }
    }
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var hiddenSwitch: UISwitch!
    
    // MARK: Initialize
    
    override func fill(data: TableAdapterCellData?) {
        guard let data = data as? MapsMenuTextCellData else { return }
        self.data = data
        
        titleLabel?.text = data.title ?? ""
        
        if data.switchShow {
            selectionStyle = .none
            hiddenSwitch.alpha = 1.0
            titleLabel?.textColor = data.darkStyle ? .white : .black
        } else {
            selectionStyle = .default
            hiddenSwitch.alpha = 0.0
            titleLabel?.textColor = .systemBlue
        }
        
        if data.separator {
            separatorInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        } else {
            separatorInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: CGFloat(Double.greatestFiniteMagnitude))
        }
        
    }
    
    
}
