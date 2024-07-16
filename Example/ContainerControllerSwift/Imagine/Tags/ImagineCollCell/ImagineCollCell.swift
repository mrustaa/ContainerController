import UIKit
import ContainerControllerSwift

// MARK: - State

extension ImagineCollItem {
  struct State: Equatable {
    var titleText: String?
    var subtitleText: String?
    var text2: String?
    var image3: UIImage?
      var color1: UIColor?
      var color2: UIColor?
    
  }
}

// MARK: - Item

class ImagineCollItem: CollectionAdapterItem {

  init(state: ImagineCollItem.State,
       clickCallback: (() -> ())? = nil) {

    let cellData =  ImagineCollCellData(state: state,
                                  clickCallback: clickCallback)
    super.init(cellClass: ImagineCollCell.self, cellData: cellData)
  }
}

// MARK: - Data

class ImagineCollCellData: CollectionAdapterCellData {

  // MARK: Properties
  var state: ImagineCollItem.State
  public var clickCallback: (() -> Void)?
  
  // MARK: Inits
  init(state: ImagineCollItem.State,
       clickCallback: (() -> ())?) {
     self.state = state

     self.clickCallback = clickCallback
     super.init()
 }
  
 override public func size() -> CGSize {
     return CGSize(width: 345, height: 320.0)
 }
}

// MARK: - Cell

class ImagineCollCell: CollectionAdapterCell {
  
  // MARK: Properties
  
  public var data: ImagineCollCellData?
  
  // MARK: Outlets
    @IBOutlet var rectView: DesignFigure!
    
    @IBOutlet var button: UIButton! 
  @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var subtitleLabel: UILabel?
    @IBOutlet private weak var label2: UILabel?
    @IBOutlet private weak var imageView3: UIImageView?
    
    @IBOutlet var imgView: UIImageView!
    
  // MARK: Initialize
  
 override func awakeFromNib() { }
 
 override func fill(data: Any?) {
     guard let data = data as? ImagineCollCellData else { return }
     self.data = data

     titleLabel?.text = data.state.titleText
        subtitleLabel?.text = data.state.subtitleText
        label2?.text = data.state.text2
        imageView3?.image = data.state.image3
     imgView.image = data.state.image3
     
     if let color1 = data.state.color1,
        let color2 = data.state.color2 {
         
         rectView.grColor1 = color1
         rectView.grColor2 = color2
         rectView.setup()
     }
     
  }
}
