//
//  Checkbox.swift
//  Autountant
//
//  Created by Sergey on 1/18/24.
//

import UIKit

class Checkbox: UIControl {

    let checkedView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.image = UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .white
        return view
    }()
    
    var checkedViewInsets: UIEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) {
        didSet {
            layoutIfNeeded()
        }
    }
    
    var tapRadiusOffset: CGFloat = 10
    
    var isChecked: Bool = false {
        didSet {
            updateState()
        }
    }
    
    var checkedBackgroundColor: UIColor = .blue {
        didSet {
            backgroundColor = isChecked ? checkedBackgroundColor : uncheckedBackgroundColor
        }
    }
    var checkedBorderColor: UIColor = .blue {
        didSet {
            layer.borderColor = isChecked ? checkedBorderColor.cgColor : uncheckedBorderColor.cgColor
        }
    }
    
    var uncheckedBackgroundColor: UIColor = .white {
        didSet {
            backgroundColor = isChecked ? checkedBackgroundColor : uncheckedBackgroundColor
        }
    }
    var uncheckedBorderColor: UIColor = .black {
        didSet {
            layer.borderColor = isChecked ? checkedBorderColor.cgColor : uncheckedBorderColor.cgColor
        }
    }
    
    var checkedImage: UIImage? = UIImage(systemName: "checkmark") {
        didSet {
            checkedView.image = checkedImage?.withRenderingMode(.alwaysTemplate)
        }
    }
    var imageTint: UIColor? = .white {
        didSet {
            checkedView.tintColor = imageTint
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        checkedView.frame = CGRect(
            x: checkedViewInsets.left,
            y: checkedViewInsets.top,
            width: frame.width - checkedViewInsets.left - checkedViewInsets.right,
            height: frame.height - checkedViewInsets.top - checkedViewInsets.bottom
        )
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        sendActions(for: .valueChanged)
        isChecked.toggle()
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.inset(by: UIEdgeInsets(top: -tapRadiusOffset, left: -tapRadiusOffset, bottom: -tapRadiusOffset, right: -tapRadiusOffset)).contains(point)
    }
    
    private func setup() {
        backgroundColor = uncheckedBackgroundColor
        layer.borderColor = uncheckedBorderColor.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
        addSubview(checkedView)
    }
    
    private func updateState() {
        backgroundColor = isChecked ? checkedBackgroundColor:uncheckedBackgroundColor
        layer.borderColor = isChecked ? checkedBorderColor.cgColor:uncheckedBorderColor.cgColor
        checkedView.isHidden = !isChecked
    }
    
}
