//
//  CheckBox.swift
//  Autountant
//
//  Created by Sergey on 11/22/23.
//

import UIKit

class CheckBox: UIControl {

    private weak var imageView: UIImageView!
    
    private var image: UIImage {
        return checked ? UIImage(systemName: "checkmark.square.fill")! :
                        UIImage(systemName: "square")!
    }
    
    public var checked: Bool = false {
        didSet {
            imageView.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive =  true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        imageView.image = self.image
        imageView.contentMode = .scaleAspectFill
        
        self.imageView = imageView
        
        backgroundColor = UIColor.clear
    }
}
