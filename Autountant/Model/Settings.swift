//
//  Settings.swift
//  Autountant
//
//  Created by Sergey on 12/13/23.
//

import Foundation
import UIKit

class Settings {
    
    static let shared = Settings()
    
    private var screenHeight: CGFloat
    private var screenWidth: CGFloat
    lazy var tableViewCellCornerRadius = screenHeight * 0.012
    
    public struct VehiclesVCSettings {
        let nameFont: UIFont = UIFont.preferredFont(forTextStyle: .subheadline)
        let nameActiveFont: UIFont = UIFont.preferredFont(forTextStyle: .headline)
        let mileageFont: UIFont = UIFont.preferredFont(forTextStyle: .footnote)
    }
    
    
    var vehicleTableViewCellMargin: CGFloat {
        return self.screenHeight * 0.005
    }
    
    private init() {
        self.screenHeight = UIScreen.main.bounds.height
        self.screenWidth = UIScreen.main.bounds.width
    }
    
    
}
