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
    
    func setupViewHierarchy() {
        self.edgesForExtendedLayout = []
        self.view.addSubview(proseTextView)
        self.view.addSubview(tableView)
        self.view.addSubview(branchButton)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StitchTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func configureConstraints(){
        proseTextView.snp.makeConstraints { (textView) in
            textView.leading.trailing.equalToSuperview()
            textView.top.equalToSuperview().offset(50)
            textView.height.equalToSuperview().dividedBy(2)
            
        }
        
        branchButton.snp.makeConstraints { (button) in
            button.top.equalTo(proseTextView.snp.bottom)
            button.leading.equalToSuperview().inset(20)
            
        }
        
        tableView.snp.makeConstraints { (tableView) in
            tableView.leading.trailing.equalToSuperview()
            tableView.bottom.equalToSuperview()
            tableView.centerX.equalToSuperview()
            tableView.height.equalToSuperview().dividedBy(3)
        }
        
    }
    
    //MARK: - Action
    
    func branchButtonAction(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Enter A Prompt", message: "Your prompt should be a choice for the user select", preferredStyle: .alert)
        
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
    
    
    // MARK: - Lazy Inits
    
    //    lazy var tableView: UITableView = {
    //        let tableView: UITableView = UITableView()
    //        //tableView.backgroundColor = UIColor.black
    //        return tableView
    //
    //    }()
    
    lazy var proseTextView: UITextView = {
        let textView: UITextView = UITextView()
        textView.textColor = UIColor.lightGray
        textView.text = "Begin writing"
        textView.font = UIFont(name: (textView.font?.fontName)!, size: 30)
        
        return textView
    }()
    
    lazy var branchButton: UIButton = {
        let button: UIButton = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.backgroundColor = UIColor.green
        button.setTitle("Create Branch", for: .normal)
        button.addTarget(self, action: #selector(branchButtonAction), for: .touchUpInside)
        
        
        return button
    }()
    
    
}





