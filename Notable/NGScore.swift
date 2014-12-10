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
    
    var delegate: AnyObject?
    var timer:NSTimer!
    var sound = Sound()
    var audioPlayer = AVAudioPlayer()

    @IBOutlet var p: UILabel!
    @IBOutlet var congrats: UILabel!
    @IBOutlet var yourScoreIs: UILabel!
    @IBOutlet weak var medalNamez: UILabel!
    @IBOutlet weak var medalImage: UIImageView!
    @IBOutlet weak var scoreNumber: UILabel!
    @IBOutlet var textFieldBg: UIView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var congratsView: UIView!
    @IBOutlet var sendButton: UIButton!


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
        congratsView.layer.cornerRadius = 4.0
        sendButton.layer.cornerRadius = 4.0

        nameTextField.delegate = self
        nameTextField.autocorrectionType = UITextAutocorrectionType.No
        
        
        println("in NGScoreViewController")
        
    self.navigationController?.setNavigationBarHidden(false, animated: true)
   /*
        var timer = NSTimer()
    timer = NSTimer.scheduledTimerWithTimeInterval(0.0005, target: self, selector: Selector("pointLabel"), userInfo: nil, repeats: true)
*/
        
        
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
        
        sound.playSound(sound.drumrollSound,repeat:true)
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self,
            selector: Selector("scoreCountDown"), userInfo: nil, repeats: true)
        }
    
    
    func styleView() {
        
        var bg:UIColor = UIColor.whiteColor()
        var btn:UIColor = UIColor.whiteColor()
        var txt:UIColor = UIColor.blackColor()
        Theme().fetchThemeColors(&bg, buttonColor:&btn, textColor:&txt)
        
        self.textFieldBg.backgroundColor = bg
        self.sendButton.backgroundColor = bg
        
        self.congratsView.backgroundColor = btn
        
        self.sendButton.setTitleColor(txt, forState: UIControlState.Normal)
        self.medalNamez.textColor = txt
        self.scoreNumber.textColor = txt
        self.congrats.textColor = txt
        self.yourScoreIs.textColor = txt
        self.p.textColor = txt
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
        
        var med1: Medal  = Medal(medalNamez: "Gold medal", medalImage: "Gold.png")
        var med2: Medal  = Medal(medalNamez: "Silver medal", medalImage: "Silver.png")
        var med3: Medal  = Medal(medalNamez: "Bronze medal", medalImage: "Bronze.png")
        
        var medalNamez:String = ""
        
        if(pointLabel >= highscoreNumberGold){
           
            medalNamez = "Gold.png"
            self.medalNamez.text = "Gold medal"
            self.nameTextField.hidden = false
            
        } else if(pointLabel >= highscoreNumberSilver){
           
            medalNamez = "Silver.png"
            self.medalNamez.text = "Silver medal"
            self.nameTextField.hidden = false
            
        } else if(pointLabel >= highscoreNumberBronze){
            
            medalNamez = "Bronze.png"
             self.medalNamez.text = "Bronze medal"
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
        scoreNumber.text = String(counter)
        
        println("counter=\(counter) pointLabel = \(pointLabel)")

        if(counter==pointLabel){
            
           scoreNumber.text = String(pointLabel)
            
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


    func scoreMainFunction(){


        setUpPoints()



        if self.nameTextField.text.isEmpty {

            println("Name not entered!")

            if(self.nameTextField.hidden){
                //Pop to MainPageControllerView
                var mNC = delegate!.navigationController as MasterNC
                mNC.popToViewControllerOfClass(MainPageViewController())
                self.dismissViewControllerAnimated(true, completion: {})
            }
            else{

                 JLToast.makeText("Please enter a name.").show()

            }

        } else {

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

        // insert link to rest of code for getting it to the highscore here Frida!
        


    }

}