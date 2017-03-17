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

        view.backgroundColor = Colors.cream
        
        setupViewHierarchy()
        configureConstraints()
        
       navigationButtons()
        
    }
    
    // MARK: - Navigation Buttons
    func navigationButtons(){
        
        navigationItem.title = "New Story"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: Colors.navy,
             NSFontAttributeName: UIFont(name: "Cochin-BoldItalic", size: 18)!]
        navigationController?.navigationBar.barTintColor = Colors.cream
        navigationController?.navigationBar.tintColor = Colors.cranberry
        
        let publishButton = UIBarButtonItem(title: "Publish", style: UIBarButtonItemStyle.plain, target: self, action: #selector(UIWebView.goBack)) //Need to change action to show Publish Alert
        publishButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Cochin", size: 16)!], for: UIControlState.normal)
        
        var outlineImage = UIImage(named: "outlinePage")
        
        outlineImage = outlineImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        let outlineButton = UIBarButtonItem(image: outlineImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(outlineTapped))
        
        
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(backButtonTapped))
        backButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Cochin", size: 16)!], for: UIControlState.normal)
        
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

    func backButtonTapped() {
        let _ = self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Setup
    func setupViewHierarchy() {
        self.edgesForExtendedLayout = []
        view.addSubview(titleTextView)
        
        view.addSubview(beginWritingButton)
        
    }
    

    
    
    private func configureConstraints(){
        
        titleTextView.snp.makeConstraints { (title) in
            title.leading.equalToSuperview().offset(standardMargin)
            title.trailing.equalToSuperview().inset(standardMargin)
            title.top.equalToSuperview().offset(8)
            title.height.equalToSuperview().dividedBy(4)
        }
        
        
//        titleLabel.snp.makeConstraints { (title) in
//            title.leading.equalToSuperview().offset(standardMargin)
//            title.trailing.equalToSuperview().inset(standardMargin)
//            title.top.equalToSuperview().offset(8)
//            title.height.equalToSuperview().dividedBy(4)
//            //author.centerX.equalToSuperview()
//            
//        }
//        
//        authorLabel.snp.makeConstraints { (author) in
//            author.leading.equalToSuperview().offset(standardMargin)
//            author.trailing.equalToSuperview().inset(standardMargin)
//            author.top.equalTo(titleLabel.snp.bottom).offset(standardMargin)
//            author.height.equalToSuperview().dividedBy(4)
//        }
        
        
        
        beginWritingButton.snp.makeConstraints { (button) in
            button.top.equalTo(titleTextView.snp.bottom).offset(standardMargin)
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
        textView.adjustsFontForContentSizeCategory = true
    
        textView.font = UIFont(name: "Cochin-BoldItalic", size: 50)
        textView.backgroundColor = Colors.cream
        
       return textView
    }()
    
    lazy var authorTextView: UITextView = {
        var textView: UITextView = UITextView()
        textView.isEditable = true
        textView.delegate = self
        textView.textColor = UIColor.lightGray
        textView.text = "Title"
        textView.adjustsFontForContentSizeCategory = true
        textView.font = UIFont(name: "Cochin", size: 40)
        
        
        /*
 
         label.adjustsFontSizeToFitWidth = true
         label.minimumScaleFactor = 0.1
         
         label.font = UIFont(name: "Cochin-BoldItalic", size: 40)
         
         label.numberOfLines = 3
         label.textColor = Colors.navy
         
         label.lineBreakMode = NSLineBreakMode.byTruncatingTail
         label.textAlignment = .center
 
 */
        
        
        return textView
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
    

   
    
}

extension TitlePageViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
            print("I am writing a title NOW")
        }
    }
    
   
   // I don't know if this is the way but its the only way I could find. Instead of a new line it returns
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
}

