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
        
        navigationItem.title = "Outline"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: Colors.navy,
             NSFontAttributeName: UIFont(name: "Cochin-BoldItalic", size: 21)!]
        navigationController?.navigationBar.barTintColor = Colors.cream
        navigationController?.navigationBar.tintColor = Colors.cranberry
        
        let publishButton = UIBarButtonItem(title: "Publish", style: UIBarButtonItemStyle.plain, target: self, action: #selector(UIWebView.goBack)) //Need to change action to show Publish Alert
        publishButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Cochin", size: 16)!], for: UIControlState.normal)
        var writeImage = UIImage(named: "writeEdit")
        
        writeImage = writeImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        let writeButton = UIBarButtonItem(image: writeImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(writeTapped))
        
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(backButtonTapped))
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
<<<<<<< HEAD
    func loadData() {


        story = Story.readStory()
        expandStitches()

=======
    func backButtonTapped() {
        let _ = self.navigationController?.popViewController(animated: true)
        
    }
    func loadData() {
        story = Story.readStory()
        expandStitches()
>>>>>>> 55ae5f197c65518caad12fdecef8eaf71306d29d
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
