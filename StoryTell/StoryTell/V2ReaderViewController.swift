//
//  V2ReaderViewController.swift
//  StoryTell
//
//  Created by John Gabriel Breshears on 3/9/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import UIKit

class V2ReaderViewController: UIViewController {
    
    var story: Story!
    var stitches: [String:Stitch]?
    var readerText: String = String()
    var currentStitchKey: String!
    
    let nightMode = UserDefaults.standard.set(false, forKey: "onOff")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cyan
        story = Story.readStory()
        setupViewHierarchy()
        configureConstraints()
        currentStitchKey = story.linkPath
        progressStory(currentStitchKey)
        
        navigationItem.title = "Reader"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: Colors.navy,
             NSFontAttributeName: UIFont(name: "Cochin-BoldItalic", size: 21)!]
        navigationController?.navigationBar.barTintColor = Colors.cream
        navigationController?.navigationBar.tintColor = Colors.cranberry
        
        var gearImage = UIImage(named: "gear")
        
        gearImage = gearImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        let gearButton = UIBarButtonItem(image: gearImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(optionsAction))
        
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(backButtonTapped))
        backButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Cochin", size: 16)!], for: UIControlState.normal)
        var homeImage = UIImage(named: "homePage")
        
        homeImage = homeImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        let homeButton = UIBarButtonItem(image: homeImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(homeTapped))
        navigationItem.rightBarButtonItem = gearButton
        navigationItem.leftBarButtonItems = [backButton, homeButton]
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        nightModeAction()
        
    }
    func optionsAction(){
        
        if let navigation = navigationController {
            navigation.pushViewController(ReaderOptionsViewController(), animated: true)
            
        }
    }
    func homeTapped() {
        let newViewController = LandingPageViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    func backButtonTapped() {
        let _ = self.navigationController?.popViewController(animated: true)
        
    }
    func nightModeAction() {
        
        if let status = UserDefaults.standard.object(forKey: "onOff") as? Bool {
            if status == true {
                
                self.readerTextView.textColor = UIColor.white
                self.readerTextView.backgroundColor = UIColor.black
                self.optionsTableView.backgroundColor = UIColor.black
                
            } else {
                
                self.readerTextView.textColor = UIColor.black
                self.readerTextView.backgroundColor = UIColor.white
                self.optionsTableView.backgroundColor = UIColor.white
            }
            
        }
    }
  
    
    
    // MARK: - Setup
    func setupViewHierarchy() {
        self.edgesForExtendedLayout = []
        view.addSubview(optionsTableView)
        view.addSubview(readerTextView)
        
    }
    
    private func configureConstraints(){
        
        readerTextView.snp.makeConstraints { (textView) in
            textView.leading.equalToSuperview().inset(8)
            textView.trailing.equalToSuperview().offset(-8)
            textView.top.equalToSuperview().offset(8)
            textView.bottom.equalTo(optionsTableView.snp.top).offset(-8)
            
        }
        
        optionsTableView.snp.makeConstraints { (tableView) in
            tableView.leading.trailing.equalToSuperview()
            tableView.bottom.equalToSuperview()
            tableView.centerX.equalToSuperview()
            tableView.height.equalToSuperview().dividedBy(4)
        }
        
    }
    
    
    func progressStory(_ key: String) {
        
        let stitchValue = story.stitches[key]
        
        readerText = (stitchValue?.content)!
        readerTextView.text = readerText
        currentStitchKey = key
        optionsTableView.reloadData()
        
        dump(currentStitchKey)
    }
    
    // MARK: - Lazy Inits
    
    lazy var optionsTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        return tableView
        
    }()
    
    lazy var readerTextView: UITextView = {
        let textView: UITextView = UITextView()
        textView.textColor = UIColor.black
        textView.isEditable = false
        textView.font = UIFont.boldSystemFont(ofSize: 30)
        
        
        return textView
    }()
    
    
}


// MARK: - TableView Delegate

extension V2ReaderViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let stitch = story.stitches[currentStitchKey]
        
        return (stitch?.options.count) ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        cell.textLabel?.textColor = UIColor.red
        
        let stitch = story.stitches[currentStitchKey]
        
        cell.textLabel?.text = stitch?.options[indexPath.row].prompt
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let stitch = story.stitches[currentStitchKey]
        
        //unwrapped safely later
        
        progressStory((stitch?.options[indexPath.row].link)!)
        
    }
}

