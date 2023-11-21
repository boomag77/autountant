//
//  MainViewController.swift
//  Autountant
//
//  Created by Sergey on 11/19/23.
//

import UIKit

class MainViewController: UIViewController {
    
    var scoreLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

            // Center the label vertically
        scoreLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        NSLayoutConstraint.activate([
//            scoreLabel.topAnchor.constraint(equalTo: view.anc),
//                scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 0),
//            ])
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
