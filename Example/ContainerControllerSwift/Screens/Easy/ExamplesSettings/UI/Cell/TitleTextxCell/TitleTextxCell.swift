



import UIKit
import ContainerControllerSwift

// MARK: - Item

class TitleTextxItem: TableAdapterItem {
    
    init(title: String? = nil,
         subtitle: String? = nil,
         separator: Bool = false,
         clss: AnyClass? = nil,
         img: UIImage? = nil,
         touchAnimationHide: Bool = false,
         editing: Bool = false) {
        
        let cellData = TitleTextxCellData(title, subtitle, separator, clss, img, touchAnimationHide, editing)
        
        super.init(cellClass: TitleTextxCell.self, cellData: cellData)
    }
}

// MARK: - Data

class TitleTextxCellData: TableAdapterCellData {
    
    // MARK: Properties
    
    var title: String?
    var subtitle: String?
    var clss: AnyClass?
    var img: UIImage?
    var separatorVisible: Bool
    var touchAnimationHide: Bool
    
    
    // MARK: Inits
    
    init(_ title: String? = nil,
         _ subtitle: String? = nil,
         _ separator: Bool,
         _ clss: AnyClass? = nil,
         _ img: UIImage? = nil,
         _ touchAnimationHide: Bool,
         _ editing: Bool) {
        
        self.title = title
        self.subtitle = subtitle
        
        self.clss = clss
        self.img = img
        
        self.separatorVisible = separator
        self.touchAnimationHide = touchAnimationHide
        
//        self.editing = editing
        
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

class TitleTextxCell: TableAdapterCell {
    
    // MARK: Properties
    
    public var data: TitleTextxCellData?
    
    // MARK: Outlets
    
    @IBOutlet override var selectedView: UIView? {
        didSet { }
    }
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var subtitleLabel: UILabel?
    @IBOutlet private weak var separatorView: UIView?
    @IBOutlet private weak var separatorHeightConstraint: NSLayoutConstraint?
    @IBOutlet var iconFigureVView: DesignFigure!
    
    // MARK: Initialize
    
    override func awakeFromNib() {
        separatorView?.backgroundColor = .clear
        separatorHeightConstraint?.constant = 0.5
    }
    
    override func fill(data: TableAdapterCellData?) {
        guard let data = data as? TitleTextxCellData else { return }
        self.data = data
        
//        self._hideAnimation = data.touchAnimationHide
        
//        titleLabel?.text = (data.clss != nil) ? classNameString(data.clss!) : data.title
        titleLabel?.text = data.title
        subtitleLabel?.text =  data.subtitle
        
        iconFigureVView?.isHidden = (data.img == nil)
        iconFigureVView?.image = data.img
        iconFigureVView?.layoutSubviews()
        separatorView?.isHidden = !data.separatorVisible
    }
    
    func classNameString(_ obj: Any) -> String {
        return String(describing: type(of: obj))
    }
}
