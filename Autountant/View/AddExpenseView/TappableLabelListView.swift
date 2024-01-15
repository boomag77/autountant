//
//  TappableLabelListView.swift
//  Autountant
//
//  Created by Sergey on 1/15/24.
//

import UIKit

class TappableLabelListView: UIView {
    
    var itemsList: [String] = [] {
        didSet {
            setup()
        }
    }
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "category")
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}

extension TappableLabelListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = itemsList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = category
        cell.contentConfiguration = content
        return cell
    }
    
    
}
