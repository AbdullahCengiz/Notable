//
//  SettingsViewController.swift
//  Notable
//
//  Created by abdullah cengiz on 21/10/14.
//  Copyright (c) 2014 abdullah cengiz. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController{
    
    var navBar:UINavigationBar!
    var delegate:AnyObject?
    
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

    
    var tickImageArray : [UIImageView] = []
    
    
    let firstThemeButtonTag:Int = 0 ,
        secondThemeButtonTag:Int = 1 ,
        thirdThemeButtonTag:Int = 2 ,
        fourthThemeButtonTag:Int = 3 ,
        fifthThemeButtonTag:Int = 4
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        println("in settingsViewController!!!!!!")
        navBar = self.navigationController?.navigationBar
        

        setTags()
        
        initUI()
        
        initVariables()
        
        
        //get saved theme
        let selectedTheme: Int = NSUserDefaults.standardUserDefaults().objectForKey("selectedTheme") as Int
        setTheme(theme: selectedTheme)
    }
    
    
    func initUI(){
        
        resetAnswersButton.layer.cornerRadius=4.0
        resetHighScoresButton.layer.cornerRadius=4.0
        soundLevelInicatorContainer.layer.cornerRadius=4.0
        storeButton.layer.cornerRadius=4.0
        
        
        // control initial sound value
        var soundLevel: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("sound")
        if(soundLevel==nil){
            
            println("No sound value !!!!!")
            
            NSUserDefaults.standardUserDefaults().setObject(soundSlider.value, forKey: "sound")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }else{
            
            println("Sound value found = \(soundLevel!)")
            var soundValue : Float = soundLevel! as Float
            soundSlider.value = soundValue
        }
        

        
    }
    
    @IBAction func highScoreButtonClicked(sender: AnyObject) {
        
        
        NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "zeroHighScore")
        NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "highscoreNumberGold")
        NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "highscoreNumberSilver")
        NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "highscoreNumberBronze")
        NSUserDefaults.standardUserDefaults().synchronize()

        NSUserDefaults.standardUserDefaults().synchronize()
        
        println("It's clicked! Woho!")
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
         styleView()
    }
    
    func styleView() {
        var bg:UIColor = UIColor.whiteColor()
        var btn:UIColor = UIColor.whiteColor()
        var txt:UIColor = UIColor.yellowColor()
        Theme().fetchThemeColors(&bg, buttonColor:&btn, textColor:&txt)
        
        self.view.backgroundColor = bg
        self.storeButton.backgroundColor = btn
        self.resetAnswersButton.backgroundColor = btn
        self.resetHighScoresButton.backgroundColor = btn
        self.soundSlider.backgroundColor = btn
        self.soundLevelInicatorContainer.backgroundColor = btn
        
        self.resetAnswersButton.setTitleColor(txt, forState: UIControlState.Normal)
        self.resetHighScoresButton.setTitleColor(txt, forState: UIControlState.Normal)
        self.storeButton.setTitleColor(txt, forState: UIControlState.Normal)
        


        
    }
    func prepareNavigationBar(){
        
        let image       = UIImage(named: "backbutton") as UIImage?
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

    
    @IBAction func selectThemeAction(sender:UIButton){
        println("Theme Selection Settings!!! \(sender.tag)")
       
        //save selectedTheme
        NSUserDefaults.standardUserDefaults().setObject(sender.tag, forKey: "selectedTheme")
        NSUserDefaults.standardUserDefaults().synchronize()

        let ud = NSUserDefaults.standardUserDefaults()
        var colorBackground:UIColor = UIColor(red:226/255.0, green:232/255.0, blue:239/255.0, alpha:1.0)
        var colorButtons:UIColor = UIColor.whiteColor()
        var colorText:UIColor = UIColor.blackColor()
        
        if(sender.tag == firstThemeButtonTag) {ud
            setTheme(theme: firstThemeButtonTag)
            colorBackground = UIColor(red:226/255.0, green:232/255.0, blue:239/255.0, alpha:1.0)
            colorButtons = UIColor.whiteColor()
            colorText = UIColor.blackColor()
        }
        
        else if (sender.tag == secondThemeButtonTag) {
            setTheme(theme: secondThemeButtonTag)
            colorBackground = UIColor.blackColor()
            colorButtons = UIColor(red:36/255.0, green:40/255.0, blue:48/255.0, alpha:1.0)
            colorText = UIColor.whiteColor()
        }
        
        else if (sender.tag == thirdThemeButtonTag) {
                setTheme(theme: thirdThemeButtonTag)
                colorBackground = UIColor(red:36/255.0, green:40/255.0, blue:48/255.0, alpha:1.0)
                colorButtons = UIColor(red:166/255.0, green:49/255.0, blue:58/255.0, alpha:1.0)
                colorText = UIColor.whiteColor()
            }
        
        else if (sender.tag == fourthThemeButtonTag) {
                setTheme(theme: fourthThemeButtonTag)
                colorBackground = UIColor(red:36/255.0, green:40/255.0, blue:48/255.0, alpha:1.0)
                colorButtons = UIColor(red:110/255.0, green:213/255.0, blue:107/255.0, alpha:1.0)
                colorText = UIColor.whiteColor()
            }
        
        else if (sender.tag == fifthThemeButtonTag) {
                setTheme(theme: fifthThemeButtonTag)
                colorBackground = UIColor(red:204/255.0, green:210/255.0, blue:216/255.0, alpha:1.0)
                colorButtons = UIColor(red:70/255.0, green:151/255.0, blue:233/255.0, alpha:1.0)
                colorText = UIColor.whiteColor()
            }
        
        //First ThemeColor
        println("Color1 \(colorBackground), color \(colorButtons)")
        
        var colorBackgroundData: NSData = NSKeyedArchiver.archivedDataWithRootObject(colorBackground)
        var colorButtonsData: NSData = NSKeyedArchiver.archivedDataWithRootObject(colorButtons)
        var colorTextData: NSData = NSKeyedArchiver.archivedDataWithRootObject(colorText)
        
        ud.setObject(colorBackgroundData, forKey: "colorBackgrounds")
        ud.setObject(colorButtonsData, forKey: "colorButtons")
        ud.setObject(colorTextData, forKey: "colorText")
        ud.synchronize()
        
        
        
    
        styleView()
        
    }
    
    func setColor(#backgroundColor:UIColor,buttonColor:UIColor, textColor:UIColor){
    
        self.view.backgroundColor = backgroundColor
        self.soundSlider.backgroundColor = buttonColor
        self.resetAnswersButton.backgroundColor = buttonColor
        self.soundLevelInicatorContainer.backgroundColor = buttonColor
        self.soundSlider.backgroundColor = buttonColor
        self.storeButton.backgroundColor = buttonColor
        
    }
    
    func setTheme(#theme: Int){
        
        for counter in tickImageArray{
            
            if(counter.tag == theme){
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.tickImageArray[counter.tag].hidden = false
                }
                    } else {
                
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
    
    
    
    @IBAction func goToStore(sender: AnyObject) {
        
        self.performSegueWithIdentifier("goToStore", sender: nil)
        
    }

    



}
