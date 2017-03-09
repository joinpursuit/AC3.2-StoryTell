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
        self.navigationItem.titleView = setTitle(title: "title", subtitle: "author")
        navigationController?.navigationBar.barTintColor = .white //this will probably be hex #efe9e7
        view.backgroundColor = .white
        
        let publishButton = UIBarButtonItem(title: "Publish", style: UIBarButtonItemStyle.plain, target: self, action: #selector(UIWebView.goBack)) //Need to change action to show Publish Alert
        
        let writeButton = UIBarButtonItem(title: "Write", style: UIBarButtonItemStyle.plain, target: self, action: #selector(UIWebView.goBack)) //Need to link to Write page
        
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(UIWebView.goBack)) //needs to be set up to go back a page
        
        let homeButton = UIBarButtonItem(title: "Home", style: UIBarButtonItemStyle.plain, target: self, action: #selector(homeTapped)) //needs to be linked up to Landing Page
        
        navigationItem.rightBarButtonItems = [writeButton, publishButton]
        navigationItem.leftBarButtonItems = [backButton, homeButton]
        
        
    }

    func homeTapped() {
    let newViewController = LandingPageViewController()
    self.navigationController?.pushViewController(newViewController, animated: true)
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
    //sets Title & Subtitle in Navigation Bar. From: https://gist.github.com/nazywamsiepawel/0166e8a71d74e96c7898
    func setTitle(title:String, subtitle:String) -> UIView {
        let titleLabel = UILabel(frame: CGRect(x:0, y:-5, width:0, height:0))
        
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor.gray
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.text = title
        titleLabel.sizeToFit()
        
        let subtitleLabel = UILabel(frame: CGRect(x:0, y:18, width:0, height:0))
        subtitleLabel.backgroundColor = UIColor.clear
        subtitleLabel.textColor = UIColor.black
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.text = subtitle
        subtitleLabel.sizeToFit()
        
        let titleView = UIView(frame: CGRect(x:0, y:0, width:max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), height:30))
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)
        
        let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width
        
        if widthDiff > 0 {
            var frame = titleLabel.frame
            frame.origin.x = widthDiff / 2
            titleLabel.frame = frame.integral
        } else {
            var frame = subtitleLabel.frame
            frame.origin.x = abs(widthDiff) / 2
            titleLabel.frame = frame.integral
        }
        
        return titleView
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
