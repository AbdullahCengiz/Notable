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
        
        prepareNavigationBar()
    }
    
    func prepareNavigationBar(){
        
        //for menubutton
        let menuImage = UIImage(named: "menu_btn") as UIImage?
        let menuButton    = UIButton.buttonWithType(UIButtonType.System) as UIButton
        menuButton.frame  = CGRectMake(0, 0, 25, 25)
        menuButton.setBackgroundImage(menuImage, forState: UIControlState.Normal)
        menuButton.setTitle("", forState: UIControlState.Normal);
        menuButton.addTarget(self, action:"backButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        navItem.setLeftBarButtonItem(UIBarButtonItem(customView: menuButton), animated: true)
        navItem.hidesBackButton=true

        
    }
    
    
    @IBAction func backButtonAction(sender:UIButton)
    {
        var pauseScreen:NGPause = self.storyboard!.instantiateViewControllerWithIdentifier("PausedGameViewController") as NGPause
        pauseScreen.delegate = self
        self.title = "newLesson"
        self.presentViewController(pauseScreen, animated: true, completion: nil)
    }
}