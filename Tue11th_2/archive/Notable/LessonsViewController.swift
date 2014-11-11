//
//  LessonsViewController.swift
//  Notable
//
//  Created by abdullah cengiz on 24/10/14.
//  Copyright (c) 2014 abdullah cengiz. All rights reserved.
//

import UIKit

class LessonsViewController: UIViewController {
    @IBOutlet var navItem: UINavigationItem!
    
    
    var navBar:UINavigationBar!
    
    @IBOutlet var prevButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    @IBOutlet var lessonContentContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar = self.navigationController?.navigationBar
        
        initUI()
        
        // Do any additional setup after loading the view.
    }
    
    
    func initUI(){
    
    prevButton.layer.cornerRadius = prevButton.frame.height/2
    nextButton.layer.cornerRadius = nextButton.frame.height/2
        
    lessonContentContainer.layer.cornerRadius = 4.0
    
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navBar.titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 20),
            NSForegroundColorAttributeName: UIColor.blackColor()]
        navBar.barTintColor = UIColor.whiteColor()
        
        prepareNavigationBar()
    }
    
    func prepareNavigationBar(){
        
        //for backbutton
        let image = UIImage(named: "backbutton") as UIImage?
        let uiButton    = UIButton.buttonWithType(UIButtonType.System) as UIButton
        uiButton.frame  = CGRectMake(0, 0, 25, 25)
        uiButton.setBackgroundImage(image, forState: UIControlState.Normal)
        uiButton.setTitle("", forState: UIControlState.Normal);
        uiButton.addTarget(self, action:"backButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        navItem.setLeftBarButtonItem(UIBarButtonItem(customView: uiButton), animated: true)
        navItem.hidesBackButton=true
        
        //for logo
        let logo = UIImage(named: "logo")
        let imageView = UIImageView(image:logo)
        imageView.frame = CGRectMake(0, 0, 30, 30)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        navItem.titleView = imageView

        
    }
    
    
    @IBAction func backButtonAction(sender:UIButton)
    {
        println("Button Action From Code")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
}
