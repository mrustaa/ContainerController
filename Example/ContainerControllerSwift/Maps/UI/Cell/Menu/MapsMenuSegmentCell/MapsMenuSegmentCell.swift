



import UIKit
import ContainerControllerSwift


typealias SegmentIndexCallback = ((_ segmentIndex: Int) -> ())


// MARK: - Item

class MapsMenuSegmentCellItem: TableAdapterItem {
    
    init(selected: Int, darkStyle: Bool = false, selectIndexCallback: SegmentIndexCallback? = nil) {
        
        let cellData = MapsMenuSegmentCellData(selected, darkStyle, selectIndexCallback)
        
        super.init(cellClass: MapsMenuSegmentCell.self, cellData: cellData)
    }
}

// MARK: - Data

class MapsMenuSegmentCellData: TableAdapterCellData {
    
    // MARK: Properties
    
    var segmentIndexCallback: SegmentIndexCallback?
    var selectedIndex: Int
    var darkStyle: Bool
    
    // MARK: Inits
    
    init(_ selected: Int, _ darkStyle: Bool, _ segmentIndexCallback: SegmentIndexCallback?) {
        
        self.darkStyle = darkStyle
        self.segmentIndexCallback = segmentIndexCallback
        self.selectedIndex = selected
        
        super.init()
    }
    
    override public func cellHeight() -> CGFloat {
        return 48
    }

}

// MARK: - Cell

class MapsMenuSegmentCell: TableAdapterCell {
    
    // MARK: Properties
    
    public var data: MapsMenuSegmentCellData?
    
    // MARK: Outlets
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    // MARK: Initialize
    
    override func awakeFromNib() {
        
//        segment.insertSegment(withTitle: _L("LNG_MAPS_MENU_MAP"), at: 0, animated: false)
//        segment.insertSegment(withTitle: _L("LNG_MAPS_TRANSIT"), at: 1, animated: false)
//        segment.insertSegment(withTitle: _L("LNG_MAPS_MENU_SATELLITE"), at: 2, animated: false)
        
        segment.setTitle(_L("LNG_MAPS_MENU_MAP"), forSegmentAt: 0)
        segment.setTitle(_L("LNG_MAPS_TRANSIT"), forSegmentAt: 1)
        segment.setTitle(_L("LNG_MAPS_MENU_SATELLITE"), forSegmentAt: 2)
        
        separatorInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
//        separatorInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: CGFloat(Double.greatestFiniteMagnitude))
    }
    
    @IBAction func segmentAction(_ sender: Any) {
        data?.segmentIndexCallback?(segment.selectedSegmentIndex)
    }
    
    override func fill(data: TableAdapterCellData?) {
        guard let data = data as? MapsMenuSegmentCellData else { return }
        self.data = data
        
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: (data.darkStyle ? UIColor.white : UIColor.black)], for: .normal)
        segment.selectedSegmentTintColor = (data.darkStyle ? UIColor.white.withAlphaComponent(0.35) : UIColor.white)
        
        segment.selectedSegmentIndex = data.selectedIndex
    }
    
    
}
