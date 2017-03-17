//
//  StitchTableViewExtension.swift
//  StoryTell
//
//  Created by Simone on 3/16/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import UIKit

extension StitchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Options"
        default: return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return prompts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // wrote just to satify
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StitchTableViewCell
        cell.textField.delegate = self       
        cell.textField.text = prompts[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            prompts.remove(at: indexPath.row)
            
            self.tableView.reloadData()
        }
    }
    
    
}

