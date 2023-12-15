//
//  MainViewController.swift
//  Autountant
//
//  Created by Sergey on 11/19/23.
//

import UIKit

final class MainViewController: UIViewController {
    
    var dataManager: DataManager!
    
    lazy var currentVehicle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
    }
    
    private func setup() {
        
        
        currentVehicle.text = dataManager.getActiveVehicle()?.name
        view.addSubview(currentVehicle)
        
        currentVehicle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        currentVehicle.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        
        
    }
}

extension MainViewController: TabBarDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        dataManager = DataManager()
        setup()
    }
    
    
}
