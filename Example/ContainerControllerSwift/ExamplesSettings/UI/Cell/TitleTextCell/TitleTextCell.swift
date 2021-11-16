



import UIKit
import ContainerControllerSwift

// MARK: - Item

class TitleTextItem: TableAdapterItem {
    
    init(title: String? = nil,
         subtitle: String? = nil,
         separator: Bool = false,
         clss: AnyClass? = nil,
         touchAnimationHide: Bool = false,
         editing: Bool = false) {
        
        let cellData = TitleTextCellData(title, subtitle, separator, clss, touchAnimationHide, editing)
        
        super.init(cellClass: TitleTextCell.self, cellData: cellData)
    }
}

// MARK: - Data

class TitleTextCellData: TableAdapterCellData {
    
    // MARK: Properties
    
    var title: String?
    var subtitle: String?
    var clss: AnyClass?
    var separatorVisible: Bool
    var touchAnimationHide: Bool
    
    var editing: Bool
    
    // MARK: Inits
    
    init(_ title: String? = nil,
         _ subtitle: String? = nil,
         _ separator: Bool,
         _ clss: AnyClass? = nil,
         _ touchAnimationHide: Bool,
         _ editing: Bool) {
        
        self.title = title
        self.subtitle = subtitle
        
        self.clss = clss
        
        self.separatorVisible = separator
        self.touchAnimationHide = touchAnimationHide
        
        self.editing = editing
        
        super.init()
    }
    
    override public func cellHeight() -> CGFloat {
        
        if title != nil {
            return 64
        } else {
            return 44
        }
    }
    
    override public func canEditing() -> Bool {
        return editing
    }
}

// MARK: - Cell

class TitleTextCell: TableAdapterCell {
    
    // MARK: Properties
    
    public var data: TitleTextCellData?
    
    // MARK: Outlets
    
    @IBOutlet override var selectedView: UIView? {
        didSet { }
    }
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var subtitleLabel: UILabel?
    @IBOutlet private weak var separatorView: UIView?
    @IBOutlet private weak var separatorHeightConstraint: NSLayoutConstraint?
    
    // MARK: Initialize
    
    override func awakeFromNib() {
        separatorView?.backgroundColor = .clear
        separatorHeightConstraint?.constant = 0.5
    }
    
    override func fill(data: TableAdapterCellData?) {
        guard let data = data as? TitleTextCellData else { return }
        self.data = data
        
//        self._hideAnimation = data.touchAnimationHide
        
        titleLabel?.text = data.title
        
        subtitleLabel?.text = (data.clss != nil) ? classNameString(data.clss!) : data.subtitle
        
        separatorView?.isHidden = !data.separatorVisible
    }
    
    func classNameString(_ obj: Any) -> String {
        return String(describing: type(of: obj))
    }
}
