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



    @IBOutlet var storeButton: UIButton!
    @IBOutlet var soundSlider: UISlider!
    @IBOutlet var resetAnswersButton: UIButton!
    @IBOutlet var resetHighScoresButton: UIButton!
    @IBOutlet var soundLevelInicatorContainer: UIView!
    @IBOutlet var navItem: UINavigationItem!


    @IBOutlet var themeSegmentButton: UISegmentedControl!

    
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

        initTheme()
    
        initUI()
        
        initVariables()
        
        


    }


    func initTheme(){

        //get saved theme
        let selectedTheme: Int = NSUserDefaults.standardUserDefaults().objectForKey("selectedTheme") as Int


        if(selectedTheme == 0){
            themeSegmentButton.selectedSegmentIndex = 0
        }
        else{
            themeSegmentButton.selectedSegmentIndex = 1
        }

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
        self.themeSegmentButton.backgroundColor = btn


        self.themeSegmentButton.tintColor = txt
        
        self.resetAnswersButton.setTitleColor(txt, forState: UIControlState.Normal)
        self.resetHighScoresButton.setTitleColor(txt, forState: UIControlState.Normal)
        self.storeButton.setTitleColor(txt, forState: UIControlState.Normal)

        //change navigation bar color
        self.navigationController!.navigationBar.barTintColor = btn

        //change navigation item title color
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: txt]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict

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

    
    @IBAction func backButtonAction(sender:UIButton)
        {
        println("Button Action From Code")
        self.navigationController?.popViewControllerAnimated(true)
        }

    

    func setColor(#backgroundColor:UIColor,buttonColor:UIColor, textColor:UIColor){
    
        self.view.backgroundColor = backgroundColor
        self.soundSlider.backgroundColor = buttonColor
        self.resetAnswersButton.backgroundColor = buttonColor
        self.soundLevelInicatorContainer.backgroundColor = buttonColor
        self.soundSlider.backgroundColor = buttonColor
        self.storeButton.backgroundColor = buttonColor
        
    }
    

    
    @IBAction func sliderValueChanged(sender: UISlider) {
        
        var value = Float(sender.value)
        println(value)
        NSUserDefaults.standardUserDefaults().setObject(value, forKey: "sound")
        NSUserDefaults.standardUserDefaults().synchronize()
   
    }
    
    
    
    @IBAction func goToStore(sender: AnyObject) {
        
        self.performSegueWithIdentifier("goToInAppPurchase", sender: nil)
        
    }

    

    @IBAction func themeChanged(sender: AnyObject) {

        NSUserDefaults.standardUserDefaults().setObject(themeSegmentButton.selectedSegmentIndex, forKey: "selectedTheme")
        NSUserDefaults.standardUserDefaults().synchronize()

        let ud = NSUserDefaults.standardUserDefaults()

        //save selectedTheme
        var colorBackground:UIColor = UIColor(red:226/255.0, green:232/255.0, blue:239/255.0, alpha:1.0)
        var colorButtons:UIColor = UIColor.whiteColor()
        var colorText:UIColor = UIColor.blackColor()


        switch themeSegmentButton.selectedSegmentIndex
        {
        case 0:
            println("FirstThemeSelected!!!!")
            colorBackground = UIColor(red:226/255.0, green:232/255.0, blue:239/255.0, alpha:1.0)
            colorButtons = UIColor.whiteColor()
            colorText = UIColor.blackColor()
        case 1:
            println("secondThemeSelected!!!!")
            colorBackground = UIColor(red:31/255.0, green:31/255.0, blue:31/255.0, alpha:1.0)
            colorButtons = UIColor(red:76/255.0, green:76/255.0, blue:76/255.0, alpha:1.0)
            colorText = UIColor.whiteColor()
        default:
            break; 
        }

        var colorBackgroundData: NSData = NSKeyedArchiver.archivedDataWithRootObject(colorBackground)
        var colorButtonsData: NSData = NSKeyedArchiver.archivedDataWithRootObject(colorButtons)
        var colorTextData: NSData = NSKeyedArchiver.archivedDataWithRootObject(colorText)

        ud.setObject(colorBackgroundData, forKey: "colorBackgrounds")
        ud.setObject(colorButtonsData, forKey: "colorButtons")
        ud.setObject(colorTextData, forKey: "colorText")
        ud.synchronize()

        styleView()

    }


}
