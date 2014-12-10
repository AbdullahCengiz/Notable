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

@objc class NewGameViewController: UIViewController, UITableViewDelegate {

    //for playButton
    @IBOutlet var playButton: UIButton!

    //for pointLabel
    var pointLabel = UILabel()
    //for line container
    @IBOutlet var lineContainer: UIView!

    //for questionPicture
    @IBOutlet var questionPictureImage: UIImageView!
    

    //for clefs
    @IBOutlet var gclefImage: UIImageView!
    @IBOutlet var fclefImage: UIImageView!

    //for extra ledger lines
    @IBOutlet var firstTopLine: UIView!
    @IBOutlet var secondTopLine: UIView!
    @IBOutlet var thirdTopLine: UIView!

    @IBOutlet var firstBottomLine: UIView!
    @IBOutlet var secondBottomLine: UIView!
    @IBOutlet var thirdBottomLine: UIView!

    var newGame:TrivQuiz!
    var synthLock = NSLock()
    var synth: Synth!
    var choiceButtonArray : [UIButton] = []
    var cellArray : [UIView] = []

    //for noteView
    @IBOutlet var noteView: UIView!

    //for noteLines
    @IBOutlet var firstNoteLine: UIView!
    @IBOutlet var secondNoteLine: UIView!
    @IBOutlet var thirdNoteLine: UIView!
    @IBOutlet var fourthNoteLine: UIView!
    @IBOutlet var fifthNoteLine: UIView!
    
    @IBOutlet var navItem: UINavigationItem!
    
    @IBOutlet var L1: UILabel!
    @IBOutlet var L2: UILabel!
    @IBOutlet var L3: UILabel!
    @IBOutlet var L4: UILabel!
    
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

    //for question choice buttons
    @IBOutlet var firstChoiceButton: UIButton!
    @IBOutlet var secondChoiceButton: UIButton!
    @IBOutlet var thirdChoiceButton: UIButton!
    @IBOutlet var fourthChoiceButton: UIButton!

    // for question choice numbers
    @IBOutlet var firstChoiceNumberContainer: UIView!
    @IBOutlet var firstChoiceContainer: UIView!
    @IBOutlet var secondChoiceNumberContainer: UIView!
    @IBOutlet var secondChoiceContainer: UIView!
    @IBOutlet var thirdChoiceNumberContainer: UIView!
    @IBOutlet var thirdChoiceContainer: UIView!
    @IBOutlet var fourthChoiceNumberContainer: UIView!
    @IBOutlet var fourthChoiceContainer: UIView!

    //constraints for choiceButtons
    @IBOutlet var firstChoiceNumberHeight: NSLayoutConstraint!
    @IBOutlet var firstChoiceNumberWidth: NSLayoutConstraint!
    @IBOutlet var secondChoiceNumberHeight: NSLayoutConstraint!
    @IBOutlet var secondChoiceNumberWidth: NSLayoutConstraint!
    @IBOutlet var thirdChoiceNumberHeight: NSLayoutConstraint!
    @IBOutlet var thirdChoiceNumberWidth: NSLayoutConstraint!
    @IBOutlet var fourthChoiceNumberHeight: NSLayoutConstraint!
    @IBOutlet var fourthChoiceNumberWidth: NSLayoutConstraint!
    
    

    //for rootView
    //@IBOutlet var rootView: UIView!

    @IBOutlet var viewNewGameController: UIView!
    @IBOutlet var TEMPtopindentation: UIView!

    //for noteViewContainer
    @IBOutlet var noteViewContainer: UIView!

    //for noteView Constraints
    //firstNoteLine
    @IBOutlet var firstNoteLineHeight: NSLayoutConstraint!

    
    @IBOutlet var progressViewContainer: UIView!
    var navBar:UINavigationBar!

    override func viewDidLoad() {

        super.viewDidLoad()
        navBar = self.navigationController?.navigationBar
        newGame.initGame()

    }


