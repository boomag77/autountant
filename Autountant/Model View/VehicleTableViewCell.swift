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
    
    private func setUp() {
        backgroundColor = .systemGray6
        contentView.addSubview(cellView)
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5.0).isActive = true
        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5.0).isActive = true
        
    }

}

