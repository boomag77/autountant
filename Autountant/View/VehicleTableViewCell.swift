//
//  VehicleTableViewCell.swift
//  Autountant
//
//  Created by Sergey on 11/27/23.
//

import UIKit

class VehicleTableViewCell: UITableViewCell {
    
    var vehicle: Vehicle!
    
    lazy var cellView: VehicleCellView = {
        let view = VehicleCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUp() {
        
        cellView.name = vehicle.name
        cellView.mileage = String(vehicle.mileage)
        cellView.current = vehicle.current
        cellView.setUp()
        
        contentView.addSubview(cellView)
        
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }

}

