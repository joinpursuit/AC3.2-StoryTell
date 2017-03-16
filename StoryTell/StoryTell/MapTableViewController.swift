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
    var story: Story!
    var expandedStitches: [Any] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = Colors.cream
        tableView.register(MapTableViewCell.self, forCellReuseIdentifier: "stitchCell")
        loadData()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        
        self.navigationItem.titleView = setTitle(title: "Outline", subtitle: story.authorName)
        navigationController?.navigationBar.barTintColor = Colors.cream
        
        let publishButton = UIBarButtonItem(title: "Publish", style: UIBarButtonItemStyle.plain, target: self, action: #selector(UIWebView.goBack)) //Need to change action to show Publish Alert
        publishButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Cochin", size: 16)!], for: UIControlState.normal)
        var writeImage = UIImage(named: "writeEdit")
        
        writeImage = writeImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        let writeButton = UIBarButtonItem(image: writeImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(writeTapped)) //Need to link to Write page
        
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(backButtonTapped)) //needs to be set up to go back a page
        backButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Cochin", size: 16)!], for: UIControlState.normal)
        var homeImage = UIImage(named: "homePage")
        
        homeImage = homeImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        let homeButton = UIBarButtonItem(image: homeImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(homeTapped))
        
        navigationItem.rightBarButtonItems = [publishButton, writeButton]
        navigationItem.leftBarButtonItems = [backButton, homeButton]
        
        
        
        
    }
    func expandStitches() {
        for (_, stitch) in story.stitches {
            expandedStitches.append(stitch)
            for o in stitch.options {
                expandedStitches.append(o)
            }
        }
    }
    func homeTapped() {
    let newViewController = LandingPageViewController()
    self.navigationController?.pushViewController(newViewController, animated: true)
    }
    func writeTapped() {
        let newViewController = StitchViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
        
    }
    func loadData() {
        story = Story.readStory()
        expandStitches()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expandedStitches.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stitchCell", for: indexPath) as! MapTableViewCell
        if let stitch = expandedStitches[indexPath.row] as? Stitch {
            cell.cellLabel.text = stitch.content
            cell.cellLabel.font = UIFont(name: "Cochin", size: 17)
            cell.cellLabel.textColor = Colors.navy
            cell.cellLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.cellLabel.numberOfLines = 0
        }
        else if let option = expandedStitches[indexPath.row] as? Option {
            cell.cellLabel.text = "\t\(option.prompt)"
            cell.cellLabel.font = UIFont(name: "Cochin-Italic", size: 18)
            cell.cellLabel.textColor = Colors.cranberry
            cell.cellLabel.numberOfLines = 0
        }
        
        return cell
    }
    //sets Title & Subtitle in Navigation Bar. From: https://gist.github.com/nazywamsiepawel/0166e8a71d74e96c7898
    func setTitle(title:String, subtitle:String) -> UIView {
        let titleLabel = UILabel(frame: CGRect(x:0, y:-5, width:0, height:0))
        
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = Colors.navy
        titleLabel.font = UIFont(name: "Cochin-BoldItalic", size: 16)
        titleLabel.text = title
        titleLabel.sizeToFit()
        
        let subtitleLabel = UILabel(frame: CGRect(x:0, y:18, width:0, height:0))
        subtitleLabel.backgroundColor = UIColor.clear
        subtitleLabel.textColor = Colors.navy
        subtitleLabel.font = UIFont(name: "Cochin", size: 14)
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

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
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
