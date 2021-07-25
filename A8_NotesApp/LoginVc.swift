//
//  LoginVc.swift
//  A8_NotesApp
//
//  Created by Dipak on 03/05/1943 Saka.
//

import UIKit

class LoginVc: UIViewController
{
//    Email Label
        private let lbEmail:UILabel = {
            let lb=UILabel()
            lb.text="Enter User name"
            lb.backgroundColor = .clear
            lb.textColor = .black
            lb.textAlignment = .left
            return lb
        }()
        
    //    Email textfield
        private let emailId:UITextField = {
            let mytext = UITextField()
    //        mytext.placeholder = "EmailId"
            mytext.textAlignment = .center
            mytext.textColor = .black
            mytext.backgroundColor = .lightGray
            mytext.autocapitalizationType = .none
            mytext.layer.cornerRadius = 15
            return mytext
        }()
        
    //    Password Label
        private let lbPswd:UILabel = {
            let lb=UILabel()
            lb.text="Password"
            lb.backgroundColor = .clear
            lb.textColor = .black
            lb.textAlignment = .left
            return lb
        }()
        
    //    Password textfield
        private let pswd:UITextField = {
            let mytext = UITextField()
            
    //        mytext.placeholder = " name"
            mytext.textAlignment = .center
            mytext.textColor = .black
            mytext.backgroundColor = .lightGray
            mytext.layer.cornerRadius = 15
            return mytext
        }()
        
    //    Login Button
        private let Login:UIButton = {
            let btn = UIButton()
            btn.setTitle("Login", for: .normal)
            btn.addTarget(self, action: #selector(btnloginfunc), for: .touchUpInside)
            btn.backgroundColor = .systemBlue
            btn.layer.cornerRadius = 10
            return btn
        }()
        @objc func btnloginfunc() {
            if emailId.text == "admin" && pswd.text == "****"
            {
                print("login clicked")
                UserDefaults.standard.setValue("Rsdhm23615044", forKey: "SessionToken")
                UserDefaults.standard.setValue(emailId.text, forKey: "username")
//
//                navigationController?.pushViewController(ViewController(), animated: true)
//                let alert = UIAlertController(title: "Welcome Sir ..", message: emailId.text, preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
//                DispatchQueue.main.async
//                {
//                    self.present(alert, animated: true, completion: nil)
//                }
//
                self.dismiss(animated: true, completion: nil)
                navigationController?.pushViewController(ViewController(), animated: true)

            }
            else
            {
                let alert = UIAlertController(title: "Oops!", message: "username or password is incorrect. Please try again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                DispatchQueue.main.async
                {
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        

        override func viewDidLoad() {
            super.viewDidLoad()
            
//            title = "Login "
            view.backgroundColor = .white
            view.addSubview(emailId)
            view.addSubview(pswd)
            view.addSubview(Login)
            view.addSubview(lbPswd)
            view.addSubview(lbEmail)
       
        }
        
        override func viewDidLayoutSubviews() {
            super .viewDidLayoutSubviews()
            
            lbEmail.frame = CGRect(x: 40, y: view.safeAreaInsets.top+100, width: view.width-60, height: 50)
            emailId.frame = CGRect(x: 40, y: lbEmail.bottom, width: view.width-60, height: 50)
            lbPswd.frame = CGRect(x: 40, y: emailId.bottom+20, width: view.width-60, height: 50)
            pswd.frame = CGRect(x: 40, y: lbPswd.bottom, width: view.width-60, height: 50)
            Login.frame = CGRect(x: 50, y: pswd.bottom+40, width: view.width-70, height: 50)
            
        }
}

