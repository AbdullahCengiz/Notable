//
//  ViewController.swift
//  Notable
//
//  Created by abdullah cengiz on 17/10/14.
//  Copyright (c) 2014 abdullah cengiz. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("inSplashScreen")
        
        Timer("goToMainPage", 3) {
            self .performSegueWithIdentifier("goToMainPage", sender: nil)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        getScreenSize()
        
    }
    
    func getScreenSize(){
        
        var bounds: CGRect = UIScreen.mainScreen().bounds
        var screenWidth:CGFloat = bounds.size.width
        var screenHeight:CGFloat = bounds.size.height
        
        saveScreenSize(width:screenWidth,height:screenHeight)
        
    }
    
    func saveScreenSize(#width:CGFloat, height:CGFloat){
        
        
        NSUserDefaults.standardUserDefaults().setObject(width, forKey: "width")
        NSUserDefaults.standardUserDefaults().setObject(height, forKey: "height")
        
        let width: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("width")
        let height: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("height")
    
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }



}

