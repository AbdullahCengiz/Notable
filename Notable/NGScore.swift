//
//  NGScore.swift
//  Notable
//
//  Created by Frida Samuelsson on 25/11/14.
//  Copyright (c) 2014 Trivato. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import AVFoundation


class NGScore: UIViewController, UITextFieldDelegate {

    //for bottom space constraints (for moving keyboard up when keyboard is opened)
    @IBOutlet var bottomSpace: NSLayoutConstraint!

    //for top space constraints (for moving keyboard up when keyboard is opened)
    @IBOutlet var topSpace: NSLayoutConstraint!

    //get screenWidth and height from NSUserDefaults
    let width = NSUserDefaults.standardUserDefaults().objectForKey("width") as CGFloat
    let height = NSUserDefaults.standardUserDefaults().objectForKey("height") as CGFloat

    var textViewMoveValue:CGFloat!

    
    var delegate: AnyObject?
    var timer:NSTimer!
    var sound = Sound()
    var audioPlayer = AVAudioPlayer()

    @IBOutlet var congrats: UILabel!
    @IBOutlet var yourScoreIs: UILabel!
    @IBOutlet weak var medalNamez: UILabel!
    @IBOutlet weak var medalImage: UIImageView!
    @IBOutlet weak var scoreNumber: UILabel!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var root: UIView!


    var frameView: UIView!


    var arrayOfMedals: [Medal] = []
    var counter = 0
    var realScore = 0
    var pointLabel: Int = NSUserDefaults.standardUserDefaults().objectForKey("pointLabel") as Int
    
    required init(coder aDecoder: NSCoder) {
        self.delegate = nil
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendButton.layer.cornerRadius = 4.0

        nameTextField.delegate = self
        nameTextField.autocorrectionType = UITextAutocorrectionType.No

        allFonts()
        
        println("in NGScoreViewController")
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)

