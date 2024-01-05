//
//  cancelButton.swift
//  Autountant
//
//  Created by Sergey on 12/28/23.
//

import UIKit

enum ControlButtonType: String {
    
    case save = "checkmark"
    case cancel = "xmark"
}

class ControlButton: UIControl {
    
    var type: ControlButtonType! {
        didSet {
            setup()
        }
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: self.type.rawValue))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.withAlphaComponent(0.8).cgColor
        backgroundColor = .systemBackground
        tintColor = (type == .save ? .systemGreen:.label)
        addSubview(imageView)
        //imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        //imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.leadingAnchor.constraint(lessThanOrEqualTo: leadingAnchor, constant: 10.0).isActive = true
        imageView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -10.0).isActive = true
        
        layer.cornerRadius = imageView.frame.height
    }
    
}
