//
//  LandingPageViewController.swift
//  StoryTell
//
//  Created by C4Q on 3/8/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import UIKit
import SnapKit

class LandingPageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.cream
        navigationItem.title = "Your Bookshelf"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: Colors.navy,
             NSFontAttributeName: UIFont(name: "Cochin-BoldItalic", size: 20)!]
        navigationController?.navigationBar.barTintColor = Colors.cream
        navigationController?.navigationBar.tintColor = Colors.cranberry
        setupView()
        
        var writeImage = UIImage(named: "writeEdit")
        
        writeImage = writeImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: writeImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(writeButtonPressed))
        
        let logOutButton = UIBarButtonItem(title: "Log Out", style: UIBarButtonItemStyle.plain, target: self, action: #selector(logOutButtonPressed))
        logOutButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Cochin", size: 16)!], for: UIControlState.normal)
        self.navigationItem.leftBarButtonItem = logOutButton
        
        self.landingPageTableview.backgroundColor = Colors.cream
        
        
        }
    
    func setupView() {
        self.edgesForExtendedLayout = []
        
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "logo")
        view.addSubview(imageView)
        imageView.snp.makeConstraints({ (view) in
            view.centerX.equalTo(self.view)
            view.width.height.equalTo(150)
            view.top.equalToSuperview().offset(15)
        })
        
        view.addSubview(landingPageText)
        
        landingPageText.snp.makeConstraints { (view) in
            view.top.equalTo(imageView.snp.bottom).offset(15)
            view.centerX.equalTo(self.view)
            view.width.equalToSuperview().multipliedBy(0.8)
            view.height.equalTo(imageView.snp.height)
        }
        view.addSubview(landingPageTableview)
        
        landingPageTableview.snp.makeConstraints { (view) in
            view.centerX.equalTo(self.view)
            view.width.equalTo(self.view)
            view.top.equalTo(350)
            view.height.equalTo(300)
        }
        
    
    }
    func writeButtonPressed() {
        let newViewController = TitlePageViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    func logOutButtonPressed() {
        //let newViewController = MARIA's LOGIN PAGE VC
        //self.navigationController?.pushViewController(newViewController, animated: true)
    }
    internal lazy var landingPageText: UILabel = {
        let landingPageText = UILabel()
        landingPageText.text = "Welcome to Story Tell.\n\nBegin by reading a story (choose from your most recent stories below) or you can create a new story by pressing the Write button in the upper right-hand corner."
        landingPageText.numberOfLines = 0
        landingPageText.textAlignment = .center
        landingPageText.font = UIFont(name: "Cochin", size: 18)
        landingPageText.textColor = Colors.navy
        return landingPageText
    }()
    
    internal lazy var landingPageTableview: UITableView = {
        let landingPageTableview = UITableView()
        return landingPageTableview
    }()

    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
