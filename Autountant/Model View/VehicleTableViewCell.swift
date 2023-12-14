//
//  VehicleTableViewCell.swift
//  Autountant
//
//  Created by Sergey on 11/27/23.
//

import UIKit

class VehicleTableViewCell: UITableViewCell {
    
    lazy var cellView: VehicleCellView = {
        let view = VehicleCellView()
        
        return view
    }()
    
    private lazy var overlayCellMargin: UIView = {
        let view = UIView(frame: contentView.bounds)
        view.backgroundColor = .systemGray6
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    private func setUp() {
        //print(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
        backgroundColor = .systemRed
        contentView.addSubview(overlayCellMargin)
        contentView.addSubview(cellView)
        
        overlayCellMargin.translatesAutoresizingMaskIntoConstraints = false
        overlayCellMargin.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        overlayCellMargin.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        overlayCellMargin.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        overlayCellMargin.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.topAnchor.constraint(equalTo: overlayCellMargin.topAnchor,
                                      constant: Settings.shared.vehicleTableViewCellMargin).isActive = true
        cellView.leadingAnchor.constraint(equalTo: overlayCellMargin.leadingAnchor).isActive = true
        cellView.trailingAnchor.constraint(equalTo: overlayCellMargin.trailingAnchor).isActive = true
        cellView.bottomAnchor.constraint(equalTo: overlayCellMargin.bottomAnchor,
                                         constant: -(Settings.shared.vehicleTableViewCellMargin)).isActive = true
        
    }

}

