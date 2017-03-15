//
//  StoryTableViewCell.swift
//  TestWriter
//
//  Created by Simone on 3/15/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import UIKit

class StitchTableViewCell: UITableViewCell {
    
    var textField = UITextField()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "cell")
        
        contentView.backgroundColor = .white
        textField = UITextField(frame: self.frame)
        self.contentView.addSubview(textField)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
