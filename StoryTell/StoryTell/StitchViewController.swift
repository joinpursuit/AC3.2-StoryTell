//
//  StitchViewController.swift
//  StoryTell
//
//  Created by John Gabriel Breshears on 3/9/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import UIKit



class StitchViewController: UIViewController {
    var prompts = [String]()
    var optionsArr = [Option]()
    let buildStory = BuildStory()
    var branchLine = String()
    var tag = Int()
    //var story: Story!
    
    //var readervc = V2ReaderViewController()
    var keyFromReader: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.cream
        proseTextView.delegate = self
        setupViewHierarchy()
        configureConstraints()
        setupNavigation()
        toolbar()
        
       // keyFromReader = readervc.currentStitchKey
        //proseTextView.text = story.stitches[keyFromReader]?.content
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //proseTextView.text = story.stitches[keyFromReader]?.content
    }
    
    
    // MARK: - Setup
    func setupViewHierarchy() {
        self.edgesForExtendedLayout = []
        self.view.addSubview(promptLabel)
        self.view.addSubview(proseTextView)
        self.view.addSubview(tableView)
        self.view.addSubview(branchButton)
        self.view.addSubview(deleteButton)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StitchTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func toolbar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let tb = UIToolbar()
        tb.sizeToFit()
        tb.setItems([flexSpace, doneButton], animated: false)
        proseTextView.inputAccessoryView = tb
        
    }
    
    func homeTapped() {
        let newViewController = LandingPageViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func outlineTapped() {
        let newViewController = MapTableViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func backButtonTapped() {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    func setupNavigation() {
        navigationItem.title = "Writer"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: Colors.navy,
             NSFontAttributeName: UIFont(name: "Cochin-BoldItalic", size: 18)!]
        navigationController?.navigationBar.barTintColor = Colors.cream
        navigationController?.navigationBar.tintColor = Colors.cranberry
        
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(backButtonTapped))
        
        backButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Cochin", size: 16)!], for: UIControlState.normal)
        
        
        let publishButton = UIBarButtonItem(title: "Publish", style: UIBarButtonItemStyle.plain, target: self, action: #selector(publishButtonTapped))
        publishButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Cochin", size: 16)!], for: UIControlState.normal)
        
        var outlineImage = UIImage(named: "outlinePage")
        
        outlineImage = outlineImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        let outlineButton = UIBarButtonItem(image: outlineImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(outlineTapped))
        
        var homeImage = UIImage(named: "homePage")
        
        homeImage = homeImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        let homeButton = UIBarButtonItem(image: homeImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(homeTapped))
        
        navigationItem.rightBarButtonItems = [publishButton, outlineButton]
        navigationItem.leftBarButtonItems = [backButton, homeButton]
        
    }
    
  
    
    //MARK: - Action
    
    func branchButtonAction(_ sender: UIButton) {
        tableView.setEditing(false, animated: true)
        let alertController = UIAlertController(title: "New Story Branch", message: "Enter the prompt text for your new story branch (example: \"She took the path less travelled by.\")", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Done", style: .default) { (_) in
            let branchField = alertController.textFields![0] as UITextField
            
            if branchField.text != "" {
                let branch = branchField.text!
                self.prompts.append(branch)
                print(self.prompts)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } else {
                let errorAlert = UIAlertController(title: "Error", message: "Please add a prompt", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                    alert -> Void in
                    self.present(alertController, animated: true, completion: nil)
                }))
                self.present(errorAlert, animated: true, completion: nil)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter your prompt"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func deleteBranch(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Delete Branch?", message: "This will erase the selected branch(es) and all their offshoots.", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            self.tableView.setEditing(true, animated: true)
            print("OK")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            (result : UIAlertAction) -> Void in
            print("Cancel")
        }
        
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)    }
    
    func doneAction(){
        proseTextView.resignFirstResponder()
    }
    
    func refreshView(_ sender: UIButton) {
        getStory()
        branchLine = prompts[tag]
        self.proseTextView.text = ""
//        self.proseTextView.setNeedsDisplay()
        promptLabel.isHidden = false
        promptLabel.text = ""
        self.prompts = []
        self.tableView.reloadData()
        
    }
    func publishButtonTapped() {
        let alertController = UIAlertController(title: "Coming Soon!", message: "You found a future feature. Soon Story Tell will allow you to publish and share your story with other Story Tell users.", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            print("OK")
        }
        
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)    }
    
    func getStory() {
        //in progress
        let content = proseTextView.text!
        let linkpath = buildStory.getLinkPath(input: content)
        let stitch = Stitch(content: content, options: optionsArr, key: linkpath)
    }
    
    //MARK: - Constraints
    
    private func configureConstraints(){
        promptLabel.snp.makeConstraints { (label) in
            label.top.equalToSuperview().offset(20)
            label.leading.equalToSuperview().offset(15)
            label.trailing.equalToSuperview().inset(15)
        }
        proseTextView.snp.makeConstraints { (textView) in
            textView.leading.equalToSuperview().offset(15)
            textView.trailing.equalToSuperview().inset(15)
            textView.top.equalTo(promptLabel.snp.bottom).offset(4)
            textView.height.equalToSuperview().dividedBy(2)
        }
        
        branchButton.snp.makeConstraints { (button) in
            button.top.equalTo(proseTextView.snp.bottom).offset(8)
            button.leading.equalToSuperview().inset(20)
            button.height.equalTo(50)
            button.width.equalTo(50)
            
        }
        
        deleteButton.snp.makeConstraints { (delete) in
            delete.top.equalTo(proseTextView.snp.bottom).offset(8)
            delete.trailing.equalToSuperview().inset(20)
            delete.height.equalTo(50)
            delete.width.equalTo(50)
        }
        
        tableView.snp.makeConstraints { (tableView) in
            tableView.leading.trailing.equalToSuperview().inset(20)
            tableView.bottom.equalToSuperview()
            tableView.centerX.equalToSuperview()
            tableView.height.equalToSuperview().dividedBy(3.75)
        }
        
    }
    
    // MARK: - Lazy Inits
    
    lazy var promptLabel: UITextField = {
        let label = UITextField()
        label.isUserInteractionEnabled = false
        label.isHidden = true
        label.textColor = UIColor.lightGray
        label.font = UIFont(name: "Cochin", size: 15)
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.backgroundColor = Colors.cream
        tableView.separatorStyle = .none
        return tableView
        
    }()
    
    lazy var proseTextView: UITextView = {
        let textView: UITextView = UITextView()
        textView.textColor = UIColor.lightGray
        //textView.text = "Once upon a time..."
        textView.font = UIFont(name: "Cochin", size: 25)
        textView.backgroundColor = Colors.cream
        textView.isHidden = false
        
        return textView
    }()
    
    lazy var branchButton: UIButton = {
        let button: UIButton = UIButton(type: .custom)
        var branchImage = UIImage(named: "branchYes")
        
        branchImage = branchImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        button.setBackgroundImage(branchImage, for: .normal)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.setTitle("Add\nBranch", for: .normal)
        button.setTitleColor(Colors.navy, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "Cochin", size: 14)
        button.titleEdgeInsets.bottom = -35
        button.showsTouchWhenHighlighted = true
        button.contentVerticalAlignment = UIControlContentVerticalAlignment.bottom
        
        
        button.addTarget(self, action: #selector(branchButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    
    lazy var deleteButton: UIButton = {
        let button: UIButton = UIButton(type: .custom)
        var branchImage = UIImage(named: "branchNo")
        branchImage = branchImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        button.setBackgroundImage(branchImage, for: .normal)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.setTitle("Remove\nBranch", for: .normal)
        button.setTitleColor(Colors.cranberry, for: .normal)
        button.titleLabel?.font = UIFont(name: "Cochin", size: 14)
        button.titleEdgeInsets.bottom = -35
        button.showsTouchWhenHighlighted = true
        button.contentVerticalAlignment = UIControlContentVerticalAlignment.bottom
        button.addTarget(self, action: #selector(deleteBranch), for: .touchUpInside)
        
        return button
    }()
}
