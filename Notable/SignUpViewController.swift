//
//  SignUpViewController.swift
//  Notable
//
//  Created by abdullah cengiz on 10/11/14.
//  Copyright (c) 2014 abdullah cengiz. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,FBLoginViewDelegate {

    
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var fbLoginView: FBLoginView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = true
        self.fbLoginView.delegate = self
        self.fbLoginView.readPermissions = ["public_profile", "email", "user_friends"]
        // Do any additional setup after loading the view.
        
        
    }

   
    func loginViewShowingLoggedInUser(loginView : FBLoginView!) {
        println("User Logged In")
    }
    
    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser) {
        println("User: \(user)")
        println("User ID: \(user.objectID)")
        println("User Name: \(user.first_name)")
        var userEmail = user.objectForKey("email") as String
        println("User Email: \(userEmail)")
        
        saveUserName(userName:user.first_name)
        
        
        
        
        
    }
    
    func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
        println("User Logged Out")
    }
    
    func loginView(loginView : FBLoginView!, handleError:NSError) {
        println("Error: \(handleError.localizedDescription)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func saveUserName(#userName:String){
        
        NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "userName")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        
        self.performSegueWithIdentifier("goToMainPage", sender: nil)
    }
    
    
    @IBAction func next(sender: AnyObject) {
        
        self.performSegueWithIdentifier("goToMainPage", sender: nil)

        
    }
    }
