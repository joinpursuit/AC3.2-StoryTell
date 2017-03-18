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
    var options = [Option]()
    var tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.cream
        proseTextView.delegate = self
        setupViewHierarchy()
        configureConstraints()
        setupNavigation()
        addObservers()
        
        tableView.backgroundColor = Colors.cream
        
    }
    
    
    // MARK: - Setup
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

        
        let publishButton = UIBarButtonItem(title: "Publish", style: UIBarButtonItemStyle.plain, target: self, action: #selector(backButtonTapped)) //Need to change action to show Publish Alert
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
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(StitchViewController.updateTextView(notification:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(StitchViewController.updateTextView(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func setupViewHierarchy() {
        self.edgesForExtendedLayout = []
        self.view.addSubview(proseTextView)
        self.view.addSubview(tableView)
        self.view.addSubview(branchButton)
        self.view.addSubview(deleteButton)
        self.view.addSubview(doneWithTextViewButton)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StitchTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func configureConstraints(){
        doneWithTextViewButton.snp.makeConstraints { (done) in
            done.trailing.equalToSuperview().inset(10)
            done.bottom.equalTo(proseTextView.snp.top)
        }
        
        
        proseTextView.snp.makeConstraints { (textView) in
            textView.leading.trailing.equalToSuperview().inset(10)
            textView.top.equalToSuperview().offset(50)
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
            tableView.leading.trailing.equalToSuperview()
            tableView.bottom.equalToSuperview()
            tableView.centerX.equalToSuperview()
            tableView.height.equalToSuperview().dividedBy(3.75)
        }
        
    }
    
    //MARK: - Action
    
    func branchButtonAction(_ sender: UIButton) {
        let alertController = UIAlertController(title: "New Story Branch", message: "Enter the prompt text for your new story branch (for example: \"She took the path less travelled by.\")", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
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
        tableView.setEditing(true, animated: true)
    }
    
    func deleteAction(){
        print("All your base are belong to us....DELETE")
        
    }
    
    func doneAction(){
        proseTextView.resignFirstResponder()
        
        
        
    }
    
    // MARK: - Lazy Inits
    
    lazy var proseTextView: UITextView = {
        let textView: UITextView = UITextView()
        textView.textColor = UIColor.lightGray
        textView.text = "Once upon a time..."
        textView.font = UIFont(name: "Cochin", size: 30)
        textView.backgroundColor = Colors.cream
        
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
    
    lazy var doneWithTextViewButton: UIButton = {
        let button: UIButton = UIButton(type: .custom)

        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.layer.cornerRadius = 9
        button.clipsToBounds = true
        
        button.backgroundColor = Colors.cranberry
        button.setTitle("Done\nTyping", for: .normal)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(Colors.cream, for: .normal)
        button.titleLabel?.font = UIFont(name: "Cochin-Italic", size: 16)
        button.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)

        button.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
        
        
       return button
    }()
    
    
    
}





