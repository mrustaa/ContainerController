



import UIKit
import ContainerControllerSwift

// MARK: - Item

class ExampleSegmentCellItem: TableAdapterItem {
    
    init(height: CGFloat? = nil,
         delegate: ExampleCellDelegate? = nil,
         type: ExampleCell.Style = .default,
         title: String? = nil,
         segmentItems: [String]? = nil,
         index: Int? = nil,
         callback: ((Int) -> Void)? = nil) {
        
        let cellData = ExampleSegmentCellData(type, title, segmentItems, index, height, delegate, callback)
        
        super.init(cellClass: ExampleSegmentCell.self, cellData: cellData)
    }
}

// MARK: - Data

class ExampleSegmentCellData: ExampleCellData {
    
    // MARK: Properties
    
    var segmentItems: [String]
    var selectIndex: Int
    
    // MARK: Inits
    
    init(_ type: ExampleCell.Style,
         _ title: String?,
         _ segmentItems: [String]?,
         _ index: Int?,
         _ cellHeight: CGFloat?,
         _ delegate: ExampleCellDelegate?,
         _ callback: ((Int) -> Void)?) {
        
        self.segmentItems = segmentItems ?? []
        self.selectIndex = index ?? 0
        
        super.init(type, title, cellHeight, delegate, callback)
    }
    
    
    override public func cellHeight() -> CGFloat {
        return 81
    }
    
}

// MARK: - Cell

class ExampleSegmentCell: TableAdapterCell {
    
    // MARK: Properties
    
    public var data: ExampleSegmentCellData?
    
    // MARK: Outlets
    
    @IBOutlet override var selectedView: UIView? {
        didSet { }
    }
    
    @IBOutlet private weak var segmentControl: UISegmentedControl?
    @IBOutlet private weak var titleLabel: UILabel?
    
    // MARK: Load
    
    override func awakeFromNib() {
    }
    
    // MARK: Initialize
    
    override func fill(data: TableAdapterCellData?) {
        guard let data = data as? ExampleSegmentCellData else { return }
        self.data = data
        
        titleLabel?.text = data.title

        segmentControl?.removeAllSegments()
        for (index, item) in data.segmentItems.enumerated() {
            segmentControl?.insertSegment(withTitle: item, at: index, animated: false)
        }
        segmentControl?.selectedSegmentIndex = data.selectIndex
        
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        guard let data = data else { return }
        
        let value = sender.selectedSegmentIndex
        data.selectIndex = value
        
        data.callback?(value)
        data.delegate?.exampleCell(self, type: data.type, value: CGFloat(value), endEditing: true)
    }
    
}
