import UIKit
import ContainerControllerSwift

// MARK: - State

extension SportTagFilterItem {
  struct State {
    var titleText: String?
      var new: Bool = false
      var sport: Bool = false
      var radius: CGFloat?
      var handlers: Handlers = .init()
  }
    struct Handlers {
        var onClickAt: (()->(Void))?
    }
}

// MARK: - Item

class SportTagFilterItem: CollectionAdapterItem {

  init(state: SportTagFilterItem.State,
       clickCallback: (() -> ())? = nil) {

    let cellData =  SportTagFilterCellData(state: state,
                                  clickCallback: clickCallback)
    super.init(cellClass: SportTagFilterCell.self, cellData: cellData)
  }
}

// MARK: - Data

class SportTagFilterCellData: CollectionAdapterCellData {

  // MARK: Properties
  var state: SportTagFilterItem.State
  public var clickCallback: (() -> Void)?
  
  // MARK: Inits
  init(state: SportTagFilterItem.State,
       clickCallback: (() -> ())?) {
     self.state = state

     self.clickCallback = clickCallback
     super.init()
 }
  
    override public func size() -> CGSize {
        let sport = self.state.sport
        if sport {
            return CGSize(width: 101.0, height: 54.0)
        } else {
            if let text = self.state.titleText {
                let w = sizeToFitLabel(text: text, font: UIFont.boldSystemFont(ofSize: 13), lines: 1, padding: 16).width
                return CGSize(width: w, height: 54.0)
            } else {
                
                return CGSize(width: 101.0, height: 54.0)
            }
        }
    }
}



// MARK: - Cell

class SportTagFilterCell: CollectionAdapterCell {
  
  // MARK: Properties
  
  public var data: SportTagFilterCellData?
  
    @IBOutlet var button: UIButton!
    @IBOutlet var ccardView: DesignnShadowView!
    // MARK: Outlets
    
    @IBOutlet var rectView: DesignnView!
    @IBOutlet var rectView2: DesignnView!
  
  @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var titleLabel2: UILabel?
    
  
  // MARK: Initialize
  
 override func awakeFromNib() { 
     ccardView.layer.cornerRadius = 20
     button?.tapHideAnimation(
        views: [ccardView],
        type: .layerGray(0.5),
        callback: { [weak self] type in
            if type == .touchUpInside {
                self?.data?.state.handlers.onClickAt?()
            }
        }
     )
     
 }
 
 override func fill(data: Any?) {
     guard let data = data as? SportTagFilterCellData else { return }
     self.data = data

     let new = self.data?.state.new ?? false
     rectView.isHidden = new
     rectView2.isHidden = !new
     rectView.alpha = new ? 0 : 1
     rectView2.alpha = new ? 1 : 0
     
     let sport = self.data?.state.sport ?? false
     
     if sport {
         rectView.alpha = 1.0
         rectView2.alpha = 0.0
         rectView.isHidden = false
         rectView2.isHidden = true
     }
     
     ccardView.layer.cornerRadius = data.state.radius ?? 20
     ccardView.cornerRadius = data.state.radius ?? 20
     ccardView.layoutSubviews()
     ccardView.layoutIfNeeded()
     
     if let v = data.state.titleText { titleLabel?.text = v; titleLabel2?.text = v }
        
  }
}
