//
//  TitlePageViewController.swift
//  StoryTell
//
//  Created by John Gabriel Breshears on 3/8/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import UIKit
import SnapKit

class TitlePageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.cyan
        
        setupViewHierarchy()
        configureConstraints()
        let publishButton = UIBarButtonItem(title: "Publish", style: UIBarButtonItemStyle.plain, target: self, action: #selector(UIWebView.goBack)) //Need to change action to show Publish Alert
        
                
        var outlineImage = UIImage(named: "outlinePage")
        
        outlineImage = outlineImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        let outlineButton = UIBarButtonItem(image: outlineImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(outlineTapped))
        
        
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(UIWebView.goBack)) //needs to be set up to go back a page
        
        var homeImage = UIImage(named: "homePage")
        
        homeImage = homeImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        let homeButton = UIBarButtonItem(image: homeImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(homeTapped))
        
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: homeImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(homeTapped))
        
        navigationItem.rightBarButtonItems = [publishButton, outlineButton]
        navigationItem.leftBarButtonItems = [backButton, homeButton]
        
        
    }
    
    func homeTapped() {
        let newViewController = LandingPageViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    func writeTapped() {
        let newViewController = StitchViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    func outlineTapped() {
        let newViewController = MapTableViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    // MARK: - Setup
    func setupViewHierarchy() {
        self.edgesForExtendedLayout = []
        self.view.addSubview(titleContainerView)
        self.view.addSubview(authorContainerView)
        titleContainerView.addSubview(titleTextField)
        authorContainerView.addSubview(authorTextField)
        self.view.addSubview(createStoryButton)
    }
    
    private func configureConstraints(){
        titleContainerView.snp.makeConstraints { (container) in
            
            container.trailing.equalToSuperview()
            container.top.equalToSuperview().inset(20)
            container.leading.equalToSuperview().inset(50)
            
            
        }
        
        titleTextField.snp.makeConstraints { (title) in
            title.top.leading.trailing.bottom.equalTo(titleContainerView)
        }
        
        authorContainerView.snp.makeConstraints { (container) in
            container.trailing.equalToSuperview()
            container.leading.equalTo(50)
            container.top.equalTo(titleContainerView.snp.bottom)
        }
        
        authorTextField.snp.makeConstraints { (author) in
            author.top.leading.trailing.bottom.equalTo(authorContainerView)
            author.height.equalTo(authorContainerView.snp.height)
            
        }
        
        createStoryButton.snp.makeConstraints { (button) in
            button.top.equalTo(authorTextField.snp.bottom).offset(50)
            button.centerX.equalToSuperview()
        }
        
    }
    
    // MARK: - Actions
    
    func createStoryAction(){
        let newViewController = StitchViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
    // MARK: - Lazy Instantiate
    
    lazy var titleContainerView: UIView = {
        let view: UIView = UIView()
        return view
    }()
    
    lazy var authorContainerView: UIView = {
        let view: UIView = UIView()
        
        return view
    }()
    
    lazy var titleTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.placeholder = "Title"
        textField.font = UIFont.boldSystemFont(ofSize: 40.0)
        
        return textField
    }()
    
    lazy var authorTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.placeholder = "Author"
        textField.font = UIFont.boldSystemFont(ofSize: 40.0)
        
        return textField
    }()
    
    lazy var createStoryButton: UIButton = {
        let button: UIButton = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.backgroundColor = UIColor.green
        button.setTitle("Create Story", for: .normal)
        button.addTarget(self, action: #selector(createStoryAction), for: .touchUpInside)
        
        return button
    }()
   
    
}
