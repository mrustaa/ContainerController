


import UIKit
import ContainerControllerSwift


class ExampleCollectionItem: CollectionAdapterItem {
    
    init(width: CGFloat,
         padding: CGFloat,
         clickCallback: (() -> Void)? = nil) {
        
        let cellData = ExampleCollectionCellData(width, padding, clickCallback)
        
        super.init(cellClass: ExampleCollectionCell.self, cellData: cellData)
    }
}


class ExampleCollectionCellData: CollectionAdapterCellData {
    
    // MARK: Properties
    
    public var width: CGFloat
    public var padding: CGFloat
    public var clickCallback: (() -> Void)?
    
    // MARK: Inits
    
    public init (_ width: CGFloat,
                 _ padding: CGFloat,
                 _ clickCallback: (() -> Void)?) {
        
        self.width = width
        self.padding = padding
        self.clickCallback = clickCallback
        
        super.init()
    }
    
    override public func size() -> CGSize {
        let w = (width / 2) - ((padding / 2) * 3)
        return CGSize(width: w, height: w)
    }
}


class ExampleCollectionCell: CollectionAdapterCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var imageButton: DesignButton?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var subtitleLabel: UILabel?
    
    // MARK: Properties
    
    public var data: ExampleCollectionCellData?
    
    override func awakeFromNib() {
        
    }
    
    override func fill(data: Any?) {
        
        guard let data = data as? ExampleCollectionCellData else { return }
        self.data = data
        
        let randomInt = Int.random(in: 0..<6)
        
        var color: UIColor = .systemBlue
        
        switch randomInt {
        case 0: color = .systemBlue
        case 1: color = .systemRed
        case 2: color = .systemGray
        case 3: color = .systemGreen
        case 4: color = .systemYellow
        case 5: color = .systemOrange
        default: break
        }
        
        imageButton?.layer.backgroundColor = color.cgColor
        imageButton?.fillColor = color
    }

    @IBAction func buttonClickAction(_ sender: Any) {
        data?.clickCallback?()
    }
}
