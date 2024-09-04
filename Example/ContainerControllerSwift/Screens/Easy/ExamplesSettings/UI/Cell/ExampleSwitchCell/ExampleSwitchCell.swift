



import UIKit
import ContainerControllerSwift

// MARK: - Item

class ExampleSwitchCellItem: TableAdapterItem {
    
    init(height: CGFloat? = nil,
         delegate: ExampleCellDelegate? = nil,
         type: ExampleCell.Style = .default,
         title: String = "",
         value: Bool = false,
         callback: ((Int) -> Void)? = nil) {
        
        let cellData = ExampleSwitchCellData(type, title, value, height, delegate, callback)
        
        super.init(cellClass: ExampleSwitchCell.self, cellData: cellData)
    }
}

// MARK: - Data

class ExampleSwitchCellData: ExampleCellData {
    
    // MARK: Properties
    
    var value: Bool
    
    // MARK: Inits
    
    init(_ type: ExampleCell.Style,
         _ title: String,
         _ value: Bool,
         _ cellHeight: CGFloat?,
         _ delegate: ExampleCellDelegate?,
         _ callback: ((Int) -> Void)?) {
        
        self.value = value
        
        super.init(type, title, cellHeight, delegate, callback)
    }
    
    override public func cellHeight() -> CGFloat {
        return cellSizeHeight ?? 51.0
    }

}

// MARK: - Cell

class ExampleSwitchCell: TableAdapterCell {
    
    // MARK: Properties
    
    public var data: ExampleSwitchCellData?
    
    // MARK: Outlets
    
    @IBOutlet override var selectedView: UIView? {
        didSet { }
    }
    
    @IBOutlet private weak var switchButton: UISwitch?
    @IBOutlet private weak var titleLabel: UILabel?
    
    // MARK: Load
    
    override func awakeFromNib() {
    }
    
    // MARK: Initialize
    
    override func fill(data: TableAdapterCellData?) {
        guard let data = data as? ExampleSwitchCellData else { return }
        self.data = data
        
        titleLabel?.text = data.title
        switchButton?.setOn(data.value, animated: false)
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        guard let data = data else { return }

        let value = sender.isOn
        data.value = value
        
        data.callback?((value ? 1 : 0))
        data.delegate?.exampleCell(self, type: data.type, value: (value ? 1 : 0), endEditing: true)
    }
}
