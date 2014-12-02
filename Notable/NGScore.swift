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


class NGScore: UIViewController, UITableViewDelegate {
    
    var delegate: AnyObject?

    @IBOutlet weak var medalNamez: UILabel!
    @IBOutlet weak var medalImage: UIImageView!
    @IBOutlet weak var scoreNumber: UILabel!
    @IBOutlet var textFieldBg: UIView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var congratsView: UIView!
    @IBOutlet var sendButton: UIButton!


    var arrayOfMedals: [Medal] = []
    
    required init(coder aDecoder: NSCoder) {
        self.delegate = nil
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        congratsView.layer.cornerRadius = 4.0
        sendButton.layer.cornerRadius = 4.0
        
        
        println("in NGScoreViewController")
        
    self.navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        medalTypes()
        //medalView()
        
        
        //getting the LatestScore
        var pointLabel: Int = NSUserDefaults.standardUserDefaults().objectForKey("pointLabel") as Int
        self.scoreNumber.text  = String(pointLabel)
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
        
        var pointLabel: Int = NSUserDefaults.standardUserDefaults().objectForKey("pointLabel") as Int
        self.scoreNumber.text  = String(pointLabel)
        
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
        var nameTextField: UITextField!
            setUpPoints()
        
        if self.nameTextField.text.isEmpty {
            
            println("Name not entered!")
            
            
        } else {
            self.nameTextField.text = "\(self.nameTextField.text)"
                NSUserDefaults.standardUserDefaults().objectForKey("nameText")
                NSUserDefaults.standardUserDefaults().synchronize()
 
            
            println("entered name = \(self.nameTextField.text)")
            
            
        }
        
        // insert link to rest of code for getting it to the highscore here Frida!
        
        
        func textFieldDidEndEditing(textField: UITextField!){
            
            NSUserDefaults.standardUserDefaults().didChangeValueForKey("highscoreName")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            println("Name inserted. Woho!")
            
            
        }
        
        //Pop to MainPageControllerView
        var mNC = delegate!.navigationController as MasterNC
        mNC.popToViewControllerOfClass(MainPageViewController())
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    
    func setUpPoints(){
        
        
        var highscoreNumberGold: Int = NSUserDefaults.standardUserDefaults().integerForKey("highscoreNumberGold") as Int
        var highscoreNumberSilver: Int = NSUserDefaults.standardUserDefaults().integerForKey("highscoreNumberSilver") as Int
        var highscoreNumberBronze: Int = NSUserDefaults.standardUserDefaults().integerForKey("highscoreNumberBronze") as Int
        
        
        
        var highscoreNameGold: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("highscoreNameGold")
        var highscoreNameSilver: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("highscoreNameSilver")
        var highscoreNameBronze: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("highscoreNameBronze")

        
        
        var pointLabel: Int = NSUserDefaults.standardUserDefaults().objectForKey("pointLabel") as Int

    
        
        if (pointLabel > highscoreNumberGold){
            highscoreNumberBronze = highscoreNumberSilver
            highscoreNumberSilver = highscoreNumberGold
            highscoreNumberGold = pointLabel
            
            
            NSUserDefaults.standardUserDefaults().setObject(self.nameTextField.text, forKey: "highscoreNameGold")
            NSUserDefaults.standardUserDefaults().setObject(highscoreNameGold, forKey: "highscoreNameSilver")
            NSUserDefaults.standardUserDefaults().setObject(highscoreNameSilver, forKey: "highscoreNameBronze")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            
        }else if (pointLabel > highscoreNumberSilver){
            highscoreNumberBronze = highscoreNumberSilver
            highscoreNumberSilver = pointLabel
            
            NSUserDefaults.standardUserDefaults().setObject(self.nameTextField.text, forKey: "highscoreNameSilver")
            NSUserDefaults.standardUserDefaults().setObject(highscoreNameSilver, forKey: "highscoreNameBronze")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        else if (pointLabel > highscoreNumberBronze){
            highscoreNumberBronze = pointLabel
            
            NSUserDefaults.standardUserDefaults().setObject(self.nameTextField.text, forKey: "highscoreNameBronze")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
        
        
        NSUserDefaults.standardUserDefaults().setInteger(highscoreNumberGold, forKey: "highscoreNumberGold")
        NSUserDefaults.standardUserDefaults().synchronize()
        NSUserDefaults.standardUserDefaults().setInteger(highscoreNumberSilver, forKey: "highscoreNumberSilver")
        NSUserDefaults.standardUserDefaults().synchronize()
        NSUserDefaults.standardUserDefaults().setInteger(highscoreNumberBronze, forKey: "highscoreNumberBronze")
        NSUserDefaults.standardUserDefaults().synchronize()
        
       
        
        }


}