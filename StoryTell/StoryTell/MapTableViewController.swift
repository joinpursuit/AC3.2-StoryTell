//
//  MapTableViewController.swift
//  StoryTell
//
//  Created by C4Q on 3/9/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import UIKit
import SnapKit

class MapTableViewController: UITableViewController {
    var story = [Story]()
    var stitches: [String:Any]?
    var linkPath = String()
    var branches = [String:Any]()
    var nextLine = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "stitchCell")
        loadData()
        progressStory(linkPath)
        
        
        
        
    }


    func loadData() {
        story = Story.readStory()!
        
        for item in story {
            let title = item.title
            let author = item.authorName
            let date = item.createdAt
            linkPath = item.linkPath
            //storyTextView.text = "\(title)\n\(author)\n\(date)\n\n"
            stitches = item.stitches
        }
    }
    
    func progressStory(_ key: String) {
        let stitchValue = stitches?[key]!
        guard let dict = stitchValue as? [String: Any] else { return }
        guard let contentArr = dict["content"] as? [Any] else { return }
        guard let excerpt = contentArr[0] as? String else { return }
        nextLine = excerpt
        for content in contentArr {
            if let newDict = content as? [String:Any] {
                var newOption = String()
                var newPath = String()
                for (dictKey, dictValue) in newDict {
                    if dictKey == "divert" {
                        branches.updateValue(dictValue, forKey: "next")
                    }
                    else if dictKey == "option" {
                        newOption = dictValue as! String
                    }
                    if dictKey == "linkPath" {
                        newPath = dictValue as! String
                    }
                    if newOption == "" && newPath == "" {
                        break
                    } else {
                        branches.updateValue(newPath, forKey: newOption)
                    }
                }
            }
        }
        print(branches)
        //updateViews(nextLine)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stitches?.keys.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stitchCell", for: indexPath)
        if let validStitches = stitches {
            cell.textLabel?.text = Array(validStitches.keys)[indexPath.row]
            
        }
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
