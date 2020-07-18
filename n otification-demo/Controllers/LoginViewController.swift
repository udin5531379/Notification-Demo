//
//  LoginViewController.swift
//  n otification-demo
//
//  Created by Udin Rajkarnikar on 10/11/18.
//  Copyright © 2018 Udin Rajkarnikar. All rights reserved.
//

import UIKit
import SVProgressHUD
import UserNotifications

class LoginViewController: UIViewController {

    let backgroundImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "truck_hero")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let loginView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        
        //for shadow
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 5
        
        return view
    }()
    
    let companyLogo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    let adminLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ADMIN LOGIN"
        label.font = UIFont(name: "Avenir", size: 15)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let emailTextField : UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Email Address"
        textfield.font = UIFont(name: "Avenir", size: 17)
        textfield.keyboardType = .emailAddress
        return textfield
    }()
    
    let passwordTextfield : UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.isSecureTextEntry = true
        textfield.placeholder = "Password"
        return textfield
    }()
    
    let emailseperator: UIView = {
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = UIColor.lightGray
        
        return seperator
    }()
    
    let passwordseperator: UIView = {
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = UIColor.lightGray
        
        return seperator
    }()
    
    let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("LOGIN", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.titleLabel?.font = UIFont(name: "Avenir", size: 17)
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
//    let view23 : UIButton = {
//        let button = UIButton(type: .system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("LOGIN", for: .normal)
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.backgroundColor = UIColor.white
//        button.titleLabel?.font = UIFont(name: "Avenir", size: 17)
//        button.layer.cornerRadius = 30
//        button.layer.borderWidth = 2
//        button.addTarget(self, action: #selector(login), for: .touchUpInside)
//        return button
//    }()
//
//    @objc func login() {
//
//        let cs = TableViewControllerfinal()
//        present(UINavigationController(rootViewController: cs), animated: true, completion: nil)
//
//
//
//    }
 
    
    
    func notification(){
        
        let content = UNMutableNotificationContent()
        content.title = "Missed Calls"
        content.body = "Open app to view the missed calls"
        content.sound = UNNotificationSound.default
        

        let random = Int.random(in: 600...2000)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(random), repeats: true)
        
        let request = UNNotificationRequest(identifier: "test", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
        
    }
    
    @objc func loginButtonPressed(){
        
        notification()
        loginButton.bouncButton()
        view.endEditing(true)
        SVProgressHUD.show()
        let url = URL(string: "http://18.223.3.41:8080/api/missedcallnotifier/userLogin")!
        let jsonDict = ["username": emailTextField.text!, "password": passwordTextfield.text!]
        let jsonData = try! JSONSerialization.data(withJSONObject: jsonDict, options: [])
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                SVProgressHUD.showError(withStatus: "\(error)")
                print("error:", error)
                return
            }
            
            do {
                guard let data = data else { return }
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else { return }
                print("json:", json)
                SVProgressHUD.dismiss()
                
                print("Success")
                
                DispatchQueue.main.sync {
                    
                    let vc = TableViewControllerfinal()
                    self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
                    
                }
            } catch {
                
                SVProgressHUD.showError(withStatus: "Invalid credentials")
                print("error:", error)
                
            }
        }
        
        task.resume()
        
        
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.addSubview(backgroundImage)
        view.addSubview(loginView)
        view.addSubview(companyLogo)
        view.addSubview(adminLabel)
        view.addSubview(emailTextField)
        view.addSubview(emailseperator)
        view.addSubview(passwordTextfield)
        view.addSubview(passwordseperator)
        view.addSubview(loginButton)
//        view.addSubview(view23)
        
        constraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditingTap))
        view.addGestureRecognizer(tapGesture)
        loginView.addGestureRecognizer(tapGesture)
        
    }
    
    
    @objc func endEditingTap() {
        
        view.endEditing(true)
    }
    
    func constraints() {
        
        backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        backgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        backgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        loginView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        loginView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50).isActive = true
        
        companyLogo.centerXAnchor.constraint(equalTo: loginView.centerXAnchor).isActive = true
        companyLogo.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 10).isActive = true
        companyLogo.widthAnchor.constraint(equalToConstant: 120).isActive = true
        companyLogo.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        adminLabel.centerXAnchor.constraint(equalTo: loginView.centerXAnchor).isActive = true
        adminLabel.topAnchor.constraint(equalTo: companyLogo.bottomAnchor, constant: 5).isActive = true
        adminLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        adminLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        emailTextField.centerXAnchor.constraint(equalTo: loginView.centerXAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: adminLabel.bottomAnchor, constant: 1).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: loginView.widthAnchor, constant: -24).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        emailseperator.centerXAnchor.constraint(equalTo: loginView.centerXAnchor).isActive = true
        emailseperator.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailseperator.widthAnchor.constraint(equalTo: loginView.widthAnchor, constant: -24).isActive = true
        emailseperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordTextfield.centerXAnchor.constraint(equalTo: loginView.centerXAnchor).isActive = true
        passwordTextfield.topAnchor.constraint(equalTo: emailseperator.bottomAnchor, constant: 5).isActive = true
        passwordTextfield.widthAnchor.constraint(equalTo: loginView.widthAnchor, constant: -24).isActive = true
        passwordTextfield.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordseperator.centerXAnchor.constraint(equalTo: loginView.centerXAnchor).isActive = true
        passwordseperator.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor).isActive = true
        passwordseperator.widthAnchor.constraint(equalTo: loginView.widthAnchor, constant: -24).isActive = true
        passwordseperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        loginButton.centerXAnchor.constraint(equalTo: loginView.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordseperator.bottomAnchor, constant: 25).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    

}
