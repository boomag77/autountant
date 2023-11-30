//
//  VehicleCellView.swift
//  Autountant
//
//  Created by Sergey on 11/27/23.
//

import UIKit

class VehicleCellView: UIView {
    
    var activeVehicle: Bool = false
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        //label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        //label.adjustsFontForContentSizeCategory = true
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mileageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        //label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        //label.adjustsFontForContentSizeCategory = true
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var selectedView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "checkmark")
        //imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func fillLabels(name: String, mileage: String) {
        nameLabel.text = name
        mileageLabel.text = mileage
    }
    
    private func configure() {
        
        addSubview(nameLabel)
        addSubview(mileageLabel)
        
        
        if activeVehicle {
            addSubview(selectedView)
            // selected ImageView constraints
            selectedView.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
            selectedView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0).isActive = true
            selectedView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0).isActive = true
            selectedView.widthAnchor.constraint(equalTo: selectedView.heightAnchor).isActive = true
            
            nameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: selectedView.leadingAnchor, constant: -10.0).isActive = true
            mileageLabel.trailingAnchor.constraint(greaterThanOrEqualTo: selectedView.leadingAnchor, constant: -10.0).isActive = true
        }
        
        // nameLabel constraints
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
        
        // mileageLabel constraints
        mileageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        mileageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0).isActive = true
        mileageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
        mileageLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
    }

}
