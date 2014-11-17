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
            self.view.backgroundColor =
UIColor(red:226/255.0, green:232/255.0, blue:239/255.0, alpha:1.0)
            self.soundSlider.backgroundColor =
                UIColor.whiteColor()
            self.resetAnswersButton.backgroundColor =
                UIColor.whiteColor()
            self.resetHighScoresButton.backgroundColor =
                UIColor.whiteColor()
            self.soundLevelInicatorContainer.backgroundColor =
                UIColor.whiteColor()
            self.colorSlider.backgroundColor =
                UIColor.whiteColor()
            self.storeButton.backgroundColor =
                UIColor.whiteColor()
            
        }
        else if(sender.tag == secondThemeButtonTag){
            
            setTheme(theme:secondThemeButtonTag)
            self.view.backgroundColor = UIColor.blackColor()
            self.soundSlider.backgroundColor =
                UIColor(red:36/255.0, green:40/255.0, blue:48/255.0, alpha:1.0)
            self.resetAnswersButton.backgroundColor =
                UIColor(red:36/255.0, green:40/255.0, blue:48/255.0, alpha:1.0)
            self.resetHighScoresButton.backgroundColor =
                UIColor(red:36/255.0, green:40/255.0, blue:48/255.0, alpha:1.0)
            self.soundLevelInicatorContainer.backgroundColor =
                UIColor(red:36/255.0, green:40/255.0, blue:48/255.0, alpha:1.0)
            self.colorSlider.backgroundColor =
                UIColor(red:36/255.0, green:40/255.0, blue:48/255.0, alpha:1.0)
            self.storeButton.backgroundColor =
                UIColor(red:36/255.0, green:40/255.0, blue:48/255.0, alpha:1.0)
            
        }
        else if (sender.tag == thirdThemeButtonTag) {
            
            setTheme(theme:thirdThemeButtonTag)
            self.view.backgroundColor =
                UIColor(red:36/255.0, green:40/255.0, blue:48/255.0, alpha:1.0)
            self.soundSlider.backgroundColor =
                UIColor(red:166/255.0, green:49/255.0, blue:58/255.0, alpha:1.0)
            self.resetAnswersButton.backgroundColor =
                UIColor(red:166/255.0, green:49/255.0, blue:58/255.0, alpha:1.0)
            self.resetHighScoresButton.backgroundColor =
                UIColor(red:166/255.0, green:49/255.0, blue:58/255.0, alpha:1.0)
            self.soundLevelInicatorContainer.backgroundColor =
                UIColor(red:166/255.0, green:49/255.0, blue:58/255.0, alpha:1.0)
            self.colorSlider.backgroundColor =
                UIColor(red:166/255.0, green:49/255.0, blue:58/255.0, alpha:1.0)
            self.storeButton.backgroundColor =
                UIColor(red:166/255.0, green:49/255.0, blue:58/255.0, alpha:1.0)
            
        }
        else if (sender.tag == fourthThemeButtonTag){
            
            setTheme(theme:fourthThemeButtonTag)
            self.view.backgroundColor =
                UIColor(red:36/255.0, green:40/255.0, blue:48/255.0, alpha:1.0)
            self.soundSlider.backgroundColor =
                UIColor(red:110/255.0, green:213/255.0, blue:107/255.0, alpha:1.0)
            self.resetAnswersButton.backgroundColor =
                UIColor(red:110/255.0, green:213/255.0, blue:107/255.0, alpha:1.0)
            self.resetHighScoresButton.backgroundColor =
                UIColor(red:110/255.0, green:213/255.0, blue:107/255.0, alpha:1.0)
            self.soundLevelInicatorContainer.backgroundColor =
                UIColor(red:110/255.0, green:213/255.0, blue:107/255.0, alpha:1.0)
            self.colorSlider.backgroundColor =
                UIColor(red:110/255.0, green:213/255.0, blue:107/255.0, alpha:1.0)
            self.storeButton.backgroundColor =
                UIColor(red:110/255.0, green:213/255.0, blue:107/255.0, alpha:1.0)
            
        }
        else if(sender.tag == fifthThemeButtonTag){
            
            setTheme(theme:fifthThemeButtonTag)
            self.view.backgroundColor =
                UIColor(red:204/255.0, green:210/255.0, blue:216/255.0, alpha:1.0)
            self.soundSlider.backgroundColor =
                UIColor(red:70/255.0, green:151/255.0, blue:233/255.0, alpha:1.0)
            self.resetAnswersButton.backgroundColor =
                UIColor(red:70/255.0, green:151/255.0, blue:233/255.0, alpha:1.0)
            self.resetHighScoresButton.backgroundColor =
                UIColor(red:70/255.0, green:151/255.0, blue:233/255.0, alpha:1.0)
            self.soundLevelInicatorContainer.backgroundColor =
                UIColor(red:70/255.0, green:151/255.0, blue:233/255.0, alpha:1.0)
            self.colorSlider.backgroundColor =
                UIColor(red:70/255.0, green:151/255.0, blue:233/255.0, alpha:1.0)
            self.storeButton.backgroundColor =
                UIColor(red:70/255.0, green:151/255.0, blue:233/255.0, alpha:1.0)
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
