//
//  VehicleCellView.swift
//  Autountant
//
//  Created by Sergey on 11/27/23.
//

import UIKit

class VehicleCellView: UIView {
    
    //var current: Bool = false
    
    weak var vehicle: Vehicle! {
        didSet {
            self.configure()
        }
    }
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black.withAlphaComponent(0.8)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var mileageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .lightGray
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        return label
    }()
    
    private lazy var currentMark: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.image = UIImage(systemName: "checkmark")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure() {
        
        
        nameLabel.text = vehicle.name
        mileageLabel.text = "\(String(vehicle.mileage)) \(vehicle.units == "imperial" ? "mi":"km")"
        
        addSubview(nameLabel)
        addSubview(mileageLabel)
        addSubview(currentMark)
        
        currentMark.isHidden = !vehicle.active
        
        if vehicle.active {
            nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
            layer.borderWidth = 2
        } else {
            nameLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
            layer.borderWidth = 1
        }
        
        backgroundColor = .white
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = Settings.shared.tableViewCellCornerRadius
        
        // selected ImageView constraints
        currentMark.translatesAutoresizingMaskIntoConstraints = false
        currentMark.topAnchor.constraint(equalTo: topAnchor, constant: 20.0).isActive = true
        currentMark.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0).isActive = true
        currentMark.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20.0).isActive = true
        //currentMark.widthAnchor.constraint(equalTo: currentMark.heightAnchor, multiplier: 1.0).isActive = true
        
        // nameLabel constraints
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: currentMark.leadingAnchor, constant: -10.0).isActive = true
        
        // mileageLabel constraints
        mileageLabel.translatesAutoresizingMaskIntoConstraints = false
        mileageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        mileageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0).isActive = true
        mileageLabel.trailingAnchor.constraint(equalTo: currentMark.leadingAnchor, constant: -10.0).isActive = true
        mileageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0).isActive = true
        
    }

}
