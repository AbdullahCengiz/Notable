//
//  ViewController.swift
//  Notable
//
//  Created by abdullah cengiz on 24/10/14.
//  Copyright (c) 2014 abdullah cengiz. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation
import QuartzCore

class NewGameViewController: UIViewController {
    @IBOutlet var navItem: UINavigationItem!
    
    //for progressCell IBOutlets
    @IBOutlet var cell1: UIView!
    @IBOutlet var cell2: UIView!
    @IBOutlet var cell3: UIView!
    @IBOutlet var cell4: UIView!
    @IBOutlet var cell5: UIView!
    @IBOutlet var cell6: UIView!
    @IBOutlet var cell7: UIView!
    @IBOutlet var cell8: UIView!
    @IBOutlet var cell9: UIView!
    @IBOutlet var cell10: UIView!
    
    var cellArray : [UIView] = []
    var cellCounter:Int = 0
    var audioPlayer = AVAudioPlayer()
    var soundLevelValue : Float!
    var answerLock : Bool = true
    
    @IBOutlet var playSoundButton: UIButton!
    @IBOutlet var gameImageContainer: UIView!
    @IBOutlet var firstChoiceContainer: UIView!
    @IBOutlet var firstChoiceNumberContainer: UIView!
    @IBOutlet var secondChoiceContainer: UIView!
    @IBOutlet var secondChoiceNumberContainer: UIView!
    @IBOutlet var thirdChoiceContainer: UIView!
    @IBOutlet var thirdChoiceNumberContainer: UIView!
    @IBOutlet var fourthChoiceContainer: UIView!
    @IBOutlet var fourthChoiceNumberContainer: UIView!
    var firstProgressCell: UIView! , secondProgressCell : UIView! , firstSeperator : UIView!
    var width:NSNumber!, height:NSNumber!
    
    var pointLabel  = UILabel()
    var timer = NSTimer()
    var counter = 0
    
    @IBOutlet var progressViewContainer: UIView!
    var navBar:UINavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        navBar = self.navigationController?.navigationBar
        // Do any additional setup after loading the view.
        
        initVariables()
        
        initUI()
    }
    
    
    func initUI(){
        
        firstChoiceNumberContainer.layer.cornerRadius = fourthChoiceNumberContainer.frame.height/2
        firstChoiceContainer.layer.cornerRadius = 4.0
        secondChoiceNumberContainer.layer.cornerRadius = fourthChoiceNumberContainer.frame.height/2
        secondChoiceContainer.layer.cornerRadius = 4.0
        thirdChoiceNumberContainer.layer.cornerRadius = fourthChoiceNumberContainer.frame.height/2
        thirdChoiceContainer.layer.cornerRadius = 4.0
        fourthChoiceNumberContainer.layer.cornerRadius = fourthChoiceNumberContainer.frame.height/2
        fourthChoiceContainer.layer.cornerRadius = 4.0
        gameImageContainer.layer.cornerRadius = 4.0
        
        pointLabel.text = String(counter)
        
    }
    
    func initVariables(){
        
        //initiliaze progress cells
        cellArray = [cell1,cell2,cell3,cell4,cell5,cell6,cell7,cell8,cell9,cell10]
        
        // get initial sound level
        
        var soundLevel: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("sound")
        // control initial sound value
        if(soundLevel==nil){
            
            println("No sound value !!!!!")
            NSUserDefaults.standardUserDefaults().setObject(0.5, forKey: "sound")
            NSUserDefaults.standardUserDefaults().synchronize()
            soundLevelValue = 0.5;

        }else{
            //initial sound value found
            soundLevelValue = soundLevel! as Float
            println("sound value in new Game = \(soundLevelValue)")
            }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
       
        
        prepareNavigationBar()
        
        println("orientationChanged!!!!!!!!!")
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
        
        //for logo
        let logo = UIImage(named: "logo")
        let imageView = UIImageView(image:logo)
        imageView.frame = CGRectMake(0, 0, 30, 30)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        navItem.titleView = imageView
        
        
        //for settings button
        pointLabel.textColor = UIColor.blackColor()
        pointLabel.frame  = CGRectMake(0, 0, 60, 30)
        pointLabel.textAlignment = NSTextAlignment.Center
        navItem.setRightBarButtonItem(UIBarButtonItem(customView: pointLabel), animated: true)
        navItem.hidesBackButton=true

        
    }
    
    
    @IBAction func backButtonAction(sender:UIButton) {
        println("Button Action From Code")
        var pauseScreen:NGPause = self.storyboard!.instantiateViewControllerWithIdentifier("PausedGameViewController") as NGPause
        self.title="newGame"
        pauseScreen.delegate = self
        self.presentViewController(pauseScreen, animated: true, completion: nil)
    }
    
    
    
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.All.rawValue)
    }
    
    
    
    
    @IBAction func choiceAction(sender: AnyObject) {
        
        
       // bloat()
        
        if(answerLock){
            
            
            answerLock=false
        
        
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.0025, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        
        
        if(cellCounter<cellArray.count){
            
            
            println(cellCounter)
            
            dispatch_async(dispatch_get_main_queue()) {
                self.cellArray[self.cellCounter].backgroundColor = UIColor.greenColor()
                self.cellCounter++
                
            }
            
        }
            
            }
        
    }
    
    func update(){
        
        pointLabel.text = String(counter++)
        
        if((counter%500==1) && (counter>1)){
            
            timer.invalidate()
            bloat()
            
            answerLock = true
            
        }
        
    }
    
    
    
    
    @IBAction func playSound(sender: AnyObject) {
        
        // Grab the path, make sure to add it to your project!
        var soundURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("howling", ofType: "mp3")!)
        
       
        
        
        dispatch_async(dispatch_get_main_queue()) {
            
            self.audioPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: nil)
            self.audioPlayer.volume = self.soundLevelValue
            self.audioPlayer.numberOfLoops = 1
            self.audioPlayer.prepareToPlay()
            println(self.audioPlayer.duration)
            self.audioPlayer.play()
            
            
            
            if(self.audioPlayer.playing){
                
                println("Playing....")
                
            } else {
                
                println("Not playing!!!!!!!!")
                
            }
            
            
        }

    }
    
    
    func bloat() {
        var animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = NSNumber(float: 0.9)
        animation.duration = 0.2
        animation.repeatCount = 3.0
        animation.autoreverses = true
        pointLabel.layer.addAnimation(animation, forKey: nil)
    }
    
    
    

}
