//
//  ReaderViewController.swift
//  StoryTell
//
//  Created by John Gabriel Breshears on 3/8/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import UIKit
import SnapKit

class ReaderViewController: UIViewController {
    var story = [Story]()
    var stitches: [String:Any]?
    var linkPath = String()
    var branches = [String:Any]()
    var nextLine = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(storyTextView)
        storyTextView.addSubview(buttonContainerView)
        constraints()
        loadInitialView()
        progressStory(linkPath)
        
        
    }
    
    func loadInitialView() {
        story = [Story.readStory()!]
        
        for item in story {
            let title = item.title
            let author = item.authorName
            let date = item.createdAt
            linkPath = item.linkPath
            storyTextView.text = "\(title)\n\(author)\n\(date)\n\n"
            stitches = item.stitches
        }
    }
    
    func progressStory(_ key: String) {
        let stitchValue = stitches?[key]!
        guard let dict = stitchValue as? [String: Any] else { return }
        guard let contentArr = dict["content"] as? [Any] else { return }
        guard let excerpt = contentArr[0] as? String else { return }
        nextLine = excerpt
        for content in contentArr {
            if let newDict = content as? [String:Any] {
                var newOption = String()
                var newPath = String()
                for (dictKey, dictValue) in newDict {
                    if dictKey == "divert" {
                        branches.updateValue(dictValue, forKey: "next")
                    }
                    else if dictKey == "option" {
                        newOption = dictValue as! String
                    }
                    if dictKey == "linkPath" {
                        newPath = dictValue as! String
                    }
                    if newOption == "" && newPath == "" {
                        break
                    } else {
                        branches.updateValue(newPath, forKey: newOption)
                    }
                }
            }
        }
        print(branches)
        updateViews(nextLine)
    }
    
    func updateViews(_ text: String) {
        deleteView()
        storyTextView.text = text
        generateButton()
    }
    
    func deleteView() {
        for view in buttonContainerView.subviews {
            view.removeFromSuperview()
        }
        
    }
    
    func generateButton() {
        var optionArr = [String]()
        for (opt, _) in branches {
            optionArr.append(opt)
        }
        var button: CGFloat = 20
        for opt in optionArr {
            let optButton = UIButton(frame: CGRect(x: 50, y: button + 300, width: 200, height: 30))
            button = button + 50
            
            optButton.layer.cornerRadius = 10
            optButton.backgroundColor = UIColor.gray
            optButton.setTitle("\(opt)", for: .normal)
            optButton.titleLabel?.text = "\(opt)"
            optButton.addTarget(self, action: #selector(optionSelected), for: .touchUpInside)
            
            self.buttonContainerView.addSubview(optButton)
            
        }
    }
    
    func optionSelected(_ sender: UIButton) {
        print("button pressed")
        if sender.titleLabel?.text != nil {
            if let selection = sender.titleLabel?.text {
                for (optKey, optValue) in branches {
                    if (optKey == selection) {
                        print("You chose: \(selection)")
                        branches.removeAll()
                        progressStory(optValue as! String)
                    }
                }
            } else {
                
                print("Do not recognize selection")
            }
        }
    }
    
    
    //constraints
    func constraints() {
        storyTextView.snp.makeConstraints { (view) in
            view.centerY.equalToSuperview()
            view.centerX.equalToSuperview()
            view.height.width.equalToSuperview()
        }
        buttonContainerView.snp.makeConstraints { (view) in
            view.centerY.equalTo(storyTextView)
            view.centerX.equalTo(storyTextView)
            view.height.width.equalTo(storyTextView).inset(50)
        }
    }
    
    //views
    var storyTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        return textView
    }()
    
    var buttonContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    
}


