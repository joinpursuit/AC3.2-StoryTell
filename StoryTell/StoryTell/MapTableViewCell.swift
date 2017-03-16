//
//  MapTableViewCell.swift
//  StoryTell
//
//  Created by C4Q on 3/16/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import UIKit

class MapTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewHierarchy()
        setupConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupViewHierarchy() {
        self.contentView.addSubview(cellLabel)
        
    }
    func setupConstraints() {
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        cellLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        cellLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        cellLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }
    
    internal lazy var cellLabel: UILabel = {
        let cellLabel = UILabel()
        cellLabel.numberOfLines = 0
        return cellLabel
    }()
}
