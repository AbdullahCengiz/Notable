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

class NewGameViewController: UIViewController, UITableViewDelegate {
    
    var delegate:AnyObject?
    var soundGenerator:SoundGenerator!
    var note:UInt32!
    
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
    
    var cellArray : [UIView] = []
    var choiceButtonArray : [UIButton] = []
    var player = MHAudioBufferPlayer()

    var cellCounter:Int = 0
    var audioPlayer = AVAudioPlayer()
    var soundLevelValue : Float!
    var sound : Sound!
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
    var realScore = 0
    var answerStatus : Bool = false

    //for rootView
    //@IBOutlet var rootView: UIView!

    @IBOutlet var viewNewGameController: UIView!
    @IBOutlet var TEMPtopindentation: UIView!

    //for noteViewContainer
    @IBOutlet var noteViewContainer: UIView!

    //for noteView Constraints
    //firstNoteLine
    @IBOutlet var firstNoteLineHeight: NSLayoutConstraint!

    //for passing the variables from MainPageViewController
    var questions : [Question]?
    var currentQuestion: Int = 0

    @IBOutlet var progressViewContainer: UIView!
    var navBar:UINavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        navBar = self.navigationController?.navigationBar
        initUI()
        initVariables()

        prepareGame(currentQuestion)

        println("NumberOfQuestions: \(questions!.count)")
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }

    func layoutEverything(x:UIView) {
        println("x = \(x)")
        x.layoutSubviews()
        x.backgroundColor = getRandomColor()
        for v in x.subviews as [UIView] {
            v.layoutSubviews()
            v.backgroundColor = getRandomColor()
            println("v = \(v)")
            if(v.subviews.count > 0) {
                self.layoutEverything(v)
            }
        }
        println("After for loop !!!!!")
    }

    func initUI(){

        var numberCircleWidth = (((((NSUserDefaults.standardUserDefaults().objectForKey("height") as CGFloat)*1008)/1136))*42)/1008

        firstChoiceNumberHeight.constant = numberCircleWidth
        firstChoiceNumberWidth.constant = numberCircleWidth

        secondChoiceNumberHeight.constant = numberCircleWidth
        secondChoiceNumberWidth.constant = numberCircleWidth

        thirdChoiceNumberHeight.constant = numberCircleWidth
        thirdChoiceNumberWidth.constant = numberCircleWidth

        fourthChoiceNumberHeight.constant = numberCircleWidth
        fourthChoiceNumberWidth.constant = numberCircleWidth

        //println("firstChoiceContainer.height=!!!!!= \(firstChoiceContainer.frame.size.height)")
        //println("numberCircleWidth=!!!!!= \(numberCircleWidth)")

        firstChoiceNumberContainer.frame = CGRectMake(firstChoiceNumberContainer.frame.minX, firstChoiceNumberContainer.frame.minY, numberCircleWidth, numberCircleWidth)
        secondChoiceNumberContainer.frame = CGRectMake(secondChoiceNumberContainer.frame.minX, secondChoiceNumberContainer.frame.minY, numberCircleWidth, numberCircleWidth)
        thirdChoiceNumberContainer.frame = CGRectMake(thirdChoiceNumberContainer.frame.minX, thirdChoiceNumberContainer.frame.minY, numberCircleWidth, numberCircleWidth)
        fourthChoiceNumberContainer.frame = CGRectMake(fourthChoiceNumberContainer.frame.minX, fourthChoiceNumberContainer.frame.minY, numberCircleWidth, numberCircleWidth)

        noteViewContainer.layer.cornerRadius = 4.0
        firstChoiceNumberContainer.layer.cornerRadius = firstChoiceNumberContainer.frame.width/2
        firstChoiceContainer.layer.cornerRadius = 4.0
        secondChoiceNumberContainer.layer.cornerRadius = secondChoiceNumberContainer.frame.width/2
        secondChoiceContainer.layer.cornerRadius = 4.0
        thirdChoiceNumberContainer.layer.cornerRadius = thirdChoiceNumberContainer.frame.width/2
        thirdChoiceContainer.layer.cornerRadius = 4.0
        fourthChoiceNumberContainer.layer.cornerRadius = fourthChoiceNumberContainer.frame.width/2
        fourthChoiceContainer.layer.cornerRadius = 4.0

        firstChoiceButton.layer.cornerRadius = 4.0
        secondChoiceButton.layer.cornerRadius = 4.0
        thirdChoiceButton.layer.cornerRadius = 4.0
        fourthChoiceButton.layer.cornerRadius = 4.0

        pointLabel.text = String(counter)
    }

    func prepareGame(currentQuestion:Int){

        println("cellCounter = \(cellCounter)")

        if (self.cellCounter == 10){

        var scoreScreen: NGScore = self.storyboard!.instantiateViewControllerWithIdentifier("HighScoreViewController") as NGScore
                        
            scoreScreen.delegate = self
                        
            self.presentViewController(scoreScreen, animated: true, completion: nil)


            /* println("Finish game !!!!")
            var pauseScreen:NGPause = self.storyboard!.instantiateViewControllerWithIdentifier("PausedGameViewController") as NGPause
            self.title="newGame"
            pauseScreen.delegate = self
            self.presentViewController(pauseScreen, animated: true, completion: nil) */

        } else {
            
            println("questions.count: \(questions!.count)  currentQuestionIndex = \(currentQuestion)")
            //resets current question
            
            resetQuestion(questions![currentQuestion])

            //clears colors of buttons
            firstChoiceButton.backgroundColor = UIColor.clearColor()
            secondChoiceButton.backgroundColor = UIColor.clearColor()
            thirdChoiceButton.backgroundColor = UIColor.clearColor()
            fourthChoiceButton.backgroundColor = UIColor.clearColor()

            // decide the right answers place
            let rnd = Int(arc4random_uniform(UInt32(4)))
            println("rightAnswer position is \(rnd)")

            // put answers to choice buttons
            for buttonCounter in 0..<choiceButtonArray.count {

                // puts the right answer
                if(buttonCounter == rnd){

                    choiceButtonArray[buttonCounter].setTitle(questions![currentQuestion].questionAnswer, forState: .Normal)
                    questions![currentQuestion].questionAnswerIndex = rnd
                    print("\(questions![currentQuestion].questionAnswer) ")
                } else {
                    // puts the other answers
                    if(!(questions![currentQuestion].questionAlternativeAnswer1Added)){

                        choiceButtonArray[buttonCounter].setTitle(questions![currentQuestion].questionAlternativeAnswer1, forState: .Normal)
                        questions![currentQuestion].questionAlternativeAnswer1Added = true

                        print("\(questions![currentQuestion].questionAlternativeAnswer1) ")


                    } else if(!(questions![currentQuestion].questionAlternativeAnswer2Added)){

                        choiceButtonArray[buttonCounter].setTitle(questions![currentQuestion].questionAlternativeAnswer2, forState: .Normal)
                        questions![currentQuestion].questionAlternativeAnswer2Added = true

                        print("\(questions![currentQuestion].questionAlternativeAnswer2) ")

                    } else if(!(questions![currentQuestion].questionAlternativeAnswer3Added)){

                        choiceButtonArray[buttonCounter].setTitle(questions![currentQuestion].questionAlternativeAnswer3, forState: .Normal)
                        questions![currentQuestion].questionAlternativeAnswer3Added = true

                        println("\(questions![currentQuestion].questionAlternativeAnswer3) ")
                    }
                }
            }
            //unlocks choice buttons
            lockButtons(false)
        }
    }

    func resetQuestion(question:Question){

        question.questionAlternativeAnswer1Added = false
        question.questionAlternativeAnswer2Added = false
        question.questionAlternativeAnswer3Added = false
    }

    func initVariables(){

        //creates sound object
        sound = Sound()

        //initiliaze progress cells
        cellArray = [cell1,cell2,cell3,cell4,cell5,cell6,cell7,cell8,cell9,cell10]

        ////initiliaze game buttons
        choiceButtonArray = [firstChoiceButton,secondChoiceButton,thirdChoiceButton,fourthChoiceButton]

        // gets initial sound level
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
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //self.
        //println("In viewWillAppear!!!")
        // waits for noteViewContainer creation
        prepareNavigationBar()
        var pointLabel: Int = NSUserDefaults.standardUserDefaults().objectForKey("pointLabel") as Int
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
        //println("Button Action From Code")
        var pauseScreen:NGPause = self.storyboard!.instantiateViewControllerWithIdentifier("PausedGameViewController") as NGPause
        self.title="newGame"
        pauseScreen.delegate = self
        self.presentViewController(pauseScreen, animated: true, completion: nil)
    }

    @IBAction func choiceAction(sender: AnyObject) {

        var choiceButton = sender as UIButton

        println("tag: \(choiceButton.tag) questionAnswerIndex= \(questions![currentQuestion].questionAnswerIndex)")

        // locks buttons
        lockButtons(true)

        println(choiceButton.tag)

        if(answerLock){

            //controls the answer correct or not

            //correct answer
            if(choiceButton.tag == questions![currentQuestion].questionAnswerIndex){

                //plays correct sound
                sound.playSound(sound.correctSound)

                //increments the score
                realScore = realScore+500

                //sets answer status
                answerStatus = true

                //changes color of right answer button
                choiceButton.backgroundColor = UIColor(red: 0.35686275, green: 0.80784314, blue: 0.43137255, alpha: 1.0) // true green color

                //sets answerlock
                answerLock=false

                timer = NSTimer.scheduledTimerWithTimeInterval(0.0005, target: self, selector: Selector("updateRightAnswer"), userInfo: nil, repeats: true)
                if(cellCounter<cellArray.count){

                    //println(cellCounter)

                    dispatch_async(dispatch_get_main_queue()) {
                        self.cellArray[self.cellCounter].backgroundColor = UIColor(red: 0.35686275, green: 0.80784314, blue: 0.43137255, alpha: 1.0) // gets true green color
                        self.cellCounter++
                    }
                }
            } else {
                //wrong answer
                sound.playSound(sound.incorrectSound)

                //changes color of right answer button
                choiceButton.backgroundColor = UIColor(red: 0.94117647, green: 0.40392157, blue: 0.40392157, alpha: 1.0) // gets false red color

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
                    getNextQuestion(isAnswerTrue:false)
                }
            }
        }
    }

    func lockButtons(status:Bool){

        for choiceButton in choiceButtonArray {

            if(status){
                choiceButton.enabled = false
            } else {

                choiceButton.enabled = true
            }
        }
    }

    func updateRightAnswer(){

        pointLabel.text = String(counter++)

        if(counter==realScore){

            pointLabel.text = String(realScore)

            println("counter = \(counter) realScore = \(realScore)")

            timer.invalidate()
            bloat()

            answerLock = true

            getNextQuestion(isAnswerTrue:true)

            NSUserDefaults.standardUserDefaults().setInteger(realScore, forKey: "pointLabel")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }

    func updateWrongAnswer(){

        pointLabel.text = String(counter--)

        if(counter==realScore){

            pointLabel.text = String(realScore)
            println("counter = \(counter) realScore = \(realScore)")
            counter=realScore
            timer.invalidate()
            bloat()
            answerLock = true

            getNextQuestion(isAnswerTrue:false)

            NSUserDefaults.standardUserDefaults().setInteger(realScore, forKey: "pointLabel")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }

    func getNextQuestion(#isAnswerTrue:Bool){
        var arr = [isAnswerTrue]
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.75, target: self, selector: Selector("nextQuestion"), userInfo: arr, repeats: false)
    }

    func nextQuestion() {

        if(answerStatus){
            //answer is true

            //removes current question from questions array
            questions!.removeAtIndex(currentQuestion)

            //prepares gameview for next question
            prepareGame(currentQuestion)
            
        } else {

            //answer is false
            if(currentQuestion+1 < questions!.count-1){
                currentQuestion++
                //prepares gameview for next question
                prepareGame(currentQuestion)
                
            } else {
                
                //prepares gameview for next question
                currentQuestion = 0
                prepareGame(currentQuestion)
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

        if(toInterfaceOrientation.rawValue==3 || toInterfaceOrientation.rawValue==4){
            
            //setLandscapeConstraints()
            
        } else {
            
            //setPortraitConstraints()
        }
        
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

    func getRandomColor() -> UIColor{
        
        var randomRed:CGFloat = CGFloat(drand48())
        var randomGreen:CGFloat = CGFloat(drand48())
        var randomBlue:CGFloat = CGFloat(drand48())
        println("red:\(randomRed) green:\(randomBlue) green:\(randomGreen)")

        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
}

@IBAction func testButton(sender: UIButton) {

//ABDULLAH - You can use the testbutton now!

    }

    func initPlayer(){

        var initDictionary = NSDictionary()

    //var x =  player.prepare()
    //println(player.audioFormat)
    //initPlayer()
    }
}