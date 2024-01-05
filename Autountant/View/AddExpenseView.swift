//
//  AddExpenseView.swift
//  Autountant
//
//  Created by Sergey on 12/20/23.
//

import UIKit

class AddExpenseView: PopupInputWindowView {
    
    var vehicle: Vehicle! {
        didSet {
            configure()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AddExpenseView {
    
    private func configure() {
        setTitle(title: "New expense for \(vehicle.name)")
        
        insertContentView()
        
    }
}
