//
//  MainViewModel.swift
//  Autountant
//
//  Created by Sergey on 11/21/23.
//

import UIKit

class YellowView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

class GreenView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
