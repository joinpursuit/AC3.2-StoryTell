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
    
    
    var standardMargin: Double = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.navy
        
        setupViewHierarchy()
        configureConstraints()
       navigationButtons()
        
    }
    
    // MARK: - Navigation Buttons
    func navigationButtons(){
        let publishButton = UIBarButtonItem(title: "Publish", style: UIBarButtonItemStyle.plain, target: self, action: #selector(UIWebView.goBack)) //Need to change action to show Publish Alert
        
        
        var outlineImage = UIImage(named: "outlinePage")
        
        outlineImage = outlineImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        let outlineButton = UIBarButtonItem(image: outlineImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(outlineTapped))
        
        
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(UIWebView.goBack)) //needs to be set up to go back a page
        
        var homeImage = UIImage(named: "homePage")
        
        homeImage = homeImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        let homeButton = UIBarButtonItem(image: homeImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(homeTapped))
        
        navigationItem.rightBarButtonItems = [publishButton, outlineButton]
        navigationItem.leftBarButtonItems = [backButton, homeButton]
        
    }
    
    
    // MARK: - Navigation Actions
    
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
        view.addSubview(authorLabel)
        view.addSubview(titleLabel)
        view.addSubview(beginWritingButton)
        
    }
    

    
    
    private func configureConstraints(){
        
        
        titleLabel.snp.makeConstraints { (title) in
            title.leading.equalToSuperview().offset(standardMargin)
            title.trailing.equalToSuperview().inset(standardMargin)
            title.top.equalToSuperview().offset(8)
            title.height.equalToSuperview().dividedBy(4)
            //author.centerX.equalToSuperview()
            
        }
        
        authorLabel.snp.makeConstraints { (author) in
            author.leading.equalToSuperview().offset(standardMargin)
            author.trailing.equalToSuperview().inset(standardMargin)
            author.top.equalTo(titleLabel.snp.bottom).offset(standardMargin)
            author.height.equalToSuperview().dividedBy(4)
        }
        
        
        
        beginWritingButton.snp.makeConstraints { (button) in
            button.top.equalTo(authorLabel.snp.bottom).offset(standardMargin)
            //button.leading.trailing.equalToSuperview()
            
            button.centerX.equalToSuperview()
            //button.top.equalTo(titleLabel.snp.bottom)
            // button.bottom.equalToSuperview().inset(20)
            
            button.height.equalTo(50)
            button.width.equalTo(200)
        }
        
    }
    
    // MARK: - Actions
    
    
    func createStoryAction(){
        let newViewController = StitchViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    // MARK: - Lazy Inits
    
    lazy var titleTextView: UITextView = {
        var textView: UITextView = UITextView()
        textView.isEditable = true
        textView.delegate = self
        textView.textColor = UIColor.lightGray
        textView.text = "Title"
        
        
        
       return textView
    }()
    
    
    lazy var authorLabel: UILabel = {
        let label: UILabel = UILabel()
        
        // label.font = UIFont.boldSystemFont(ofSize: 40)
        
        label.font = UIFont(name: "Cochin", size: 40)
        label.numberOfLines = 3
        label.minimumScaleFactor = 0.1
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textAlignment = .center
        //label.sizeToFit()
        label.textColor = Colors.navy
        
        return label
    }()
    
    
    
    lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        ///// Ideas to shrik text based on how much text... not working..yet
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.1
        
        label.font = UIFont(name: "Cochin-BoldItalic", size: 40)
        
        label.numberOfLines = 3
        label.textColor = Colors.navy
        
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        label.textAlignment = .center
        //label.sizeToFit()
        
        return label
    }()
    
    lazy var beginWritingButton: UIButton = {
        let button: UIButton = UIButton()
        button.backgroundColor = Colors.cream
        
        // button.alpha = 0.5
        
        button.layer.cornerRadius = 7.0
        let myAttribute = [NSForegroundColorAttributeName: Colors.cranberry]
        let myString = NSMutableAttributedString(string: "Begin Writing", attributes: myAttribute)
        var buttonRange = (myString.string as NSString).range(of: "Begin Writing")
        myString.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFont(ofSize: 20.0), range: buttonRange)
        
        button.setAttributedTitle(myString, for: .normal)
        
        button.addTarget(self, action: #selector(createStoryAction), for: .touchUpInside)
        
        return button
    }()
    
    
    lazy var ornament: UIImageView = {
        let imageView: UIImageView = UIImageView()
        
        
        return imageView
    }()
    
    
    
    
    
    
    
