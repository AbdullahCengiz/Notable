//
//  StoreViewController.swift
//  Notable
//
//  Created by abdullah cengiz on 04/11/14.
//  Copyright (c) 2014 abdullah cengiz. All rights reserved.
//

import UIKit
import SpriteKit



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
        }
    }
    
    //***HERE IS THE HIDE REKLAM ANIMATION ***
    

    @IBOutlet weak var reklam_yes: UIImageView!
    @IBOutlet var reklamContainer: UIView!
    @IBAction func animateButtonPressed(sender: AnyObject?) {
        removeReklam()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func prepareNavigationBar(){
        
        //for back button
        let image = UIImage(named: "backbutton") as UIImage?
        let uiButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        uiButton.frame = CGRectMake(0, 0, 25, 25)
        uiButton.setBackgroundImage(image, forState: UIControlState.Normal)
        uiButton.setTitle("", forState: UIControlState.Normal);
        uiButton.addTarget(self, action:"backButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        navItem.setLeftBarButtonItem(UIBarButtonItem(customView: uiButton), animated: true)
        navItem.hidesBackButton=true
    }
    
    
    @IBAction func backButtonAction(sender:UIButton) {
        println("Button Action From Code")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    func setColor(#backgroundColor:UIColor){
        
        self.view.backgroundColor = backgroundColor
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        styleView()

        
        let reklam: Int = NSUserDefaults.standardUserDefaults().objectForKey("reklam") as Int
        
        if(reklam==0){
            removeReklam()
            reklamContainer.hidden = true
            animateBtn.hidden = true
        }
    }
    
    func styleView() {
        
        var bg:UIColor = UIColor.whiteColor()
        var btn:UIColor = UIColor.whiteColor()
        var txt:UIColor = UIColor.blackColor()
        Theme().fetchThemeColors(&bg, buttonColor:&btn, textColor:&txt)

        self.view.backgroundColor = bg
        self.storeViewImageContainer.backgroundColor = btn
        self.animateBtn.backgroundColor = btn
        self.animateBtn.setTitleColor(txt, forState: UIControlState.Normal)
    }

    func removeReklam(){
        
        NSUserDefaults.standardUserDefaults().setObject(0, forKey: "reklam")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        let viewToAnimate: NSArray = [reklamContainer, reklam_yes]
        
        
        UIView.performSystemAnimation(UISystemAnimation.Delete, onViews:viewToAnimate, options: nil, animations: {
            UIView.setAnimationBeginsFromCurrentState(true)
            
            
            }, completion: { finished in
        })
    }
    
    func removeAnimateBtn(){
        
        NSUserDefaults.standardUserDefaults().setObject(0, forKey: "animateBtn")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        let viewToAnimate: NSArray = [animateBtn]
        
        UIView.performSystemAnimation(UISystemAnimation.Delete, onViews:viewToAnimate, options: nil, animations: {
            UIView.setAnimationBeginsFromCurrentState(true)
            
            }, completion: { finished in
        })
    }
}