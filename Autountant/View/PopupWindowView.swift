//
//  PopupWindowView.swift
//  Autountant
//
//  Created by Sergey on 12/21/23.
//

import UIKit

class PopupInputWindowView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        applyAppearance()
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
    
}