//    // MARK: - Setup
//    func setupViewHierarchy() {
//        self.edgesForExtendedLayout = []
//        self.view.addSubview(titleContainerView)
//        self.view.addSubview(authorContainerView)
//        titleContainerView.addSubview(titleTextField)
//        authorContainerView.addSubview(authorTextField)
//        self.view.addSubview(createStoryButton)
//    }
//
//    private func configureConstraints(){
//        titleContainerView.snp.makeConstraints { (container) in
//
//            container.trailing.equalToSuperview()
//            container.top.equalToSuperview().inset(20)
//            container.leading.equalToSuperview().inset(50)
//
//
//        }
//
//        titleTextField.snp.makeConstraints { (title) in
//            title.top.leading.trailing.bottom.equalTo(titleContainerView)
//        }
//
//        authorContainerView.snp.makeConstraints { (container) in
//            container.trailing.equalToSuperview()
//            container.leading.equalTo(50)
//            container.top.equalTo(titleContainerView.snp.bottom)
//        }
//
//        authorTextField.snp.makeConstraints { (author) in
//            author.top.leading.trailing.bottom.equalTo(authorContainerView)
//            author.height.equalTo(authorContainerView.snp.height)
//
//        }
//
//        createStoryButton.snp.makeConstraints { (button) in
//            button.top.equalTo(authorTextField.snp.bottom).offset(50)
//            button.centerX.equalToSuperview()
//        }
//
//    }
    
    // MARK: - Actions
    
    
    
    // MARK: - Lazy Instantiate
    
//    lazy var titleContainerView: UIView = {
//        let view: UIView = UIView()
//        return view
//    }()
//    
//    lazy var authorContainerView: UIView = {
//        let view: UIView = UIView()
//        
//        return view
//    }()
//    
//    lazy var titleTextField: UITextField = {
//        let textField: UITextField = UITextField()
//        textField.placeholder = "Title"
//        textField.font = UIFont(name: "Cochin-BoldItalic", size: 40)
//        
//        return textField
//    }()
//    
//    /*
//     let label: UILabel = UILabel()
//     ///// Ideas to shrik text based on how much text... not working..yet
//     label.adjustsFontSizeToFitWidth = true
//     label.minimumScaleFactor = 0.1
//     
//     label.font = UIFont(name: "Cochin-BoldItalic", size: 40)
//     
//     label.numberOfLines = 3
//     label.textColor = Colors.navy
//     
//     label.lineBreakMode = NSLineBreakMode.byTruncatingTail
//     label.textAlignment = .center
//     //label.sizeToFit()
// 
// */
//    
//    
//    lazy var authorTextField: UITextField = {
//        let textField: UITextField = UITextField()
//        textField.placeholder = "Author"
//        textField.font = UIFont(name: "Cochin", size: 40)
//        
//        return textField
//    }()
//    
//    lazy var createStoryButton: UIButton = {
//        let button: UIButton = UIButton()
//        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        button.backgroundColor = UIColor.green
//        button.setTitle("Create Story", for: .normal)
//        button.addTarget(self, action: #selector(createStoryAction), for: .touchUpInside)
//        
//        return button
//    }()
   
    
}

extension TitlePageViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
            print("I am writing a title NOW")
        }
    }
    
}

