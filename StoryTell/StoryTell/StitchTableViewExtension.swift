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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return prompts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // wrote just to satify
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StitchTableViewCell
        
        cell.textField.textColor = Colors.cranberry
        cell.textField.delegate = self
        cell.textField.tag = indexPath.row
        cell.textField.text = prompts[indexPath.row]
        
        cell.writeOptionButton.tag = indexPath.row
        let button = cell.writeOptionButton
        button.addTarget(self, action: #selector(refreshView(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //            let item = prompts[indexPath.row]
            //            confirmDelete(item: item)
            self.prompts.remove(at: indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.endUpdates()
            self.tableView.setEditing(false, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = StitchTableViewCell()
        if indexPath.section == 0 && indexPath.row == 0 {
            cell.textField.becomeFirstResponder()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

