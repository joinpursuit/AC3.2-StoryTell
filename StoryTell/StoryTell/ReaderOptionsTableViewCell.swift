//
//  ReaderOptionsTableViewCell.swift
//  StoryTell
//
//  Created by John Gabriel Breshears on 3/16/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import UIKit
import SnapKit

class ReaderOptionsTableViewCell: UITableViewCell {
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.white
        
        self.contentView.addSubview(nightModeSwitch)
        self.contentView.addSubview(nightLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nightModeSwitch.snp.makeConstraints { (nSwitch) in
            nSwitch.trailing.equalTo(contentView.snp.trailing)
            nSwitch.width.equalTo(100)
            nSwitch.height.equalTo(contentView.snp.height)
            nSwitch.top.equalTo(contentView.snp.top).offset(5)
        }
        
        nightLabel.snp.makeConstraints { (label) in
            label.leading.equalTo(contentView.snp.leading).inset(5)
            label.trailing.equalTo(nightModeSwitch.snp.leading)
            label.height.equalTo(contentView.snp.height)
        }
       
    }
    
    func nightModeAction() {
        print("pressed the night")
        
        if let status = UserDefaults.standard.object(forKey: "onOff") as? Bool {
            if status == true {
                // true == means night mode is on and is being turned off
                nightModeSwitch.setOn(false, animated: false)
                UserDefaults.standard.set(false, forKey: "onOff")
                
            } else {
                // false == nightmode is off and is being turned on
                UserDefaults.standard.set(true, forKey: "onOff")
                nightModeSwitch.setOn(true, animated: false)
            }
            
        } else {
            nightModeSwitch.setOn(true, animated: false)
            UserDefaults.standard.set(true, forKey: "onOff")
        }
    }
    
    
    
    
    lazy var nightModeSwitch: UISwitch = {
        let nightSwitch: UISwitch = UISwitch()
        
        nightSwitch.tintColor = UIColor.darkGray
        nightSwitch.onTintColor = UIColor.black
        nightSwitch.thumbTintColor = UIColor.gray
        //nightSwitch.backgroundColor = UIColor.yellow
        
         nightSwitch.setOn(false, animated: true)
        nightSwitch.addTarget(self, action: #selector(nightModeAction), for: .touchUpInside)
        
        
        return nightSwitch
    }()
    
    lazy var nightLabel: UILabel = {
        let label: UILabel = UILabel()
        
       return label
    }()
    
    
}


