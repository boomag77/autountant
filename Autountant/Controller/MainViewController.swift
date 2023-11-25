//
//  MainViewController.swift
//  Autountant
//
//  Created by Sergey on 11/19/23.
//

import UIKit

final class MainViewController: UIViewController {
    
    var labelCenterYConstraint: NSLayoutConstraint!
    var labelTopYConstraint: NSLayoutConstraint!
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Testing constraints"
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let checkBox = CheckBox()
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(checkBox)
        
        checkBox.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        checkBox.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        checkBox.widthAnchor.constraint(equalToConstant: 100).isActive = true
        checkBox.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        checkBox.addTarget(self, action: #selector(checkBoxPressed), for: .touchUpInside)
        
        view.addSubview(label)
        
        let labelCenterXConstrain = label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        labelCenterYConstraint = label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        labelTopYConstraint = label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        labelCenterXConstrain.isActive = true
        labelCenterYConstraint.isActive = true
        
        let button = UIButton(type: .system)
        button.setTitle("Push me", for: .normal)
        button.addTarget(self, action: #selector(buttonPushed), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        
        let leftButtonContarint = button.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        leftButtonContarint.isActive = true
        let rightButtonContarint = button.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        rightButtonContarint.isActive = true
        let bottomButtonContarint = button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        bottomButtonContarint.isActive = true
    }
    
    @objc func buttonPushed(_ button: UIButton) {
        if labelCenterYConstraint.isActive {
            labelCenterYConstraint.isActive = false
            labelTopYConstraint.isActive = true
        } else {
            labelCenterYConstraint.isActive = true
            labelTopYConstraint.isActive = false
        }
    }
    
    @objc func checkBoxPressed(_ checkBox: CheckBox) {
        if checkBox.checked {
            checkBox.checked = false
        } else {
            checkBox.checked = true
        }
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
