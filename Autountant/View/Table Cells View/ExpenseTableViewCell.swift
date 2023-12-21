//
//  ExpenseCellView.swift
//  Autountant
//
//  Created by Sergey on 12/19/23.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {
    
    private let topMargin: CGFloat = 5.0
    private let bottomMargin: CGFloat = -5.0
    
    lazy var cellView: ExpenseCellView = {
        let view = ExpenseCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(date: String, category: String, amount: String) {
        
        cellView.dateLabel.text = date
        cellView.categoryLabel.text = category
        cellView.amountLabel.text = amount
        cellView.setup()
        contentView.addSubview(cellView)
        
        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topMargin).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: bottomMargin).isActive = true
        
    }

}