    func initTrivQuiz() -> TrivQuiz{


        newGame = TrivQuiz(viewController:self)

        return newGame

    }
    
    override func supportedInterfaceOrientations() -> Int {

        return Int(UIInterfaceOrientationMask.Portrait.rawValue)

    }

    /*
    func layoutEverything(x:UIView) {
        ////println("x = \(x)")
        x.layoutSubviews()
        x.backgroundColor = getRandomColor()
        for v in x.subviews as [UIView] {
            v.layoutSubviews()
            v.backgroundColor = getRandomColor()
            ////println("v = \(v)")
            if(v.subviews.count > 0) {
                self.layoutEverything(v)
            }
        }
        ////println("After for loop !!!!!")
    }
*/

       func playNotesInOrder(timer: NSTimer) {
        // Something after a delay
        var arr:AnyObject = timer.userInfo!
        var counter32:Int = arr[0] as Int
        println("playNotesInOrder and play \(counter32)")
        newGame.playNote(Int32(counter))
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //self.
        //////println("In viewWillAppear!!!")
        // waits for noteViewContainer creation
        prepareNavigationBar()
        styleView()
        newGame.setSoundValue()
        
}
    
   func styleView() {
            
        var bg:UIColor = UIColor.whiteColor()
        var btn:UIColor = UIColor.whiteColor()
        var txt:UIColor = UIColor.blackColor()
            
        Theme().fetchThemeColors(&bg, buttonColor:&btn, textColor:&txt)
        
        self.view.backgroundColor = bg
    
        self.firstChoiceNumberContainer.backgroundColor = bg
        self.secondChoiceNumberContainer.backgroundColor = bg
        self.thirdChoiceNumberContainer.backgroundColor = bg
        self.fourthChoiceNumberContainer.backgroundColor = bg
    
        self.firstChoiceButton.backgroundColor = btn
        self.secondChoiceButton.backgroundColor = btn
        self.thirdChoiceButton.backgroundColor = btn
        self.fourthChoiceButton.backgroundColor = btn
    
        self.L1.textColor = txt
        self.L2.textColor = txt
        self.L3.textColor = txt
        self.L4.textColor = txt
    
        self.firstChoiceButton.setTitleColor(txt, forState: UIControlState.Normal)
        self.secondChoiceButton.setTitleColor(txt, forState: UIControlState.Normal)
        self.thirdChoiceButton.setTitleColor(txt, forState: UIControlState.Normal)
        self.fourthChoiceButton.setTitleColor(txt, forState: UIControlState.Normal)
        }

    func prepareNavigationBar(){

        //for menubutton
        let menuImage = UIImage(named: "menu_btn") as UIImage?
        let menuButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        menuButton.frame = CGRectMake(0, 0, 25, 25)
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
        //////println("Button Action From Code")

        var pauseScreen:NGPause = self.storyboard!.instantiateViewControllerWithIdentifier("PausedGameViewController") as NGPause

        if(newGame.gameType == "practice"){
            self.title="newPractice"
        }
        else{
            self.title="newGame"
        }

        pauseScreen.delegate = self
        self.presentViewController(pauseScreen, animated: true, completion: nil)

    }

    func endPractice () {

        var pauseScreen:NGPause = self.storyboard!.instantiateViewControllerWithIdentifier("PausedGameViewController") as NGPause
        self.title="endPractice"
        pauseScreen.delegate = self
        self.presentViewController(pauseScreen, animated: true, completion: nil)

    }

