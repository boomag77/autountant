//
//  PopupWindowView.swift
//  Autountant
//
//  Created by Sergey on 12/21/23.
//

import UIKit

class PopupInputWindowView: UIView {
    
    weak var controller: UIViewController!
    
    lazy var frameConstraints: [NSLayoutConstraint] = [
        centerYAnchor.constraint(equalTo: controller.view.centerYAnchor),
        centerXAnchor.constraint(equalTo: controller.view.centerXAnchor)
    ]

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
    
}
