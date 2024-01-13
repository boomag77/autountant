//
//  categoryLabelView.swift
//  Autountant
//
//  Created by Sergey on 1/12/24.
//

import UIKit

class TappableLabel: UIControl {
    
    var text: String?
    
    private var arrowsImage: UIImage = UIImage(systemName: "chevron.up.chevron.down")!
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        let image = UIImage(systemName: "chevron.up.chevron.down")
        view.image = image
        view.tintColor = .label
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.required, for: .horizontal)
        return view
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = self.text ?? "did not set!"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        layer.cornerRadius = 10.0
        layer.backgroundColor = UIColor.lightGray.cgColor
        addSubview(imageView)
        addSubview(textLabel)
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 5.0).isActive = true
        imageView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 5.0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5.0).isActive = true
        
        textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5.0).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5.0).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 10.0).isActive = true
    }
}
