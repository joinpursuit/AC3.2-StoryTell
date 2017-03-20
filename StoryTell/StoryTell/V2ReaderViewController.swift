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
    
    var stackOfStoryKey: Stack = Stack<String>()
    
    var peekKey: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.cream
        story = Story.readStory()
        setupViewHierarchy()
        configureConstraints()
        currentStitchKey = story.linkPath
        stackOfStoryKey.push(currentStitchKey)
        progressStory(currentStitchKey)
        
        navigationItem.title = "Reader"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: Colors.navy,
             NSFontAttributeName: UIFont(name: "Cochin-BoldItalic", size: 21)!]
        navigationController?.navigationBar.barTintColor = Colors.cream
        navigationController?.navigationBar.tintColor = Colors.cranberry
        
        
        navigationItem.rightBarButtonItem = gearButton
        navigationItem.leftBarButtonItems = [backButton, homeButton]
        
        
        
    }
    
    
    func longTap(_ sender : UIGestureRecognizer){
        print("Long tap")
        
        if sender.state == .ended {
            print("UIGestureRecognizerStateEnded")
            //Do Whatever You want on End of Gesture
        }
        else if sender.state == .began {
            print("UIGestureRecognizerStateBegan.")
            peek(peekKey)
            
            //Do Whatever You want on Began of Gesture
        }
        
        
    }
    
    func peek(_ key: String){
        
        guard let shortedText = story.stitches[key]?.content else {return}
        
        
        let peekCharacters: [Character] = Array(shortedText.characters)
        var peekMessage:[Character] = []
        
        var count: Int = 0
        for character in peekCharacters {
            
            if count > 7 {
                break
            }
            
            if character == " "{
                count += 1
            }
            peekMessage.append(character)
            
        }
        
        let alertController = UIAlertController(title: "Peek", message: "\(String(peekMessage))...", preferredStyle: .alert)
        
        
        present(alertController, animated: true, completion: nil)
        
        //Change to 1.5 but for the app
        let timer = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: timer) {
            alertController.dismiss(animated: true, completion: nil)
            
        }
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        nightModeAction()
        
    }
    
    // MARK: - Navigation Actions
    func optionsAction(){
        if let navigation = navigationController {
            navigation.pushViewController(ReaderOptionsViewController(), animated: true)
            optionsTableView.reloadData()
        }
    }
    
    func homeTapped() {
        let newViewController = LandingPageViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func backButtonTapped() {
        
        
        if let previousKey = stackOfStoryKey.pop() {
            progressStory(previousKey)
        }
        
        if stackOfStoryKey.peek() == nil {
            backButton.isEnabled = false
        }
    }
    
    
    // MARK: - ThemesActions
    func nightModeAction() {
        
        if let status = UserDefaults.standard.object(forKey: "onOff") as? Bool {
            if status == true {
                // true == night mode
                self.readerTextView.textColor = UIColor.white
                self.readerTextView.backgroundColor = UIColor.black
                self.optionsTableView.backgroundColor = UIColor.black
                self.view.backgroundColor = UIColor.black
                
                optionsTableView.reloadData()
                
            } else {
                // false == normal UI
                self.view.backgroundColor = Colors.cream
                self.readerTextView.textColor = Colors.navy
                self.readerTextView.backgroundColor = Colors.cream
                self.optionsTableView.backgroundColor = Colors.cranberry
                optionsTableView.reloadData()
            }
            
            
        }
        else {
            // triggers when no value has been saved in onOff
            self.view.backgroundColor = Colors.cream
            self.readerTextView.textColor = UIColor.black
            self.readerTextView.backgroundColor = Colors.cream
            self.optionsTableView.backgroundColor = Colors.cranberry
            optionsTableView.reloadData()
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
        tableView.backgroundColor = Colors.cranberry
        tableView.separatorStyle = .none
        
        return tableView
        
    }()
    
    lazy var readerTextView: UITextView = {
        let textView: UITextView = UITextView()
        textView.textColor = Colors.navy
        textView.isEditable = false
        textView.font = UIFont(name: "Cochin", size: 24)
        textView.backgroundColor = Colors.cream
        
        
        return textView
    }()
    
    
    lazy var backButton: UIBarButtonItem = {
        let barButton: UIBarButtonItem = UIBarButtonItem()
        barButton.title = "Back"
        barButton.style = UIBarButtonItemStyle.plain
        barButton.target = self
        barButton.action = #selector(backButtonTapped)
        barButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Cochin", size: 16)!], for: UIControlState.normal)
        barButton.isEnabled = false
        
        return barButton
    }()
    
    lazy var homeButton: UIBarButtonItem = {
        let barButton: UIBarButtonItem = UIBarButtonItem()
        barButton.style = UIBarButtonItemStyle.plain
        barButton.target = self
        barButton.action = #selector(homeTapped)
        barButton.image = #imageLiteral(resourceName: "homePage")
        
        return barButton
    }()
    
    lazy var gearButton: UIBarButtonItem = {
        let barButton: UIBarButtonItem = UIBarButtonItem()
        barButton.style = UIBarButtonItemStyle.plain
        barButton.target = self
        barButton.action = #selector(optionsAction)
        barButton.image = #imageLiteral(resourceName: "gear")
        
        
        return barButton
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
        
        if let status = UserDefaults.standard.object(forKey: "onOff") as? Bool {
            if status == true {
                // true == night mode
                cell.textLabel?.font = UIFont(name: "Cochin", size: 20)
                cell.textLabel?.textColor = UIColor.white
                cell.textLabel?.backgroundColor = UIColor.black
                cell.backgroundColor = UIColor.black
                
                
            } else {
                // false == normal UI
                cell.textLabel?.font = UIFont(name: "Cochin", size: 20)
                cell.textLabel?.textColor = Colors.cream
                cell.textLabel?.backgroundColor = Colors.cranberry
                cell.backgroundColor = Colors.cranberry
            }
        }
        else {
            // triggers when no value has been saved in onOff
            cell.textLabel?.font = UIFont(name: "Cochin", size: 20)
            cell.textLabel?.textColor = Colors.cream
            cell.textLabel?.backgroundColor = Colors.cranberry
            cell.backgroundColor = Colors.cranberry
            
        }
        
        // Long Press
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longTap(_:)))
        
        cell.addGestureRecognizer(longGesture)
        
        
        
        let stitch = story.stitches[currentStitchKey]
        
        cell.textLabel?.text = stitch?.options[indexPath.row].prompt
        cell.textLabel?.textAlignment = .center
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let stitch = story.stitches[currentStitchKey]
        
        
        stackOfStoryKey.push(currentStitchKey)
        backButton.isEnabled = true
        //unwrapped safely later
        
        progressStory((stitch?.options[indexPath.row].link)!)
        
    }
    
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        let stitch = story.stitches[currentStitchKey]
        
        peekKey = stitch?.options[indexPath.row].link
        
    }
}

