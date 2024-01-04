//
//  PopupWindowView.swift
//  Autountant
//
//  Created by Sergey on 12/21/23.
//

import UIKit

class PopupInputWindowView: UIView {
    
    private var titleText: String?
    
    private lazy var backgroundOverlay: UIView = {
        let overlay = UIView()
        overlay.backgroundColor = UIColor.systemGray6.withAlphaComponent(0.95)
        return overlay
    }()
    
    internal lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1.0
        label.text = "Title label"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()
    
    internal var contentView: UIView = {
        let view = UIView()
//        view.layer.borderWidth = 1.0
//        view.layer.borderColor = UIColor.black.cgColor
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.setContentHuggingPriority(.required, for: .vertical)
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var controlsView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 20.0
        stack.addArrangedSubview(saveButton)
        stack.addArrangedSubview(cancelButton)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var saveButton: ControlButton = {
        let button = ControlButton()
        button.type = .save
        button.translatesAutoresizingMaskIntoConstraints = false
        
        //button.widthAnchor.constraint(greaterThanOrEqualTo: button.heightAnchor).isActive = true
        button.sizeToFit()
        button.addTarget(AnyObject.self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: ControlButton = {
        let button = ControlButton()
        button.type = .cancel
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(AnyObject.self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    internal func setup() {
        
        addSubview(titleLabel)
        addSubview(controlsView)
        
//        controlsView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 10.0).isActive = true
//        controlsView.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: -10.0).isActive = true
        
        controlsView.leadingAnchor.constraint(lessThanOrEqualTo: centerXAnchor, constant: -100.0).isActive = true
        controlsView.trailingAnchor.constraint(lessThanOrEqualTo: centerXAnchor, constant: 100.0).isActive = true
        controlsView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        controlsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: controlsView.centerXAnchor).isActive = true
        
        applyAppearance()
        applyBoundsConstraints()
        
    }
    
    internal func setTitle(title: String) {
        titleText = title
    }
    
    internal func insertContentView() {
        addSubview(contentView)
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        
        contentView.topAnchor.constraint(equalTo: topAnchor, constant: 20.0).isActive = true
        
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: controlsView.topAnchor, constant: -30.0).isActive = true
        
        //controller.view.updateConstraints()
    }
    
    private func applyAppearance() {
        backgroundColor = Settings.shared.popupWindowBackgroundColor
        layer.borderColor = Settings.shared.popupWindowBorderColor
        layer.borderWidth = Settings.shared.popupWindowBorderWidth
        layer.cornerRadius = Settings.shared.popupWindowCornerRadius
    }
    
    private func applyBoundsConstraints() {
        setContentHuggingPriority(.required, for: .horizontal)
        setContentHuggingPriority(.required, for: .vertical)
    }
    
    @objc func saveButtonPressed() {}
    @objc func cancelButtonPressed() {
        self.remove()
    }
    
    internal func show(on controler: UIViewController) {
        let controller = controler
        controller.view.addSubview(self)
        centerYAnchor.constraint(equalTo: controller.view.centerYAnchor).isActive = true
        centerXAnchor.constraint(equalTo: controller.view.centerXAnchor).isActive = true
        leadingAnchor.constraint(greaterThanOrEqualTo: controller.view.leadingAnchor, constant: 10.0).isActive = true
        topAnchor.constraint(greaterThanOrEqualTo: controller.view.safeAreaLayoutGuide.topAnchor, constant: 10.0).isActive = true
        backgroundOverlay.frame = controller.view.bounds
        controller.view.insertSubview(self.backgroundOverlay, belowSubview: self)
        
    }
    
    internal func remove() {
        self.removeFromSuperview()
        self.backgroundOverlay.removeFromSuperview()
    }
    
    
}

