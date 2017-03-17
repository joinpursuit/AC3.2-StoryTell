//
//  Created by John Gabriel Breshears on 3/13/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import UIKit

class ReaderTitlePageViewController: UIViewController {
    
    var story: Story!
    var standardMargin: Double = 8
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.cream
        
        loadTitlePageView()
        setupViewHierarchy()
        configureConstraints()
        
        
       
    }
    
    func loadTitlePageView() {
        story = Story.readStory()
        
        let title = story.title
        let author = story.authorName
        //let date = story.createdAt
        
        authorLabel.text = author
        titleLabel.text = title
        
    }
    
    func presentReaderTouch(_ sender: UITapGestureRecognizer){

        
        present(V2ReaderViewController(), animated: true, completion: nil)
        

    }
    
    
    // MARK: - Setup
    func setupViewHierarchy() {
        self.edgesForExtendedLayout = []
        view.addSubview(authorLabel)
        view.addSubview(titleLabel)
        view.addSubview(beginStoryButton)
        
    }
    
    // constraints need to be fixed... The height needs to adjust based on the text.
    
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
        
        
        
        beginStoryButton.snp.makeConstraints { (button) in
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
    
    func beginStoryAction() {
        print("Story is starting")
        //self.navigationController?.pushViewController(V2ReaderViewController(), animated: true)

         present(UINavigationController(rootViewController: V2ReaderViewController()), animated: true, completion: nil)

        
    }
    
    // MARK: - Lazy Inits
    
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
    
    lazy var beginStoryButton: UIButton = {
        let button: UIButton = UIButton()
        button.backgroundColor = Colors.cranberry

       // button.alpha = 0.5

        button.layer.cornerRadius = 7.0
        let myAttribute = [NSForegroundColorAttributeName: Colors.cream]
        let myString = NSMutableAttributedString(string: "Begin Reading", attributes: myAttribute)
        var buttonRange = (myString.string as NSString).range(of: "Begin Reading")
        myString.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFont(ofSize: 20.0), range: buttonRange)
        
        button.setAttributedTitle(myString, for: .normal)

        button.addTarget(self, action: #selector(beginStoryAction), for: .touchUpInside)
        
        return button
    }()
    
    
    lazy var ornament: UIImageView = {
        let imageView: UIImageView = UIImageView()
        

        return imageView
    }()
    
    

    
}
