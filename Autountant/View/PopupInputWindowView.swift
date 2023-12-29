//
//  PopupWindowView.swift
//  Autountant
//
//  Created by Sergey on 12/21/23.
//

import UIKit

class PopupInputWindowView: UIView {
    
    private lazy var backgroundOverlay: UIView = {
        let overlay = UIView()
        overlay.backgroundColor = UIColor.systemGray6.withAlphaComponent(0.95)
        return overlay
    }()
    
    internal var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var controlsView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        //view.addSubview(saveButton)
        view.addSubview(cancelButton)
        cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        cancelButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    internal var saveButton: ControlButton = {
        let button = ControlButton()
        button.type = .save
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(AnyObject.self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()
    
    internal var cancelButton: ControlButton = {
        let button = ControlButton()
        button.type = .cancel
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(AnyObject.self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        applyAppearance()
        applyBoundsConstraints()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        addSubview(contentView)
        
        
        contentView.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10.0).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
        
        
        
        
        
        
    }
    
    private func applyAppearance() {
        backgroundColor = Settings.shared.popupWindowBackgroundColor
        layer.borderColor = Settings.shared.popupWindowBorderColor
        layer.borderWidth = Settings.shared.popupWindowBorderWidth
        layer.cornerRadius = Settings.shared.popupWindowCornerRadius
    }
    
    private func applyBoundsConstraints() {
        setContentHuggingPriority(.required, for: .horizontal)
    }
    
    @objc func saveButtonPressed() {}
    @objc func cancelButtonPressed() {
        self.remove()
    }
    
    func show(on controler: UIViewController) {
        let controller = controler
        controller.view.addSubview(self)
        centerYAnchor.constraint(equalTo: controller.view.centerYAnchor).isActive = true
        centerXAnchor.constraint(equalTo: controller.view.centerXAnchor).isActive = true
        backgroundOverlay.frame = controller.view.bounds
        controller.view.insertSubview(self.backgroundOverlay, belowSubview: self)
        
    }
    
    func remove() {
        self.removeFromSuperview()
        self.backgroundOverlay.removeFromSuperview()
    }
    
    func showControls() {
        addSubview(controlsView)
        controlsView.topAnchor.constraint(equalTo: bottomAnchor, constant: 20.0).isActive =  true
        controlsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0).isActive = true
        controlsView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
}
