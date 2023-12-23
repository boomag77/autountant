//
//  PopupWindowView.swift
//  Autountant
//
//  Created by Sergey on 12/21/23.
//

import UIKit

class PopupInputWindowView: UIView {
    
    private weak var controller: UIViewController!
    
    private lazy var frameConstraints: [NSLayoutConstraint] = [
        centerYAnchor.constraint(equalTo: controller.view.centerYAnchor),
        centerXAnchor.constraint(equalTo: controller.view.centerXAnchor)
    ]
    
    private lazy var backgroundOverlay: UIView = {
        let overlay = UIView(frame: controller.view.bounds)
        overlay.backgroundColor = UIColor.systemGray6.withAlphaComponent(0.95)
        return overlay
    }()
    
    internal var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        
        var config = UIButton.Configuration.filled()
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .systemBlue
        config.cornerStyle = .capsule
        button.configuration = config
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        return button
    }()
    
    internal var cancelButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Close", for: .normal)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        applyAppearance()
        applyBoundsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        
        
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
    
    @objc func saveButtonPressed(_ button: UIButton) {}
    @objc func cancelButtonPressed(_ button: UIButton) {
        self.remove()
    }
    
    func show(on controler: UIViewController) {
        self.controller = controler
        controller.view.addSubview(self)
        NSLayoutConstraint.activate(frameConstraints)
        controller.view.insertSubview(self.backgroundOverlay, belowSubview: self)
        
    }
    
    func remove() {
        self.removeFromSuperview()
        self.backgroundOverlay.removeFromSuperview()
    }
    
}
