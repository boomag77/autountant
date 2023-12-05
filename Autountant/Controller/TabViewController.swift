//
//  TabViewController.swift
//  Autountant
//
//  Created by Sergey on 11/27/23.
//

import UIKit

protocol TabBarDelegate: UIViewController {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController)
}

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.configure()
    }
    
    private func configure() {
        
        view.backgroundColor = .systemBackground
                
        let garageVC = VehiclesViewController()
        garageVC.tabBarItem = UITabBarItem(title: "Garage", image: UIImage(systemName: "car.2.fill"), selectedImage: nil)
        
        
        let homeVC = MainViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), selectedImage: nil)
        
        let expensesVC = ExpensesTableViewController()
        expensesVC.tabBarItem = UITabBarItem(title: "Expenses", image: UIImage(systemName: "list.clipboard.fill"), selectedImage: nil)
        
        viewControllers = [homeVC, garageVC, expensesVC]
        self.tabBarController(self, didSelect: homeVC)
        
    }

}

extension TabViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let selectedVC = viewController as? TabBarDelegate {
            selectedVC.tabBarController(tabBarController, didSelect: viewController)
        }
    }
}
