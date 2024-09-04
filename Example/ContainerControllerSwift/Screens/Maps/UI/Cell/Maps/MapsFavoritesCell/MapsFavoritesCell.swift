



import UIKit
import ContainerControllerSwift

// MARK: - Item

class MapsFavoritesCellItem: TableAdapterItem {
    
    init(title: String? = nil,
         subtitle: String? = nil,
         image: UIImage? = nil,
         darkStyle: Bool = false,
         clickCallback: (() -> Void)? = nil) {
        
        let cellData = MapsFavoritesCellData(title, subtitle, darkStyle, clickCallback)
        
        super.init(cellClass: MapsFavoritesCell.self, cellData: cellData)
    }
}

// MARK: - Data

class MapsFavoritesCellData: TableAdapterCellData {
    
    // MARK: Properties
    
    var title: String?
    var subtitle: String?
    var darkStyle: Bool
    var clickCallback: (() -> Void)?
    
    // MARK: Inits
    
    init(_ title: String? = nil,
         _ subtitle: String? = nil,
         _ darkStyle: Bool,
         _ clickCallback: (() -> Void)?) {
        
        self.title = title
        self.subtitle = subtitle
        self.darkStyle = darkStyle
        self.clickCallback = clickCallback
        
        super.init()
    }
    
    override public func cellHeight() -> CGFloat {
        return 137
    }
    
    class func collectionItems(darkStyle: Bool = false, clickCallback: (() -> Void)? = nil) -> [CollectionAdapterItem] {
        var items: [CollectionAdapterItem] = []
        items.append( MapsFavoriteItem(title: _L("LNG_MAPS_HOME"), subtitle: _L("LNG_MAPS_ADD"), colorType: .blue, image: UIImage(systemName:"house.fill"), darkStyle: darkStyle, clickCallback: { clickCallback?() }) )
        items.append( MapsFavoriteItem(title: _L("LNG_MAPS_WORK"), subtitle: _L("LNG_MAPS_ADD"), colorType: .brown, image: UIImage(systemName: "briefcase.fill"), darkStyle: darkStyle, clickCallback: { clickCallback?() }) )
        items.append( MapsFavoriteItem(title: _L("LNG_MAPS_STREET"), subtitle: "", colorType: .red, image: UIImage(systemName: "mappin"), darkStyle: darkStyle, clickCallback: { clickCallback?() }) )
        items.append( MapsFavoriteItem(title: _L("LNG_MAPS_SCORE"), subtitle: "", colorType: .orange, image: UIImage(systemName: "cart.fill"), darkStyle: darkStyle, clickCallback: { clickCallback?() }) )
        items.append( MapsFavoriteItem(title: _L("LNG_MAPS_STREET"), subtitle: "", colorType: .yellow, image: UIImage(systemName: "person.circle.fill"), darkStyle: darkStyle, clickCallback: { clickCallback?() }) )
        items.append( MapsFavoriteItem(title: _L("LNG_MAPS_ADD"), subtitle: "", colorType: .gray, image: UIImage(systemName: "plus"), darkStyle: darkStyle, clickCallback: { clickCallback?() }) )
        return items
    }
}

// MARK: - Cell

class MapsFavoritesCell: TableAdapterCell {
    
    // MARK: Properties
    
    public var data: MapsFavoritesCellData?
    
    // MARK: Outlets
    
    @IBOutlet weak var colletionView: CollectionAdapterView!
    var items: [CollectionAdapterItem] = []
    
    // MARK: Initialize
    
    override func awakeFromNib() {
        separatorInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: CGFloat(Double.greatestFiniteMagnitude))
    }
    
    override func fill(data: TableAdapterCellData?) {
        guard let data = data as? MapsFavoritesCellData else { return }
        self.data = data
        
        items = []
        
        items = MapsFavoritesCellData.collectionItems(darkStyle: data.darkStyle, clickCallback: data.clickCallback)
        
        colletionView.set(items: items)
        
    }
    
    
}
