//
//  LoginViewController.swift
//  StoryTell
//
//  Created by Maria on 3/13/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Story Tell"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: Colors.navy,
             NSFontAttributeName: UIFont(name: "Cochin-BoldItalic", size: 21)!]
        navigationController?.navigationBar.barTintColor = Colors.cream
        navigationController?.navigationBar.tintColor = Colors.cranberry
        
        view.backgroundColor = Colors.cream
    
        setupView()
        setupViewHierarchy()
        configureConstraints()
    }
    
    func setupView() {
        self.edgesForExtendedLayout = []
        
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "logo")
        view.addSubview(imageView)
        imageView.snp.makeConstraints({ (view) in
            view.centerX.equalTo(self.view)
            view.width.height.equalTo(150)
            view.top.equalToSuperview().offset(25)
        })

}
    
    func setupViewHierarchy() {
        self.edgesForExtendedLayout = []
        self.view.addSubview(emailContainerView)
        self.view.addSubview(passwordContainerView)
        self.view.addSubview(registerContainerView)
        self.view.addSubview(logInContainerView)
        
        
        emailContainerView.addSubview(emailTextField)
        passwordContainerView.addSubview(passwordTextField)
        registerContainerView.addSubview(registerButton)
        logInContainerView.addSubview(logInButton)
        
       
    }
    
    
    private func configureConstraints(){
        emailContainerView.snp.makeConstraints { (container) in
            
            container.trailing.equalToSuperview().inset(50)
            container.top.equalToSuperview().inset(195)
            container.leading.equalToSuperview().inset(50)
            container.height.equalTo(40)
            
            
            
        }
        
        emailTextField.snp.makeConstraints { (email) in
            email.top.leading.trailing.bottom.equalTo(emailContainerView)
        }
        
        passwordContainerView.snp.makeConstraints { (container) in
            
            container.trailing.equalToSuperview().inset(50)
            container.leading.equalTo(50)
            container.top.equalTo(emailContainerView.snp.bottom).inset(-20)
            container.height.equalTo(emailContainerView)
        }
        
        passwordTextField.snp.makeConstraints { (password) in
            password.top.leading.trailing.bottom.equalTo(passwordContainerView)
            password.height.equalTo(passwordContainerView.snp.height)
            
        }
        
        registerContainerView.snp.makeConstraints { (container) in
            
            container.trailing.equalToSuperview().inset(190)
            container.leading.equalToSuperview().inset(90)
            container.height.equalTo(30)
            container.top.equalTo(passwordContainerView).inset(55)
        }
        
        registerButton.snp.makeConstraints { (button) in
            button.top.leading.trailing.bottom.equalTo(registerContainerView)
            button.height.equalTo(registerContainerView.snp.height)
        }
        
        logInContainerView.snp.makeConstraints { (container) in
            
            container.trailing.equalToSuperview().inset(90)
            container.width.equalTo(registerContainerView)
            container.height.equalTo(30)
            container.top.equalTo(passwordContainerView).inset(55)
        }
        
        logInButton.snp.makeConstraints { (logButton) in
            logButton.top.leading.trailing.bottom.equalTo(logInContainerView)
            logButton.height.equalTo(logInContainerView.snp.height)
        }
        
    }
    
    lazy var emailContainerView: UIView = {
        let view: UIView = UIView()
        return view
    }()
    
    lazy var passwordContainerView: UIView = {
        let view: UIView = UIView()
        return view
    }()
    
    lazy var registerContainerView: UIView = {
        let view: UIView = UIView()
        return view
    }()
    
    lazy var logInContainerView: UIView = {
        let view: UIView = UIView()
        return view
    }()
    
    lazy var emailTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.placeholder = "  Email"
        textField.font = UIFont(name: "Cochin-BoldItalic", size: 20)
        textField.backgroundColor = UIColor.white
        textField.layer.cornerRadius = 8
        textField.textColor = Colors.navy
        
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.placeholder = "  Password"
        textField.font = UIFont(name: "Cochin-BoldItalic", size: 20)
        textField.backgroundColor = UIColor.white
        textField.layer.cornerRadius = 8
        textField.isSecureTextEntry = true
        textField.textColor = Colors.navy
        
        return textField
    }()
    
    lazy var registerButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.backgroundColor = Colors.cranberry
        button.setTitle("Register", for: .normal)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont(name: "Cochin", size: 20)//UIFont.boldSystemFont(ofSize: 16)
        button.layer.borderWidth = 1
        button.layer.borderColor = Colors.cranberry.cgColor
        let myAttribute = [NSForegroundColorAttributeName: Colors.cream]
        let myString = NSMutableAttributedString(string: "Register", attributes: myAttribute)
        var buttonRange = (myString.string as NSString).range(of: "Register")
        let appFontForButton = UIFont(name: "Cochin", size: 20)
        myString.addAttribute(NSFontAttributeName, value: appFontForButton!, range: buttonRange)
        
        button.setAttributedTitle(myString, for: .normal)
        
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
        return button
    }()
    
    lazy var logInButton: UIButton = {
        let logButton: UIButton = UIButton(type: .system)
        logButton.backgroundColor = Colors.cream
        logButton.setTitle("Log In", for: .normal)
        logButton.layer.cornerRadius = 6
        logButton.titleLabel?.font = UIFont(name: "Cochin", size: 20)
        logButton.layer.borderWidth = 1
        logButton.layer.borderColor = Colors.navy.cgColor
        let myAttribute = [NSForegroundColorAttributeName: Colors.navy]
        let myString = NSMutableAttributedString(string: "Log In", attributes: myAttribute)
        var buttonRange = (myString.string as NSString).range(of: "Log In")
        let appFontForButton = UIFont(name: "Cochin", size: 20)
        myString.addAttribute(NSFontAttributeName, value: appFontForButton!, range: buttonRange)
        
        logButton.setAttributedTitle(myString, for: .normal)

        logButton.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        
        return logButton
    }()
    
    
    
    
    func handleRegister() {
        guard let email = emailTextField.text,
            let password = passwordTextField.text
            else {
                return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password , completion: { (user: FIRUser?, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            guard let uid = user?.uid else {
                return
            }
            
            // successful authentification
            
            let ref = FIRDatabase.database().reference(fromURL: "https://storytell-4f7e7.firebaseio.com/")
            let usersReference = ref.child("users").child(uid)
            let values = ["email": email]
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print(err!)
                    return
                }
                
                let destination = LandingPageViewController()
                self.navigationController?.pushViewController(destination, animated: true)

                
            print("saved user succesfully in database")
        })
            
    })
}

    func logIn() {
        
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                            }
            catch {
                print(error)
            }
        }
        else if let email = emailTextField.text,
            let password = passwordTextField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
                if user != nil {
                    
                        let destination = LandingPageViewController()
                        self.navigationController?.pushViewController(destination, animated: true)
                
                }
                else {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }

    
    
}






