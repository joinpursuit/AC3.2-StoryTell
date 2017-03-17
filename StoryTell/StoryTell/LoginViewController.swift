//
//  LoginViewController.swift
//  StoryTell
//
//  Created by Maria on 3/13/17.
//  Copyright © 2017 Simone. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Story Tell"
        navigationController?.navigationBar.barTintColor = Colors.cream
        
        
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
        
        
        emailContainerView.addSubview(emailTextField)
        passwordContainerView.addSubview(passwordTextField)
        registerContainerView.addSubview(registerButton)
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
            
            container.trailing.equalToSuperview().inset(140)
            container.leading.equalToSuperview().inset(140)
            container.height.equalTo(30)
            container.top.equalTo(passwordContainerView).inset(55)
        }
        
        registerButton.snp.makeConstraints { (button) in
            button.top.leading.trailing.bottom.equalTo(registerContainerView)
            button.height.equalTo(registerContainerView.snp.height)
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
    
    lazy var emailTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.placeholder = "  Email"
        textField.font = UIFont(name: "Cochin-BoldItalic", size: 20)
        textField.backgroundColor = UIColor.white
        textField.layer.cornerRadius = 8
        
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField: UITextField = UITextField()
        textField.placeholder = "  Password"
        textField.font = UIFont(name: "Cochin-BoldItalic", size: 20)
        textField.backgroundColor = UIColor.white
        textField.layer.cornerRadius = 8
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    lazy var registerButton: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.backgroundColor = Colors.cream
        button.setTitle("Register", for: .normal)
        button.layer.cornerRadius = 6
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.init(red: 0/255, green: 122/255, blue: 255/255, alpha: 1).cgColor
        
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        
        return button
    }()
    
    func handleSignIn() {
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
                print("saved user succesfully in database")
            })
            
        })
    }
}










