//
//  SettingsViewController.swift
//  Notable
//
//  Created by abdullah cengiz on 21/10/14.
//  Copyright (c) 2014 abdullah cengiz. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var navBar:UINavigationBar!
    
    @IBOutlet var firstTickImage: UIImageView!
    @IBOutlet var secondTickImage: UIImageView!
    @IBOutlet var thirdTickImage: UIImageView!
    @IBOutlet var fourthTickImage: UIImageView!
    @IBOutlet var fifthTickImage: UIImageView!
    
    
    @IBOutlet var firstThemeButton: UIButton!
    @IBOutlet var secondThemeButton: UIButton!
    @IBOutlet var thirdThemeButton: UIButton!
    @IBOutlet var fourthThemeButton: UIButton!
    @IBOutlet var fifthThemeButton: UIButton!
    

    @IBOutlet var storeButton: UIButton!
    @IBOutlet var soundSlider: UISlider!
    @IBOutlet var resetAnswersButton: UIButton!
    @IBOutlet var resetHighScoresButton: UIButton!
    @IBOutlet var soundLevelInicatorContainer: UIView!
    @IBOutlet var navItem: UINavigationItem!
    
    @IBOutlet var colorSlider: UISlider!
    
    var tickImageArray : [UIImageView] = []
    
    
    let firstThemeButtonTag:Int = 0 ,
        secondThemeButtonTag:Int = 1 ,
        thirdThemeButtonTag:Int = 2 ,
        fourthThemeButtonTag:Int = 3 ,
        fifthThemeButtonTag:Int = 4
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar = self.navigationController?.navigationBar
        
        setTags()
        
        initUI()
        
        initVariables()
        
    }
    
    
    func initUI(){
        
        resetAnswersButton.layer.cornerRadius=4.0
        resetHighScoresButton.layer.cornerRadius=4.0
        soundLevelInicatorContainer.layer.cornerRadius=4.0
        storeButton.layer.cornerRadius=4.0
        
        
        var soundLevel: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("sound")
        // control initial sound value
        if(soundLevel==nil){
            
            println("No sound value !!!!!")
            
            NSUserDefaults.standardUserDefaults().setObject(colorSlider.value, forKey: "sound")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            
            
        }else{
            
            println("Sound value found = \(soundLevel!)")
            var soundValue : Float = soundLevel! as Float
            colorSlider.value = soundValue
            
            
        }
        
    }
    
    
    func initVariables(){
        
        tickImageArray = [firstTickImage,secondTickImage,thirdTickImage,fourthTickImage,fifthTickImage]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
       navBar.titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 16),
            NSForegroundColorAttributeName: UIColor.blackColor()]
            navBar.barTintColor = UIColor.whiteColor()
        
         prepareNavigationBar()
    }
    
    func prepareNavigationBar(){
        
        let image = UIImage(named: "backbutton") as UIImage?
        let uiButton    = UIButton.buttonWithType(UIButtonType.System) as UIButton
        uiButton.frame  = CGRectMake(0, 0, 25, 25)
        uiButton.setBackgroundImage(image, forState: UIControlState.Normal)
        uiButton.setTitle("", forState: UIControlState.Normal);
        uiButton.addTarget(self, action:"backButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        navItem.setLeftBarButtonItem(UIBarButtonItem(customView: uiButton), animated: true)
        navItem.hidesBackButton=true
        
    }
    
    
    func setTags(){
        
       firstTickImage.tag = firstThemeButtonTag
       firstThemeButton.tag = firstThemeButtonTag
        
       secondTickImage.tag = secondThemeButtonTag
       secondThemeButton.tag  = secondThemeButtonTag
    
       thirdTickImage.tag = thirdThemeButtonTag
       thirdThemeButton.tag = thirdThemeButtonTag
        
       fourthTickImage.tag = fourthThemeButtonTag
       fourthThemeButton.tag = fourthThemeButtonTag
        
       fifthTickImage.tag = fifthThemeButtonTag
       fifthThemeButton.tag = fifthThemeButtonTag
        
        
    }

    
    
    @IBAction func backButtonAction(sender:UIButton)
    {
        println("Button Action From Code")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    
    
    @IBAction func selectThemeAction(sender:UIButton)
    {
        println("Theme Selection !!! \(sender.tag)")
        
        
        
        if(sender.tag == firstThemeButtonTag){
            
            setTheme(theme:firstThemeButtonTag)
            
        }
        else if(sender.tag == secondThemeButtonTag){
            
            setTheme(theme:secondThemeButtonTag)
            
        }
        else if (sender.tag == thirdThemeButtonTag) {
            
            setTheme(theme:thirdThemeButtonTag)
            
        }
        else if (sender.tag == fourthThemeButtonTag){
            
            setTheme(theme:fourthThemeButtonTag)
            
        }
        else if(sender.tag == fifthThemeButtonTag){
            
            setTheme(theme:fifthThemeButtonTag)
            
        }
        
    }
    
    
    
    
    
    func setTheme(#theme: Int){
        
        
        for counter in tickImageArray{
            
            
            if(counter.tag == theme){
                
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.tickImageArray[counter.tag].hidden = false
                }
                
                
                
            }
            else {
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.tickImageArray[counter.tag].hidden = true
                }
                
            }
            
            
        }
        
        
    }
    
    
    
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        
        var value = Float(sender.value)
        println(value)
        NSUserDefaults.standardUserDefaults().setObject(value, forKey: "sound")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        
    }
    
    
    


    
    
}
