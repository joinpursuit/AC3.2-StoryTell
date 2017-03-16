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
    
    var on: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        
        setupViewHierarchy()
        configureConstraints()
        
        
    }
    
    func nightAction() {
       print("pressed the night")
        
        
        if let status = UserDefaults.standard.object(forKey: "onOff") as? Bool {
            if status == true {
                UserDefaults.standard.set(false, forKey: "onOff")
    
            } else {
            UserDefaults.standard.set(true, forKey: "onOff")
        }
        
    }
    }
    
    
    // MARK: - Setup
    func setupViewHierarchy() {
        self.edgesForExtendedLayout = []
        view.addSubview(nightModeButton)
        

        
        
        
    }
    
    private func configureConstraints(){
        
        nightModeButton.snp.makeConstraints { (button) in
            button.leading.trailing.top.bottom.equalToSuperview()
        }
        
    }
    
    
    
    
    lazy var nightModeButton: UIButton = {
        let button: UIButton = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        button.backgroundColor = UIColor.green
        button.setTitle("I am the Darkness", for: .normal)
        button.addTarget(self, action: #selector(nightAction), for: .touchUpInside)
        
        return button
    }()
    
    
    
}
