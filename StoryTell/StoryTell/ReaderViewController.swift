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
    var story: Story!
    var linkPath = String()
    var branches = [String:Any]()
    var content = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        story = Story.readStory()
        linkPath = story.linkPath
        view.addSubview(storyTextView)
        storyTextView.addSubview(buttonContainerView)
        constraints()
        storyTextView.text = "\(story.title)\nby: \(story.authorName)"
    }
    
<<<<<<< HEAD
=======
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
>>>>>>> de2d81bf19a6ef31459c079b28fa3fe53a07c395
    
    
    
    
    
    //populate table view
    //    func updateViews(_ text: String) {
    //        deleteView()
    //        storyTextView.text = text
    //        generateButton()
    //    }
    
    //populate table view
    //    func deleteView() {
    //        for view in buttonContainerView.subviews {
    //            view.removeFromSuperview()
    //        }
    //
    //    }
    
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
                        //       progressStory(optValue as! String)
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


