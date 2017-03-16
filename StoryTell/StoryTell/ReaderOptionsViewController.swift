//
//  ReaderOptionsViewController.swift
//  StoryTell
//
//  Created by John Gabriel Breshears on 3/16/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import UIKit
import SnapKit

class ReaderOptionsViewController: UIViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        
        setupViewHierarchy()
        configureConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let status = UserDefaults.standard.object(forKey: "onOff") as? Bool {
            if status == true {
                nightModeSwitch.isOn = true
                
            } else {
                
                nightModeSwitch.isOn = false
            }
            
        } else {
            nightModeSwitch.isOn = false
            
        }
    }
    
    
    func nightAction() {
        print("pressed the night")
        
        
        if let status = UserDefaults.standard.object(forKey: "onOff") as? Bool {
            if status == true {
                nightModeSwitch.setOn(false, animated: false)
                UserDefaults.standard.set(false, forKey: "onOff")
                
            } else {
                UserDefaults.standard.set(true, forKey: "onOff")
                nightModeSwitch.setOn(true, animated: false)
            }
            
        } else {
            nightModeSwitch.setOn(true, animated: false)
            UserDefaults.standard.set(true, forKey: "onOff")
        }
    }
    
    
    // MARK: - Setup
    func setupViewHierarchy() {
        self.edgesForExtendedLayout = []
        
        view.addSubview(nightModeSwitch)
    
        
    }
    
    private func configureConstraints(){
        
        nightModeSwitch.snp.makeConstraints { (aSwitch) in
            
            aSwitch.leading.trailing.equalToSuperview()
            aSwitch.height.width.equalTo(100)
            aSwitch.centerX.equalToSuperview()
        }
        
    }
    
    
    
    lazy var nightModeSwitch: UISwitch = {
        let nightSwitch: UISwitch = UISwitch()
        
        nightSwitch.tintColor = UIColor.blue
        nightSwitch.onTintColor = UIColor.cyan
        nightSwitch.thumbTintColor = UIColor.red
        nightSwitch.backgroundColor = UIColor.yellow
        
        // nightSwitch.setOn(false, animated: true)
        nightSwitch.addTarget(self, action: #selector(nightAction), for: .touchUpInside)
        
        
        return nightSwitch
    }()
    

}