    @IBAction func choiceAction(sender: AnyObject) {

        var choiceButton = sender as UIButton
        ////println("tag: \(choiceButton.tag) questionAnswerIndex= \(questions![currentQuestion].questionAnswerIndex)")

        // locks buttons
        newGame.lockButtons(true)

        ////println(choiceButton.tag)

        if(answerLock){

            //controls the answer correct or not

            //correct answer
            if(choiceButton.tag == newGame.questions![newGame.currentQuestion].questionAnswerIndex){

                //plays correct sound
                newGame.sound.playSound(newGame.sound.correctSound)

                //increments the score
                realScore = realScore+500

                //sets answer status
                answerStatus = true

                //changes color of right answer button
                choiceButton.backgroundColor = UIColor(red: 0.35686275, green: 0.80784314, blue: 0.43137255, alpha: 1.0) // true green color

                //sets answerlock
                answerLock=false

                timer = NSTimer.scheduledTimerWithTimeInterval(0.0005, target: self, selector: Selector("updateRightAnswer"), userInfo: nil, repeats: true)
                if(newGame.cellCounter<cellArray.count){

                    //////println(cellCounter)
                    dispatch_async(dispatch_get_main_queue()) {
                        self.cellArray[self.newGame.cellCounter].backgroundColor = UIColor(red: 0.35686275, green: 0.80784314, blue: 0.43137255, alpha: 1.0) // gets true green color
                        self.newGame.cellCounter++
                    }
                }
            } else {
                //wrong answer
                newGame.sound.playSound(newGame.sound.incorrectSound)

                //changes color of right answer button
                choiceButton.backgroundColor = UIColor(red: 0.94117647, green: 0.40392157, blue: 0.40392157, alpha: 1.0) // gets false red color
                choiceButtonArray[newGame.questions[newGame.currentQuestion].questionAnswerIndex].backgroundColor = UIColor(red: 0.35686275, green: 0.80784314, blue: 0.43137255, alpha: 1.0) // gets true green color

                //sets answerlock
                answerLock=false

                //sets answer status
                answerStatus = false

                if(realScore>0){
                    //decrements the score
                    realScore = realScore-100
                    timer = NSTimer.scheduledTimerWithTimeInterval(0.0005, target: self, selector: Selector("updateWrongAnswer"), userInfo: nil, repeats: true)
                
                } else {

                    answerLock = true
                    newGame.getNextQuestion(isAnswerTrue:false)
                }
            }
        }
    }


    
    @objc func updateRightAnswer(){

        newGame.updateRightAnswer()

    }

    func updateWrongAnswer(){

        newGame.updateWrongAnswer()

    }



    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {

        if(toInterfaceOrientation.rawValue==3 || toInterfaceOrientation.rawValue==4){
            
            //setLandscapeConstraints()
            
        } else {
            
            //setPortraitConstraints()
        }
        
        ////////println("to \(toInterfaceOrientation.rawValue)")
        
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        
        ////////println("from \(fromInterfaceOrientation.rawValue)")
        
        /*
        //////println("noteviewContainerLandsCapeHeight= \(noteViewContainer.frame.height)")
        //////println("noteviewContainerLandsCapeWidth= \(noteViewContainer.frame.width)")
        */
        
        /*
        //////println("firstChoiceContainerLandsCapeHeight= \(firstChoiceContainer.frame.height)")
        //////println("firstChoiceContainerLandsCapeWidth= \(firstChoiceContainer.frame.width)")
        */

    }

    func getRandomColor() -> UIColor{
        
        var randomRed:CGFloat = CGFloat(drand48())
        var randomGreen:CGFloat = CGFloat(drand48())
        var randomBlue:CGFloat = CGFloat(drand48())
        ////println("red:\(randomRed)  green:\(randomBlue) green:\(randomGreen)")

        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }

    @IBAction func TouchDown(sender: AnyObject) {

        println("questionContent = \(newGame.questions[newGame.currentQuestion].questionContent!)")

        if(countElements(newGame.questions[newGame.currentQuestion].questionContent!)<4){
            newGame.sound.playSound(SoundFile(soundName: newGame.trivNoteView.soundFileName1, soundType: "aif"))
        }
        else{

            newGame.playMajorMinorSound()

        }

    }




}
