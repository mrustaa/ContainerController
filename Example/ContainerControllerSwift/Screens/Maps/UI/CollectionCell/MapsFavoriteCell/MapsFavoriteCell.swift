


import UIKit
import ContainerControllerSwift


enum MapsFavoriteColorType {
    case blue // 0 174 239
    case brown // 173 120 85
    case red // 255 92 71
    case orange // Colors.rgb(248, 149, 64)
    case yellow // : UIColor = Colors.rgb(255, 179, 0)
    case gray // 118 118 128 15%
}

class MapsFavoriteItem: CollectionAdapterItem {
    
    init(title: String? = nil,
         subtitle: String? = nil,
         colorType: MapsFavoriteColorType,
         image: UIImage? = nil,
         darkStyle: Bool = false,
         clickCallback: (() -> Void)? = nil) {
        
        let cellData = MapsFavoriteCellData(title, subtitle, colorType, image, darkStyle, clickCallback)
        
        super.init(cellClass: MapsFavoriteCell.self, cellData: cellData)
    }
}


class MapsFavoriteCellData: CollectionAdapterCellData {
    
    // MARK: Properties
    
    public let title: String
    public let subTitle: String
    public let colorType: MapsFavoriteColorType
    public let image: UIImage?
    public let darkStyle: Bool
    public var clickCallback: (() -> Void)?
    
    // MARK: Inits
    
    public init (_ title: String?,
                 _ subTitle: String?,
                 _ colorType: MapsFavoriteColorType,
                 _ image: UIImage?,
                 _ darkStyle: Bool,
                 _ clickCallback: (() -> Void)?) {
        
        self.title = title ?? ""
        self.subTitle = subTitle ?? ""
        self.colorType = colorType
        self.image = image
        self.darkStyle = darkStyle
        self.clickCallback = clickCallback
        
        super.init()
    }
    
    override public func size() -> CGSize {
        return CGSize(width: 86, height: 137)
    }
}


class MapsFavoriteCell: CollectionAdapterCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var imageButton: DesignButton?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var subtitleLabel: UILabel?
    
    // MARK: Properties
    
    public var data: MapsFavoriteCellData?
    
    override func awakeFromNib() {
        
    }
    
    override func fill(data: Any?) {
        
        guard let data = data as? MapsFavoriteCellData else { return }
        self.data = data
        
        titleLabel?.textColor = data.darkStyle ? .white : .black
        
        titleLabel?.text = data.title
        subtitleLabel?.text = data.subTitle
        
        if let image = data.image {
            imageButton?.setImage(image, for: .normal)
        }
        
        var color: UIColor
        
        switch data.colorType {
        case .blue: color = Colors.rgb(0, 174, 239)
        case .red: color = Colors.rgb(255, 92, 71)
        case .brown: color = Colors.rgb(173, 120, 85)
        case .orange: color = Colors.rgb(248, 149, 64)
        case .yellow: color = Colors.rgb(255, 179, 0)
        case .gray: color = Colors.rgba(155, 155, 155, 0.2)
        }
        
        if data.colorType == .gray {
            imageButton?.tintColor = .systemBlue
        } else {
            imageButton?.tintColor = .white
        }
        
        imageButton?.layer.backgroundColor = color.cgColor
        imageButton?.fillColor = color
    }

    @IBAction func buttonClickAction(_ sender: Any) {
        data?.clickCallback?()
    }
}
