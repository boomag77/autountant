//
//  TabViewController.swift
//  Autountant
//
//  Created by Sergey on 11/27/23.
//

import UIKit

class TabViewController: UITabBarController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configure()
    }
    
    private func configure() {
        
        view.backgroundColor = .systemBackground
                
        let garageVC = VehiclesViewController()
        garageVC.tabBarItem = UITabBarItem(title: "Garage", image: UIImage(systemName: "car.2.fill"), selectedImage: nil)
        
        let testVC = TVViewController()
        testVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), selectedImage: nil)
        
        viewControllers = [garageVC, testVC]
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
