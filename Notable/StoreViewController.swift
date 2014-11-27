//
//  StoreViewController.swift
//  Notable
//
//  Created by abdullah cengiz on 04/11/14.
//  Copyright (c) 2014 abdullah cengiz. All rights reserved.
//

import UIKit



class StoreViewController: UIViewController {
    var navBar:UINavigationBar!
    

    @IBOutlet var animateBtn: UIButton!
    @IBOutlet var storeViewImageContainer: UIView!
    @IBOutlet var navItem: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        navBar = self.navigationController?.navigationBar
        prepareNavigationBar()
        storeViewImageContainer.layer.cornerRadius  = 4.0
        animateBtn.layer.cornerRadius  = 4.0
        
        //get saved theme
        
        let removedReklam = NSUserDefaults.standardUserDefaults().objectForKey("removedReklam") as Int!
        
        println(removedReklam)

        
        if(removedReklam? == 0) {
            
            removeReklam()

    }

    }
    
    
    //***HERE IS THE HIDE REKLAM ANIMATION ***
    
    @IBOutlet var reklamContainer: UIView!
    @IBAction func animateButtonPressed(sender: AnyObject) {
        removeReklam()
            }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func prepareNavigationBar(){
        
        //for back button
        let image = UIImage(named: "backbutton") as UIImage?
        let uiButton    = UIButton.buttonWithType(UIButtonType.System) as UIButton
        uiButton.frame  = CGRectMake(0, 0, 25, 25)
        uiButton.setBackgroundImage(image, forState: UIControlState.Normal)
        uiButton.setTitle("", forState: UIControlState.Normal);
        uiButton.addTarget(self, action:"backButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        navItem.setLeftBarButtonItem(UIBarButtonItem(customView: uiButton), animated: true)
        navItem.hidesBackButton=true

        
    }
    
    
    @IBAction func backButtonAction(sender:UIButton)
    {
        println("Button Action From Code")
        self.navigationController?.popViewControllerAnimated(true)
    }


    func setColor(#backgroundColor:UIColor){
        
        self.view.backgroundColor = backgroundColor
}
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        removeReklam()
        
        let reklam: Int = NSUserDefaults.standardUserDefaults().objectForKey("reklam") as Int
        
        if(reklam==0){
            
            reklamContainer.hidden = true
            

        }

        
    }
    
    
    func removeReklam(){
        
        
        
        NSUserDefaults.standardUserDefaults().setObject(0, forKey: "reklam")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        let viewToAnimate = [reklamContainer]
        
        UIView.performSystemAnimation(UISystemAnimation.Delete, onViews: viewToAnimate, options: nil, animations: {
            //change nil to: UIViewAnimationOptionBeginFromCurrentState
            UIView.setAnimationBeginsFromCurrentState(true)
            
            }, completion: { finished in
        })

        
        
        
    }
    
}
