//
//  ReaderTitlePageViewController.swift
//  StoryTell
//
//  Created by John Gabriel Breshears on 3/13/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import UIKit

class ReaderTitlePageViewController: UIViewController {
    
    var story: Story!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        
        loadTitlePageView()
        setupViewHierarchy()
        configureConstraints()
        
    }
    
    
    func loadTitlePageView() {
        story = Story.readStory()
        
        let title = story.title
        let author = story.authorName
        let date = story.createdAt
        
        authorLabel.text = author
        titleLabel.text = title
        
    }
    
    
    // MARK: - Setup
    func setupViewHierarchy() {
        self.edgesForExtendedLayout = []
        view.addSubview(authorLabel)
        view.addSubview(titleLabel)
        view.addSubview(beginStoryButton)
        
        
    }
    
    private func configureConstraints(){
        authorLabel.snp.makeConstraints { (author) in
            author.leading.equalToSuperview().offset(8)
            author.trailing.equalToSuperview()
            author.top.equalToSuperview()
            author.centerX.equalToSuperview()
            
        }
        
        titleLabel.snp.makeConstraints { (title) in
            title.leading.equalToSuperview().offset(8)
            title.trailing.equalToSuperview()
            title.top.equalTo(authorLabel.snp.bottom).offset(8)
        }
        
        beginStoryButton.snp.makeConstraints { (button) in
            button.leading.trailing.equalToSuperview()
            button.top.equalTo(titleLabel.snp.bottom)
            button.bottom.equalToSuperview()
        }
        
    }
    
    // MARK: - Actions
    
    func beginStoryAction() {
        print("Story is starting")
        self.navigationController?.pushViewController(V2ReaderViewController(), animated: true)
        // present(V2ReaderViewController(), animated: true, completion: nil)
        
    }
    
    // MARK: - Lazy Inits
    
    lazy var authorLabel: UILabel = {
        let label: UILabel = UILabel()
       // label.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        label.font = UIFont.boldSystemFont(ofSize: 60)
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        //label.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        label.font = UIFont.boldSystemFont(ofSize: 60)
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var beginStoryButton: UIButton = {
        let button: UIButton = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        button.backgroundColor = UIColor.green
        button.setTitle("Begin Reading", for: .normal)
        button.addTarget(self, action: #selector(beginStoryAction), for: .touchUpInside)
        
        return button
    }()
    
}
