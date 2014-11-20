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
    
    //constant definitions
    let heightRateConstant:CGFloat = 0.73
    let widthRateConstant:CGFloat = 1.35
    
    
    //get screenWidth and height from NSUserDefaults
    let width = NSUserDefaults.standardUserDefaults().objectForKey("width") as CGFloat
    let height = NSUserDefaults.standardUserDefaults().objectForKey("height") as CGFloat
    
    //init noteViewContainerHieght
    let noteViewContainerPortraitHeight = (((NSUserDefaults.standardUserDefaults().objectForKey("height") as CGFloat)*408)/1136)
    let noteViewContainerLandscapeHeight = (((NSUserDefaults.standardUserDefaults().objectForKey("height") as CGFloat)*408)/1136)*0.73
    
    //init constraint paramaters
    //let firstNoteLinePortraitTopSpace = (((NSUserDefaults.standardUserDefaults().objectForKey("height") as CGFloat)*103)/1136)
    var firstNoteLinePortraitTopSpace:CGFloat = 0
    var firstNoteLineLandscapeTopSpace:CGFloat = 0
    
    var noteLinePortraitSpace:CGFloat = 0
    var noteLineLandscapeSpace:CGFloat = 0
    let noteLinePortraitIndentation = (((NSUserDefaults.standardUserDefaults().objectForKey("width") as CGFloat)*32)/640)
    let noteLineLandscapeIndentation = (((NSUserDefaults.standardUserDefaults().objectForKey("width") as CGFloat)*32)/640)*1.35
    
    
    var pointLabel  = UILabel()
    var timer = NSTimer()
    var counter = 0
    
    //for noteViewContainer
    @IBOutlet var noteViewContainer: UIView!
    
    //for firstChoiceContainer
    @IBOutlet var firstChoiceContainer: UIView!
    
    
    //for noteView Constraints
    //firstNoteLine
    @IBOutlet var firstNoteLineTopSpace: NSLayoutConstraint!
    @IBOutlet var firstNoteLineTrailingSpace: NSLayoutConstraint!
    @IBOutlet var firstNoteLineLeadingSpace: NSLayoutConstraint!
    @IBOutlet var firstNoteLineHeight: NSLayoutConstraint!
    
    //secondNoteLine
    @IBOutlet var secondNoteLineTopSpace: NSLayoutConstraint!

    //thirdNoteLine
    @IBOutlet var thirdNoteLineTopSpace: NSLayoutConstraint!
    
    //fourthNoteLine
    @IBOutlet var fourthNoteLineTopSpace: NSLayoutConstraint!
    
    //fifthNoteLine
    @IBOutlet var fifthNoteLineTopSpace: NSLayoutConstraint!

    
    
    
    

    @IBOutlet var progressViewContainer: UIView!
    var navBar:UINavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        navBar = self.navigationController?.navigationBar
        initVariables()
        
        
    }
    
    override func supportedInterfaceOrientations() -> Int {
    return Int(UIInterfaceOrientationMask.Portrait.rawValue)
}
    
    
    func initUI(){
        
    
        
        
        //noteViewContainer.layer.cornerRadius = 4.0
        

        /*
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
        
        prepareNoteView()
        */
        
    }
    
    func prepareNoteView(){
        
        println("noteviewContainerLandscapeRealHeight = \(noteViewContainer.frame.size.height)")
        
        
        firstNoteLineLandscapeTopSpace = ((noteViewContainer.frame.size.height*103)/408)
        println("firstNoteLineLandscapeTopSpace = \(firstNoteLineLandscapeTopSpace)")
        noteLineLandscapeSpace = (noteViewContainer.frame.size.height-(firstNoteLineLandscapeTopSpace*2+10))/4
        
        //for firstNoteView
        //println("landscapeTopSpace = \(firstNoteLineLandscapeTopSpace)")
        
        firstNoteLineTopSpace.constant = firstNoteLineLandscapeTopSpace
        firstNoteLineTrailingSpace.constant = noteLineLandscapeIndentation
        firstNoteLineHeight.constant = 2
        firstNoteLineLeadingSpace.constant = noteLineLandscapeIndentation
        
        secondNoteLineTopSpace.constant = noteLineLandscapeSpace
        thirdNoteLineTopSpace.constant = noteLineLandscapeSpace
        fourthNoteLineTopSpace.constant = noteLineLandscapeSpace
        fifthNoteLineTopSpace.constant = noteLineLandscapeSpace
        
    }
    
    
    func setPortraitConstraints(){
        
        firstNoteLinePortraitTopSpace = ((noteViewContainer.frame.size.height*103)/408)
        println(noteViewContainer.frame)
        noteLinePortraitSpace = (noteViewContainer.frame.size.height-(firstNoteLinePortraitTopSpace*2+10))/4
        
        println("noteviewContainerPortraitRealHeight = \(noteViewContainer.frame.size.height)")
        println("firstNoteLinePortraitTopSpace = \(firstNoteLinePortraitTopSpace)")
        println("noteLinePortraitSpace = \(noteLinePortraitSpace)")
        
        //for firstNoteView
        firstNoteLineTopSpace.constant = firstNoteLinePortraitTopSpace
        firstNoteLineTrailingSpace.constant = noteLinePortraitIndentation
        firstNoteLineHeight.constant = 2
        firstNoteLineLeadingSpace.constant = noteLinePortraitIndentation
        
        secondNoteLineTopSpace.constant = noteLinePortraitSpace
        thirdNoteLineTopSpace.constant = noteLinePortraitSpace
        fourthNoteLineTopSpace.constant = noteLinePortraitSpace
        fifthNoteLineTopSpace.constant = noteLinePortraitSpace
        
    }
    
    
    func initVariables(){
        
        //initiliaze progress cells
        cellArray = [cell1,cell2,cell3,cell4,cell5,cell6,cell7,cell8,cell9,cell10]
        
        // get initial sound level
        
        var soundLevel: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("sound")
        // control initial sound value
        if(soundLevel==nil){
            
            ////println("No sound value !!!!!")
            NSUserDefaults.standardUserDefaults().setObject(0.5, forKey: "sound")
            NSUserDefaults.standardUserDefaults().synchronize()
            soundLevelValue = 0.5;

        }else{
            //initial sound value found
            soundLevelValue = soundLevel! as Float
            ////println("sound value in new Game = \(soundLevelValue)")
            }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
       //println("In viewWillAppear!!!")
        noteViewContainer.layoutIfNeeded() // waits for noteViewContainer creation
        prepareNavigationBar()
        initUI()
        
        ////println("orientationChanged!!!!!!!!!")
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
        
        //for settings button
        pointLabel.textColor = UIColor.blackColor()
        pointLabel.frame  = CGRectMake(0, 0, 60, 30)
        pointLabel.textAlignment = NSTextAlignment.Center
        navItem.setRightBarButtonItem(UIBarButtonItem(customView: pointLabel), animated: true)
        navItem.hidesBackButton=true

        
    }
    
    
    @IBAction func backButtonAction(sender:UIButton) {
        //println("Button Action From Code")
        var pauseScreen:NGPause = self.storyboard!.instantiateViewControllerWithIdentifier("PausedGameViewController") as NGPause
        self.title="newGame"
        pauseScreen.delegate = self
        self.presentViewController(pauseScreen, animated: true, completion: nil)
    }
    
    
    @IBAction func choiceAction(sender: AnyObject) {
        
        
       // bloat()
        
        if(answerLock){
            
        answerLock=false
        timer = NSTimer.scheduledTimerWithTimeInterval(0.0025, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        
        
        if(cellCounter<cellArray.count){
            
            
            //println(cellCounter)
            
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
            //println(self.audioPlayer.duration)
            self.audioPlayer.play()
            
            
            
            if(self.audioPlayer.playing){
                
                //println("Playing....")
                
            } else {
                
                //println("Not playing!!!!!!!!")
                
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
    
    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        
        
        
        ////println("to \(toInterfaceOrientation.rawValue)")
        
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        
        ////println("from \(fromInterfaceOrientation.rawValue)")
        
        /*
        //println("noteviewContainerLandsCapeHeight= \(noteViewContainer.frame.height)")
        //println("noteviewContainerLandsCapeWidth= \(noteViewContainer.frame.width)")
        */
        
        /*
        //println("firstChoiceContainerLandsCapeHeight= \(firstChoiceContainer.frame.height)")
        //println("firstChoiceContainerLandsCapeWidth= \(firstChoiceContainer.frame.width)")
        */
        
    }
    

    

}
