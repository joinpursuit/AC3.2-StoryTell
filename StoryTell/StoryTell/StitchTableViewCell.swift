//
//  StoryTableViewCell.swift
//  TestWriter
//
//  Created by Simone on 3/15/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import UIKit

class StitchTableViewCell: UITableViewCell {
    
    var textField: UITextField! {
        didSet {
            textField = UITextField()
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "cell")

        contentView.backgroundColor = Colors.cream
        textField = UITextField(frame: self.frame)
        textField.font = UIFont(name: "Cochin", size: 20)
        self.contentView.addSubview(textField)
        
        self.contentView.addSubview(writeOptionButton)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Constraints
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textField.snp.makeConstraints { (textField) in
            textField.leading.equalTo(contentView.snp.leading).inset(15)
            textField.centerY.equalTo(contentView.snp.centerY)
            textField.trailing.equalTo(contentView.snp.trailing).inset(35)
            //textField.bottom.equalTo(contentView.snp.bottom)
        }
        // button needs to show change when clicked 
        writeOptionButton.snp.makeConstraints { (button) in
            button.trailing.equalTo(contentView.snp.trailing).inset(15)
            button.centerY.equalTo(contentView.snp.centerY)
           // button.bottom.equalTo(contentView.snp.bottom).inset(5)
            
            button.height.width.equalTo(20)
        }
    }
    
    // MARK: - Actions
//    func writeOptionAction(_ sender: UIButton){
//        let vc = StitchViewController()
//        
//    }
    
    
    // MARK: - Lazy Inits
    
    lazy var writeOptionButton: UIButton = {
        let button: UIButton = UIButton()
        
        button.setImage(#imageLiteral(resourceName: "writerArrow"), for: .normal)
        button.addTarget(self, action: #selector(StitchViewController.refreshView), for: .touchUpInside)
        
        return button
    }()
    
    
    
}
