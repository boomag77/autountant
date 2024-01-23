//
//  NewExpenseViewController.swift
//  Autountant
//
//  Created by Sergey on 1/16/24.
//

import UIKit

class NewExpenseViewController: UIViewController {
    
    var activeVehicle: Vehicle? {
        didSet {
            titleLabel.text = "Add new expense for \(self.activeVehicle?.name ?? "na")"
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.contentMode = .center
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var checkBox: Checkbox = {
        let checkBox = Checkbox()
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        return checkBox
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    @objc private func closeController() {
        dismiss(animated: true)
    }
    

    private func setup() {
        //preferredContentSize = CGSize(width: 300, height: 400)
        view.layer.cornerRadius = 10.0
        view.backgroundColor = .white.withAlphaComponent(0.95)
//        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(closeController))
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(checkBox)
        NSLayoutConstraint.activate([
            checkBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkBox.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            checkBox.widthAnchor.constraint(equalToConstant: 50),
            checkBox.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}
