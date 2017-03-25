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
    
    //let reuseableCellIdentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setupViewHierarchy()
        configureConstraints()
        
//        self.navigationItem.setHidesBackButton(true, animated:true)
    }
    
    // MARK: - Setup
    func setupViewHierarchy() {
        self.edgesForExtendedLayout = []
        view.addSubview(optionsTableView)
    }
    
    private func configureConstraints(){
        optionsTableView.snp.makeConstraints { (tableView) in
            tableView.leading.trailing.bottom.top.equalToSuperview()
        }
    }
    
 // MARK: - Lazy Inits
    
    lazy var optionsTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ReaderOptionsTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        return tableView
    }()
}

// MARK: - TableView Delegate/DataSource

extension ReaderOptionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ReaderOptionsTableViewCell
        
        
        if let status = UserDefaults.standard.object(forKey: "onOff") as? Bool {
            if status == true {
                
                cell.nightModeSwitch.isOn = true
            } else {
                cell.nightModeSwitch.isOn = false
            }
        }
        cell.nightLabel.text = "Night Mode"
        
        return cell
    }
    
}

