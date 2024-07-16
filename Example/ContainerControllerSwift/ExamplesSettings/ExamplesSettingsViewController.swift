


import UIKit
import ContainerControllerSwift


class ExamplesSettingsViewController: StoryboardController {
    
    // MARK: - Properties
    
    var containers: [ContainerController] = []
    var items: [TableAdapterItem] = []
    
    @IBOutlet weak var tableView: TableAdapterView?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Example Add/Settings Container"
        
        let barButtonAddItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navigationBarAddAction))
        let barButtonCloseItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(navigationBarCloseAction))
        self.navigationItem.rightBarButtonItems = [ barButtonAddItem, barButtonCloseItem ]
        
        loadTableView()
        
        containers(addStyle: .tableAdapterView)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        for container in containers {
            container.remove()
        }
    }
    
    // MARK: - Load TableView
    
    func loadTableView() {
        
        tableView?.deleteIndexCallback = { [weak self] (index) in
            guard let _self = self else { return }
            _self.containers(remove: index)
        }
        tableView?.selectIndexCallback = { [weak self] (index) in
            guard let _self = self else { return }
            _self.containers[index].move(type: .top)
        }
        tableView?.didScrollCallback = { [weak self] in
            guard let _self = self else { return }
            
            _self.view.endEditing(true)
        }
    }
    
    // MARK: - Navigation Bar Actions
    
    @objc func navigationBarCloseAction(_ sender: UIBarButtonItem) {
        containers(remove: containers.count - 1)
    }
    
    @objc func navigationBarAddAction(_ sender: UIBarButtonItem? = nil) {
        
        let alert = UIAlertController(title: "Add Container",
                                      message: "together with ScrollView",
                                      preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        ExamplesContainerController.ScrollType.allCases.forEach { style in
            alert.addAction(UIAlertAction(title: style.rawValue,
                                          style: style == .tableAdapterView ? .destructive : .default,
                                          handler: { [weak self] _ in
                guard let _self = self else { return }
                _self.containers(addStyle: style)
            }))
        }
        
        self.present(alert, animated: true)
    }
    
    // MARK: - Add/Remove Container
    
    func containers(addStyle containerStyle: ExamplesContainerController.ScrollType) {
        
        switch containerStyle {
        case .mapsContainer:     containers(add:     MapsContainerController(addTo: self, darkStyle: false), style: containerStyle)
        case .locationContainer: containers(add: LocationContainerController(addTo: self, darkStyle: false), style: containerStyle)
        case .routeContainer:    containers(add:    RouteContainerController(addTo: self, darkStyle: false), style: containerStyle)
        case .menuContainer:     containers(add:     MenuContainerController(addTo: self, darkStyle: false, selectedIndex: 0), style: containerStyle)
        default:                 containers(add: ExamplesContainerController(addTo: self, style: containerStyle), style: containerStyle)
        }
    }
    
    func containers(add container: ContainerController, style: ExamplesContainerController.ScrollType) {

        container.move(type: .bottom, completion: {
            container.move(type: .top)
        })
        
        containers.append(container)
        
        let subTitle = String(describing: type(of: container))
        let title = style.rawValue
        
        items.append( TitleTextxItem(title: title, subtitle: subTitle, editing: true) )
        tableView?.set(items: items, animated: true)
    }
    
    func containers(remove index: Int) {
        if containers.isEmpty, items.isEmpty { return }
        
        let container = containers[index]
        container.remove()
        
        containers.remove(at: index)
        items.remove(at: index)
        
        tableView?.set(items: items, animated: true)
    }
}

