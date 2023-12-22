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

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        applyAppearance()
        applyBoundsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
