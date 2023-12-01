//
//  VehicleCellView.swift
//  Autountant
//
//  Created by Sergey on 11/27/23.
//

import UIKit

class VehicleCellView: UIView {
    
    //var activeVehicle: Bool!
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mileageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var selectedView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "checkmark")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(name: String, mileage: String, current: Bool) {
        
        nameLabel.text = name
        mileageLabel.text = mileage
        
        addSubview(nameLabel)
        addSubview(mileageLabel)
        addSubview(selectedView)
        
        if current {
            selectedView.isHidden = false
        } else {
            selectedView.isHidden = true
        }
        
        selectedView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        selectedView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
        selectedView.widthAnchor.constraint(equalTo: selectedView.heightAnchor).isActive = true
        
        // nameLabel constraints
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: selectedView.leadingAnchor, constant: -10.0).isActive = true
        
        // mileageLabel constraints
        mileageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10.0).isActive = true
        mileageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0).isActive = true
        mileageLabel.trailingAnchor.constraint(equalTo: selectedView.leadingAnchor, constant: -10.0).isActive = true
        mileageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0).isActive = true
        
    }

}
