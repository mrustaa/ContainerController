



import UIKit
import ContainerControllerSwift

// MARK: - Item

class LocationTextCellItem: TableAdapterItem {
    
    init(title: String? = nil,
         image: UIImage? = nil) {
        
        let cellData = LocationTextCellData(title, image)
        
        super.init(cellClass: LocationTextCell.self, cellData: cellData)
    }
}

// MARK: - Data

class LocationTextCellData: TableAdapterCellData {
    
    // MARK: Properties
    
    var title: String?
    var image: UIImage?
    
    // MARK: Inits
    
    init(_ title: String? = nil,
         _ image: UIImage? = nil) {
        
        self.title = title
        self.image = image
        
        super.init()
    }
    
    override public func cellHeight() -> CGFloat {
        return 61
    }

}

// MARK: - Cell

class LocationTextCell : TableAdapterCell {
    
    // MARK: Properties
    
    public var data: LocationTextCellData?
    
    // MARK: Outlets
    
    @IBOutlet override var selectedView: UIView? {
        didSet { }
    }
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var imageButton: DesignButton?
    
    // MARK: Initialize
    
    override func awakeFromNib() {
        separatorInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: CGFloat(Double.greatestFiniteMagnitude))
    }
    
    override func fill(data: TableAdapterCellData?) {
        guard let data = data as? LocationTextCellData else { return }
        self.data = data
        
        titleLabel?.text = data.title ?? ""
        
        if let image = data.image {
            imageButton?.setImage(image, for: .normal)
        }
        
    }
    
    
}
