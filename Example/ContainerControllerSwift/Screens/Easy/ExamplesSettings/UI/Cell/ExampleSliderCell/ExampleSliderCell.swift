



import UIKit
import ContainerControllerSwift

// MARK: - Item

class ExampleSliderCellItem: TableAdapterItem {
    
    init(height: CGFloat? = nil,
         delegate: ExampleCellDelegate? = nil,
         type: ExampleCell.Style = .default,
         title: String? = nil,
         
         value: Float? = nil,
         maximumValue: Float? = nil,
         minimumValue: Float? = nil,
         callback: ((Int) -> Void)? = nil) {
        
        let cellData = ExampleSliderCellData(type, title, value, maximumValue, minimumValue, height, delegate, callback)
        
        super.init(cellClass: ExampleSliderCell.self, cellData: cellData)
    }
}

// MARK: - Data

class ExampleSliderCellData: ExampleCellData {
    
    // MARK: Properties

    var value: Float
    var maximumValue: Float
    var minimumValue: Float
    
    // MARK: Inits
    
    init(_ type: ExampleCell.Style,
         _ title: String? = nil,
         _ value: Float? = nil,
         _ maximumValue: Float? = nil,
         _ minimumValue: Float? = nil,
         _ cellHeight: CGFloat?,
         _ delegate: ExampleCellDelegate?,
         _ callback: ((Int) -> Void)?) {
        
        let v = value ?? 1.0
        
        self.value = v
        self.maximumValue = maximumValue ?? v
        self.minimumValue = minimumValue ?? 0.0
        
        super.init(type, title, cellHeight, delegate, callback)
    }
    
    override public func cellHeight() -> CGFloat {
        return 75.0
    }
}

// MARK: - Cell

class ExampleSliderCell: ExampleCell {
    
    // MARK: Properties
    
    public var data: ExampleSliderCellData?
    
    // MARK: Outlets
    
    @IBOutlet override var selectedView: UIView? {
        didSet { }
    }
    
    @IBOutlet private weak var slider: UISlider?
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var valueLabel: UILabel?
    
    // MARK: Load
    
    override func awakeFromNib() {
    }
    
    // MARK: Initialize
    
    override func fill(data: TableAdapterCellData?) {
        guard let data = data as? ExampleSliderCellData else { return }
        self.data = data
        
        titleLabel?.text = data.title
        
        slider?.maximumValue = data.maximumValue
        slider?.minimumValue = data.minimumValue
        slider?.value = data.value
        
        if let slider = slider {
            let value = slider.value
            valueLabel?.text = String(format: "%.1f", value)
            data.value = value
        }
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        valueLabel(slider: sender)
    }
    
    func valueLabel(slider: UISlider) {
        guard let data = data else { return }
        
        let value = slider.value
        valueLabel?.text = String(format: "%.1f", value)
        data.value = value

        data.callback?(Int(value))
        data.delegate?.exampleCell(self, type: data.type, value: CGFloat(value), endEditing: false)
    }
    
    @IBAction func touchUpInside(_ slider: UISlider) {
        guard let data = data else { return }
        
        let value = slider.value
        valueLabel?.text = String(format: "%.1f", value)
        data.value = value

        data.callback?(Int(value))
        data.delegate?.exampleCell(self, type: data.type, value: CGFloat(value), endEditing: true)
    }
    
}
