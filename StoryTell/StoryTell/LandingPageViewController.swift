//
//  LandingPageViewController.swift
//  StoryTell
//
//  Created by C4Q on 3/8/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseAuth

class LandingPageViewController: UIViewController {
    let stories = ["Read Me", "Some Lovely Fanfiction", "Slack: A Love Story", "Github: A Frustration Story", "C4Q: Sleep No More"]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.cream
        navigationItem.title = "Your Bookshelf"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: Colors.navy,
             NSFontAttributeName: UIFont(name: "Cochin-BoldItalic", size: 20)!]
        navigationController?.navigationBar.barTintColor = Colors.cream
        navigationController?.navigationBar.tintColor = Colors.cranberry
        setupView()
                
        var writeImage = UIImage(named: "writeEdit")
        
        writeImage = writeImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: writeImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(writeButtonPressed))
        
        let logOutButton = UIBarButtonItem(title: "Log Out", style: UIBarButtonItemStyle.plain, target: self, action: #selector(logOutButtonPressed))
        logOutButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Cochin", size: 16)!], for: UIControlState.normal)
        self.navigationItem.leftBarButtonItem = logOutButton

        self.landingPageTableview.backgroundColor = Colors.cream
        
        self.navigationItem.setHidesBackButton(true, animated:true);
    }
    
    func setupView() {
        self.edgesForExtendedLayout = []
        
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "logo")
        view.addSubview(imageView)
        imageView.snp.makeConstraints({ (view) in
            view.centerX.equalTo(self.view)
            view.width.height.equalTo(165)
            view.top.equalToSuperview().offset(18)
        })
        
        view.addSubview(landingPageTextWelcome)
        
        landingPageTextWelcome.snp.makeConstraints { (view) in
            view.top.equalTo(imageView.snp.bottom).offset(24)
            view.centerX.equalTo(self.view)
            view.width.equalToSuperview().multipliedBy(0.8)
            view.height.equalTo(15)
        }
        view.addSubview(landingPageTextStoryTell)
        
        landingPageTextStoryTell.snp.makeConstraints { (view) in
            view.top.equalTo(landingPageTextWelcome.snp.bottom)
            view.centerX.equalTo(self.view)
            view.width.equalToSuperview()
            view.height.equalTo(45)
        }
        view.addSubview(landingPageText)
        
        landingPageText.snp.makeConstraints { (view) in
            view.top.equalTo(landingPageTextStoryTell.snp.bottom).offset(12)
            view.centerX.equalTo(self.view)
            view.width.equalToSuperview().multipliedBy(0.8)
            view.height.equalTo(50)
        }
        view.addSubview(landingPageTableview)
        
        landingPageTableview.snp.makeConstraints { (view) in
            view.centerX.equalTo(self.view)
            view.width.equalTo(self.view)
            view.top.equalTo(350)
            view.height.equalTo(300)
        }
        
        
    }
    func writeButtonPressed() {
        let newViewController = TitlePageViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    func logOutButtonPressed() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch {
            print(error)
        }
        let vc = LoginViewController()
        self.present(vc, animated: true, completion: nil)
        return
    }
        //let newViewController = MARIA's LOGIN PAGE VC
        //self.navigationController?.pushViewController(newViewController, animated: true)
    internal lazy var landingPageTextWelcome: UILabel = {
        let landingPageText = UILabel()
        landingPageText.text = "Welcome to"
        landingPageText.numberOfLines = 0
        landingPageText.textAlignment = .center
        landingPageText.font = UIFont(name: "Cochin-Italic", size: 20)
        landingPageText.textColor = Colors.navy
        return landingPageText
    }()
    internal lazy var landingPageTextStoryTell: UILabel = {
        let landingPageText = UILabel()
        landingPageText.text = "Story Tell"
        landingPageText.numberOfLines = 0
        landingPageText.textAlignment = .center
        landingPageText.font = UIFont(name: "Cochin-Bold", size: 40)
        landingPageText.textColor = Colors.navy
        return landingPageText
    }()
    internal lazy var landingPageText: UILabel = {
        let landingPageText = UILabel()
        landingPageText.text = "Begin reading a story. Choose from your most recent stories below."
        landingPageText.numberOfLines = 0
        landingPageText.textAlignment = .center
        landingPageText.font = UIFont(name: "Cochin", size: 20)
        landingPageText.textColor = Colors.navy
        return landingPageText
    }()
    
    internal lazy var landingPageTableview: UITableView = {
        let landingPageTableview = UITableView()
        landingPageTableview.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        landingPageTableview.delegate = self
        landingPageTableview.dataSource = self
        return landingPageTableview
    }()
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

extension LandingPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = stories[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Cochin", size: 20)
        cell.textLabel?.textColor = Colors.cream
        cell.backgroundColor = Colors.navy
        cell.textLabel?.textAlignment = .center
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = ReaderTitlePageViewController()
        navigationController?.pushViewController(destination, animated: true)
    }
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = stories[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Cochin", size: 20)
        cell.textLabel?.textColor = Colors.cream
        cell.textLabel?.textAlignment = .center
        cell.contentView.backgroundColor = Colors.cranberry
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = stories[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Cochin", size: 20)
        cell.textLabel?.textColor = Colors.cream
        cell.textLabel?.textAlignment = .center
        cell.contentView.backgroundColor = .clear
        
    }
}
