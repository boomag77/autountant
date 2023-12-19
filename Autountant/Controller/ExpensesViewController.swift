//
//  ExpenseViewController.swift
//  Autountant
//
//  Created by Sergey on 11/19/23.
//

import UIKit

class ExpensesViewController: UIViewController {
    
    var manager: DataManager!
    weak var activeVehicle: Vehicle?
    private var amountOfFileteredExpenses: String = "10,000"
    private var testExpensesSet: [String] = ["First expense", "Second expense", "Third expense"]
    
    private lazy var activeVehicleNameLabel: UILabel = {
        let label = UILabel()
        label.text = "N/A"
        return label
    }()
    
    private lazy var amountOfFilteredExpensesLabel: UILabel = {
        let label = UILabel()
        label.text = "N/A"
        label.contentMode = .left
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func setup() {
        
        view.addSubview(activeVehicleNameLabel)
        view.addSubview(amountOfFilteredExpensesLabel)
        view.addSubview(tableView)
        
        activeVehicleNameLabel.translatesAutoresizingMaskIntoConstraints = false
        amountOfFilteredExpensesLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        if let activeVehicle = activeVehicle {
            activeVehicleNameLabel.text = activeVehicle.name
            amountOfFilteredExpensesLabel.text = "Total amount: \(amountOfFileteredExpenses) \(activeVehicle.currency)"
        }
        
        activeVehicleNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activeVehicleNameLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10.0).isActive = true
        
        amountOfFilteredExpensesLabel.topAnchor.constraint(equalTo: activeVehicleNameLabel.bottomAnchor, constant: 20.0).isActive = true
        amountOfFilteredExpensesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0).isActive = true
        amountOfFilteredExpensesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0).isActive = true
        
        tableView.topAnchor.constraint(equalTo: amountOfFilteredExpensesLabel.bottomAnchor, constant: 20.0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20.0).isActive = true
        
    }
    

}

extension ExpensesViewController: TabBarDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        self.manager = DataManager()
        self.activeVehicle = manager.getActiveVehicle()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "expense")
        setup()
        
    }
}

extension ExpensesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return testExpensesSet.count
        //manager.getExpensesCount()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let expense = testExpensesSet[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "expense", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = activeVehicle!.name + " " + expense
        cell.contentConfiguration = content
        
        return cell
    }
    
    
}
