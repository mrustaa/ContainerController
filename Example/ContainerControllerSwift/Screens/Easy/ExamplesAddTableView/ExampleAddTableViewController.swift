//
//  ExampleAddTableViewController.swift
//  ContainerControllerSwift
//
//  Created by mrustaa on 09.06.2020.
//  Copyright © 2020 mrustaa. All rights reserved.
//

import UIKit
import ContainerControllerSwift

class ExampleAddTableViewController: StoryboardController {

    var container: ContainerController!
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Example Add TableView"
        
        let layout = ContainerLayout()
        layout.backgroundShadowShow = true
        layout.positions = ContainerPosition(top: 70, middle: 250, bottom: 100)
        container = ContainerController(addTo: self, layout: layout)
        container.view.cornerRadius = 15
        container.view.addShadow()
        container.add(scrollView: addTableView())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        container.move(type: .top)
    }
    
    func addTableView() -> UITableView {
        
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }

}

// MARK: - Scroll Delegate

extension ExampleAddTableViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        container.scrollViewDidScroll(scrollView)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        container.scrollViewWillBeginDragging(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        container.scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        container.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    }
}

// MARK: - Table Delegate

extension ExampleAddTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// MARK: - Table DataSource

extension ExampleAddTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 21
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "item \(indexPath.row)"
        cell.backgroundColor = .clear
        return cell
    }
}

