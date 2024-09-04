import UIKit
import ContainerControllerSwift

// MARK: - State

extension MyCardsOneCardItem {
  struct State: Equatable {
      var visa: Bool = false
    var titleText: String?
    var subtitleText: String?
    var text2: String?
      var ccolor: UIColor?
    
  }
}

// MARK: - Item

class MyCardsOneCardItem: CollectionAdapterItem {

  init(state: MyCardsOneCardItem.State,
       clickCallback: (() -> ())? = nil) {

    let cellData =  MyCardsOneCardCellData(state: state,
                                  clickCallback: clickCallback)
    super.init(cellClass: MyCardsOneCardCell.self, cellData: cellData)
  }
}

// MARK: - Data

class MyCardsOneCardCellData: CollectionAdapterCellData {

  // MARK: Properties
  var state: MyCardsOneCardItem.State
  public var clickCallback: (() -> Void)?
  
  // MARK: Inits
  init(state: MyCardsOneCardItem.State,
       clickCallback: (() -> ())?) {
     self.state = state

     self.clickCallback = clickCallback
     super.init()
 }
  
 override public func size() -> CGSize {
     return CGSize(width: 152.0, height: 190.0)
 }
}

// MARK: - Cell

class MyCardsOneCardCell: CollectionAdapterCell {
  
  // MARK: Properties
  
  public var data: MyCardsOneCardCellData?
  
    @IBOutlet var imggView: UIImageView!
    @IBOutlet var button: UIButton!
    // MARK: Outlets
  
  @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var subtitleLabel: UILabel?
    @IBOutlet var cccardView: DesignFigure!
    @IBOutlet private weak var label2: UILabel?
    
  
  // MARK: Initialize
  
 override func awakeFromNib() { }
 
 override func fill(data: Any?) {
     guard let data = data as? MyCardsOneCardCellData else { return }
     self.data = data
     
     
     
     if let c = data.state.ccolor {
         self.cccardView.fillColor = c
     } else {
         self.cccardView.fillColor = data.state.visa ? Colors.hexStr("0C1229") : .white
     }
//     self.cccardView.layer.backgroundColor = data.state.visa ? Colors.hexStr("0C1229").cgColor : .white.cgColor
     self.cccardView.layoutSubviews()
     self.cccardView.layoutIfNeeded()
     
     let imgMaster  =   #imageLiteral(resourceName: "imgMyCardsMasterCard")
     let imgVisa  =   #imageLiteral(resourceName: "imgMyCardsVisa")
     
     self.imggView.tintColor = .white
     self.imggView.image = data.state.visa ? imgVisa  : imgMaster
     
     titleLabel?.textColor = data.state.visa ? .white  : .black
     label2?.textColor = data.state.visa ? .white  : .black
     subtitleLabel?.textColor = data.state.visa ? .white  : .black
     
     if let v = data.state.titleText { titleLabel?.text = v }
        if let v = data.state.subtitleText { subtitleLabel?.text = v }
        if let v = data.state.text2 { label2?.text = v }
        
  }
}