        self.frameView = UIView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))


        // Keyboard stuff.
        var center: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

        //calculate move up value
        textViewMoveValue = (height*375)/1136 as CGFloat

      }

    func keyboardWillShow(notification: NSNotification) {

        bottomSpace.constant = bottomSpace.constant + textViewMoveValue
        topSpace.constant = topSpace.constant - textViewMoveValue
        println("Keyboard will be shown")

        var info:NSDictionary = notification.userInfo!
        var keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as NSValue).CGRectValue()

        var keyboardHeight:CGFloat = keyboardSize.height

        var animationDuration:CGFloat = info[UIKeyboardAnimationDurationUserInfoKey] as CGFloat

        UIView.animateWithDuration(0.25, delay: 0.25, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.frameView.frame = CGRectMake(0, (self.frameView.frame.origin.y - keyboardHeight), self.view.bounds.width, self.view.bounds.height)
            }, completion: nil)

    }

    func keyboardWillHide(notification: NSNotification) {

        bottomSpace.constant = bottomSpace.constant - textViewMoveValue
        topSpace.constant = topSpace.constant + textViewMoveValue
        println("Keyboard will be hidden")

        var info:NSDictionary = notification.userInfo!
        var keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as NSValue).CGRectValue()

        var keyboardHeight:CGFloat = keyboardSize.height

        var animationDuration:CGFloat = info[UIKeyboardAnimationDurationUserInfoKey] as CGFloat

        UIView.animateWithDuration(0.25, delay: 0.25, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.frameView.frame = CGRectMake(0, (self.frameView.frame.origin.y + keyboardHeight), self.view.bounds.width, self.view.bounds.height)
            }, completion: nil)

    }


    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        medalTypes()
        styleView()
        //medalView()
        scoreCountDown()
        
        //getting the LatestScore
       
        self.scoreNumber.text  = String(pointLabel)

        setFontSizes()
        sound.playSound(sound.drumrollSound,repeat:true)
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self,
            selector: Selector("scoreCountDown"), userInfo: nil, repeats: true)
        }


    func setFontSizes(){

        let TRI_ISIPHONE = UIDevice.currentDevice().userInterfaceIdiom == .Phone;
        let TRI_ISIPAD = UIDevice.currentDevice().userInterfaceIdiom == .Pad;

        if(TRI_ISIPAD){

            congrats.font = UIFont (name: "Roboto-Thin", size: 82)

            yourScoreIs.font = UIFont (name: "Roboto-Thin", size: 22)

            scoreNumber.font = UIFont (name: "Roboto-Thin", size: 82)

            medalNamez.font = UIFont (name: "Roboto-Thin", size: 22)

        }else{

            congrats.font = UIFont (name: "Roboto-Thin", size: 52)

            yourScoreIs.font = UIFont (name: "Roboto-Thin", size: 15)

            scoreNumber.font = UIFont (name: "Roboto-Thin", size: 52)

            medalNamez.font = UIFont (name: "Roboto-Thin", size: 15)


        }

    }
    
    
    func styleView() {
        
        var bg:UIColor = UIColor.whiteColor()
        var btn:UIColor = UIColor.whiteColor()
        var txt:UIColor = UIColor.blackColor()
        Theme().fetchThemeColors(&bg, buttonColor:&btn, textColor:&txt)


        self.sendButton.setTitleColor(txt, forState: UIControlState.Normal)
        self.medalNamez.textColor = txt
        self.scoreNumber.textColor = txt
        self.congrats.textColor = txt
        self.yourScoreIs.textColor = txt

        self.root.backgroundColor = bg


        //get selected theme
        var selectedTheme: Int = NSUserDefaults.standardUserDefaults().objectForKey("selectedTheme") as Int

        if(selectedTheme == 0){

            self.sendButton.backgroundColor = UIColor.whiteColor()

        }
        else{

            self.sendButton.backgroundColor = UIColor(red:76/255.0, green:76/255.0, blue:76/255.0, alpha:1.0)
        }

    }
    
    func showFromRect(_rect: CGRect, inView view: UIView!, animated: Bool)(nameTextField: UITextField){
        
        var delegate: UIActionSheet
    }

    func setColor(#backgroundColor:UIColor){
        
        self.view.backgroundColor = backgroundColor
    }
    
    func setMedal(#image: String){
        var defaults = NSUserDefaults()
        self.medalImage.image = UIImage(named: image)

    }
    
    func medalView() {
        let anyMedal: UIImageView = self.medalImage,
        currentMedal = arrayOfMedals[0]
        setMedal(image: currentMedal.medalImage)
    }
    
    func medalTypes() {
        
        arrayOfMedals.removeAll(keepCapacity: false)
        
        var highscoreNumberGold: Int = NSUserDefaults.standardUserDefaults().integerForKey("highscoreNumberGold") as Int
        var highscoreNumberSilver: Int = NSUserDefaults.standardUserDefaults().integerForKey("highscoreNumberSilver") as Int
        var highscoreNumberBronze: Int = NSUserDefaults.standardUserDefaults().integerForKey("highscoreNumberBronze") as Int
        
        var med1: Medal  = Medal(medalNamez: "GOLD MEDAL", medalImage: "Gold.png")
        var med2: Medal  = Medal(medalNamez: "SILVER MEDAL", medalImage: "Silver.png")
        var med3: Medal  = Medal(medalNamez: "BRONZE MEDAL", medalImage: "Bronze.png")
        
        var medalNamez:String = ""
        
        if(pointLabel >= highscoreNumberGold){
           
            medalNamez = "Gold.png"
            self.medalNamez.text = "GOLD MEDAL"
            self.nameTextField.hidden = false
            
        } else if(pointLabel >= highscoreNumberSilver){
           
            medalNamez = "Silver.png"
            self.medalNamez.text = "SILVER MEDAL"
            self.nameTextField.hidden = false
            
        } else if(pointLabel >= highscoreNumberBronze){
            
            medalNamez = "Bronze.png"
             self.medalNamez.text = "BRONZE MEDAL"
             self.nameTextField.hidden = false
            
        } else {
            
            medalNamez = "medal_no.png"
            self.medalNamez.text = "No medal"
            self.nameTextField.hidden = true
            
            }
        
        setMedal(image: medalNamez)
    }

    
      @IBAction func sendButton(sender: UIButton) {

        scoreMainFunction()

    }
    
    func scoreCountDown() {
        counter = counter + 10
        scoreNumber.text = "\(String(counter))p"
        println("counter=\(counter) pointLabel = \(pointLabel)")

        if(counter==pointLabel){
            
           scoreNumber.text = "\(String(pointLabel))p"
            
            timer!.invalidate()
            sound.audioPlayer.stop()
            
            NSUserDefaults.standardUserDefaults().setInteger(realScore, forKey: "pointLabel")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    func setUpPoints(){
        
        
        var highscoreNumberGold: Int = NSUserDefaults.standardUserDefaults().integerForKey("highscoreNumberGold") as Int
        var highscoreNumberSilver: Int = NSUserDefaults.standardUserDefaults().integerForKey("highscoreNumberSilver") as Int
        var highscoreNumberBronze: Int = NSUserDefaults.standardUserDefaults().integerForKey("highscoreNumberBronze") as Int
        
        var highscoreNameGold: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("highscoreNameGold")
        var highscoreNameSilver: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("highscoreNameSilver")
        var highscoreNameBronze: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("highscoreNameBronze")

        println("pointlabel=!!!!!!! : \(pointLabel)")
        
        
        if (pointLabel >= highscoreNumberGold){
            highscoreNumberBronze = highscoreNumberSilver
            highscoreNumberSilver = highscoreNumberGold
            highscoreNumberGold = pointLabel
            
            NSUserDefaults.standardUserDefaults().setObject(self.nameTextField.text, forKey: "highscoreNameGold")
            NSUserDefaults.standardUserDefaults().setObject(highscoreNameGold, forKey: "highscoreNameSilver")
            NSUserDefaults.standardUserDefaults().setObject(highscoreNameSilver, forKey: "highscoreNameBronze")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            
        } else if (pointLabel >= highscoreNumberSilver){
            highscoreNumberBronze = highscoreNumberSilver
            highscoreNumberSilver = pointLabel
            
            NSUserDefaults.standardUserDefaults().setObject(self.nameTextField.text, forKey: "highscoreNameSilver")
            NSUserDefaults.standardUserDefaults().setObject(highscoreNameSilver, forKey: "highscoreNameBronze")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        } else if (pointLabel >= highscoreNumberBronze) {
            highscoreNumberBronze = pointLabel
            
            NSUserDefaults.standardUserDefaults().setObject(self.nameTextField.text, forKey: "highscoreNameBronze")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        NSUserDefaults.standardUserDefaults().setInteger(highscoreNumberGold, forKey: "highscoreNumberGold")
        NSUserDefaults.standardUserDefaults().setInteger(highscoreNumberSilver, forKey: "highscoreNumberSilver")
        NSUserDefaults.standardUserDefaults().setInteger(highscoreNumberBronze, forKey: "highscoreNumberBronze")
        NSUserDefaults.standardUserDefaults().setInteger(pointLabel, forKey: "pointLabel")
        NSUserDefaults.standardUserDefaults().synchronize()
        }


    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        scoreMainFunction()
        return true
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }


    func scoreMainFunction(){



            var characterCounter = 0


            for char in self.nameTextField.text {

                if(char != " "){
                    characterCounter++
                }
            }
            
            
            println("characterCounter = \(characterCounter)")


            if(characterCounter > 0){

                setUpPoints()
                self.nameTextField.text = "\(self.nameTextField.text)"
                NSUserDefaults.standardUserDefaults().objectForKey("nameText")
                NSUserDefaults.standardUserDefaults().synchronize()
                println("entered name = \(self.nameTextField.text)")
                println("Name inserted. Woho!")

                //Pop to MainPageControllerView
                var mNC = delegate!.navigationController as MasterNC
                mNC.popToViewControllerOfClass(MainPageViewController())
                self.dismissViewControllerAnimated(true, completion: {})
                
            }
            else{

                JLToast.makeText("Please enter a name.").show()

            }
            


        // insert link to rest of code for getting it to the highscore here Frida!
        


    }



    func allFonts(){

        for family in UIFont.familyNames(){

            println(family)


            for name in UIFont.fontNamesForFamilyName(family.description)
            {
                println("  \(name)")
            }
            
        }
        
    }



}