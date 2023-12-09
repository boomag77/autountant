//
//  VehicleCellView.swift
//  Autountant
//
//  Created by Sergey on 11/27/23.
//

import UIKit

class VehicleCellView: UIView {
    
    var current: Bool = false
    
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
        if let descriptor = UIFont.systemFont(ofSize: 14.0).fontDescriptor.withSymbolicTraits(.traitItalic) {
            label.font = UIFont(descriptor: descriptor, size: 14.0)
        } else {
            label.font = UIFont.systemFont(ofSize: 14.0)
        }
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var currentMark: UIImageView = {
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
    
    func setName(name: String) {
        nameLabel.text = name
    }
    
    func setMileage(mileage: String) {
        mileageLabel.text = "\(mileage) mi"
    }
    
    func configure() {
        
        addSubview(nameLabel)
        addSubview(mileageLabel)
        addSubview(currentMark)
        
        currentMark.isHidden = !current
        
        if current {
            nameLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        } else {
            nameLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        }
        
        // selected ImageView constraints
        currentMark.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        currentMark.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0).isActive = true
        currentMark.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0).isActive = true
        currentMark.widthAnchor.constraint(equalTo: currentMark.heightAnchor).isActive = true
        
        // nameLabel constraints
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: currentMark.leadingAnchor, constant: -10.0).isActive = true
        
        // mileageLabel constraints
        mileageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        mileageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0).isActive = true
        mileageLabel.trailingAnchor.constraint(greaterThanOrEqualTo: currentMark.leadingAnchor, constant: -10.0).isActive = true
        mileageLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
    }

}
