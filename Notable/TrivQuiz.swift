//
//  TrivQuiz.swift
//  Notable
//
//  Created by abdullah cengiz on 12/11/14.
//  Copyright (c) 2014 Trivato. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import AVFoundation
import QuartzCore


var newGameVC:NewGameViewController!

var delegate:AnyObject?
var soundGenerator:SoundGenerator!
var note:UInt32!

var myPlayer = MHAudioBufferPlayer()
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

//for passing the variables from MainPageViewController
var currentQuestion: Int = 0
var currentOctav:Int = 0
var currentOctav1:Int = 0
var currentOctav2:Int = 0

var currentNoteValue:String = ""
var currentNoteValue2:String = ""
var currentNoteValue3:String = ""

var currentSharpFlatValue:Int = 0
var currentSharpFlatValue1:Int = 0
var currentSharpFlatValu2:Int = 0

var currentNote:Int32 = 0
var currentNote1:Int32 = 0
var currentNote2:Int32 = 0

var noteArray:[String] = []

var sharpFlatValueNotFound: Bool = true
var majorMinorFound: Bool = false


class TrivQuiz
{

    var trivNoteView:TrivNoteView!
    var questions : [Question]!
    var cellCounter:Int = 0


    init(viewController:NewGameViewController){

        newGameVC = viewController
        questions = []
        
    }


    func initGame(){

        initUI()
        initVariables()
        initPlayer()
        //trivNoteView.addNote(questionContent:"H4",clefType:"gClef",sharpFlatValue: -1)
        prepareGame(currentQuestion)
        
    }

    func initUI(){

        var numberCircleWidth = (((((NSUserDefaults.standardUserDefaults().objectForKey("height") as CGFloat)*1008)/1136))*42)/1008

        newGameVC.firstChoiceNumberHeight.constant = numberCircleWidth
        newGameVC.firstChoiceNumberWidth.constant = numberCircleWidth

        newGameVC.secondChoiceNumberHeight.constant = numberCircleWidth
        newGameVC.secondChoiceNumberWidth.constant = numberCircleWidth

        newGameVC.thirdChoiceNumberHeight.constant = numberCircleWidth
        newGameVC.thirdChoiceNumberWidth.constant = numberCircleWidth

        newGameVC.fourthChoiceNumberHeight.constant = numberCircleWidth
        newGameVC.fourthChoiceNumberWidth.constant = numberCircleWidth

        ////////println("firstChoiceContainer.height=!!!!!= \(firstChoiceContainer.frame.size.height)")
        ////////println("numberCircleWidth=!!!!!= \(numberCircleWidth)")

        newGameVC.firstChoiceNumberContainer.frame = CGRectMake(newGameVC.firstChoiceNumberContainer.frame.minX, newGameVC.firstChoiceNumberContainer.frame.minY, numberCircleWidth, numberCircleWidth)
        newGameVC.secondChoiceNumberContainer.frame = CGRectMake(newGameVC.secondChoiceNumberContainer.frame.minX, newGameVC.secondChoiceNumberContainer.frame.minY, numberCircleWidth, numberCircleWidth)
        newGameVC.thirdChoiceNumberContainer.frame = CGRectMake(newGameVC.thirdChoiceNumberContainer.frame.minX, newGameVC.thirdChoiceNumberContainer.frame.minY, numberCircleWidth, numberCircleWidth)
        newGameVC.fourthChoiceNumberContainer.frame = CGRectMake(newGameVC.fourthChoiceNumberContainer.frame.minX, newGameVC.fourthChoiceNumberContainer.frame.minY, numberCircleWidth, numberCircleWidth)

        newGameVC.noteViewContainer.layer.cornerRadius = 4.0
        newGameVC.firstChoiceNumberContainer.layer.cornerRadius = newGameVC.firstChoiceNumberContainer.frame.width/2
        newGameVC.firstChoiceContainer.layer.cornerRadius = 4.0
        newGameVC.secondChoiceNumberContainer.layer.cornerRadius = newGameVC.secondChoiceNumberContainer.frame.width/2
        newGameVC.secondChoiceContainer.layer.cornerRadius = 4.0
        newGameVC.thirdChoiceNumberContainer.layer.cornerRadius = newGameVC.thirdChoiceNumberContainer.frame.width/2
        newGameVC.thirdChoiceContainer.layer.cornerRadius = 4.0
        newGameVC.fourthChoiceNumberContainer.layer.cornerRadius = newGameVC.fourthChoiceNumberContainer.frame.width/2
        newGameVC.fourthChoiceContainer.layer.cornerRadius = 4.0

        newGameVC.firstChoiceButton.layer.cornerRadius = 4.0
        newGameVC.secondChoiceButton.layer.cornerRadius = 4.0
        newGameVC.thirdChoiceButton.layer.cornerRadius = 4.0
        newGameVC.fourthChoiceButton.layer.cornerRadius = 4.0
        
        pointLabel.text = String(counter)
    }


    func initVariables(){

        //init trivNoteView
        trivNoteView = TrivNoteView(noteView: newGameVC.noteView, viewController: newGameVC)

        //creates sound object
        sound = Sound()

        //initiliaze progress cells
        newGameVC.cellArray = [newGameVC.cell1,newGameVC.cell2,newGameVC.cell3,newGameVC.cell4,newGameVC.cell5,newGameVC.cell6,newGameVC.cell7,newGameVC.cell8,newGameVC.cell9,newGameVC.cell10]

        //initiliaze game buttons
        newGameVC.choiceButtonArray = [newGameVC.firstChoiceButton,newGameVC.secondChoiceButton,newGameVC.thirdChoiceButton,newGameVC.fourthChoiceButton]

        //initiliaze noteArray
        noteArray = ["C","C#","D","D#","E","F","F#","G","G#","A","A#","H"]

        // gets initial sound level
        var soundLevel: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("sound")
        // control initial sound value
        if(soundLevel==nil){

            //////////println("No sound value !!!!!")
            NSUserDefaults.standardUserDefaults().setObject(0.5, forKey: "sound")
            NSUserDefaults.standardUserDefaults().synchronize()
            soundLevelValue = 0.5;

        }else{
            //initial sound value found
            soundLevelValue = soundLevel! as Float
        }
    }


    func initPlayer(){

        var initArray : [AnyObject] = []
        initArray.append(16000) // for sample rate
        initArray.append(1) // for channels
        initArray.append(16) // for bitsPerChannel
        initArray.append(1024) // for buffer
        initArray.append(newGameVC) // for newGameViewController instance
        initArray.append(myPlayer) // for sending players' itself
        initArray.append(soundLevelValue) // for soundLevelValue
        myPlayer = myPlayer.prepare(initArray)
        myPlayer = myPlayer.runBlock(initArray)
        
    }


    func addNote(){

        var note:UIView = UIView()

        newGameVC.noteView.setTranslatesAutoresizingMaskIntoConstraints(false)
        note.setTranslatesAutoresizingMaskIntoConstraints(false)
        note.backgroundColor = UIColor.redColor()

        newGameVC.noteView.addSubview(note)

        newGameVC.noteView.alpha  = 0.5

        // //println(" (secondNoteLine.X)=\(secondNoteLine.bounds.origin.x)")
        ////println(" (secondNoteLine.maxY)=\(newGameVC.secondNoteLine.frame.maxY)")

        var noteHeight = height*(46/1136)

        newGameVC.noteView.addConstraint(NSLayoutConstraint(item:note, attribute:NSLayoutAttribute.Height,relatedBy:NSLayoutRelation.Equal, toItem: newGameVC.noteView,attribute:NSLayoutAttribute.Height, multiplier:(0.1227), constant:0))


        var heightConstraint = NSLayoutConstraint(item: note, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: note, attribute: NSLayoutAttribute.Height, multiplier: 1/1, constant: 0)

        newGameVC.noteView.addConstraint(heightConstraint)


        newGameVC.noteView.addConstraint(NSLayoutConstraint(
            item:note, attribute:.CenterX,
            relatedBy:.Equal, toItem:newGameVC.noteView,
            attribute:.CenterX, multiplier:1, constant:0))

        //println("heightConstraint == !!!!!!! \(heightConstraint.constant)")


        newGameVC.noteView.addConstraint(NSLayoutConstraint(
            item:note, attribute:.CenterY,
            relatedBy:.Equal, toItem: newGameVC.noteView,
            attribute:.CenterY, multiplier:1.125, constant:0))

    }


    func prepareGame(currentQuestion:Int){

        // ********!!!change the number of questions here!!!*********

        if (cellCounter == 10){

            var scoreScreen: NGScore = newGameVC.storyboard!.instantiateViewControllerWithIdentifier("HighScoreViewController") as NGScore
            scoreScreen.delegate = newGameVC
            newGameVC.presentViewController(scoreScreen, animated: true, completion: nil)

        }else{

            //////println("questions.count: \(questions!.count)  currentQuestionIndex = \(currentQuestion)")
            //resets current question


            //get question sound
            ////println("questionContent = \(questions![currentQuestion].questionContent!)")
            ////println("questionContent = \(questions![currentQuestion].questionAnswer!)")


            //call function with question parameter

            /*

            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
            // do some task
            dispatch_async(dispatch_get_main_queue()) {
            // update some UI
            //sleep(2)
            self.playNote(49)
            }
            }

            */
            resetQuestion(questions![currentQuestion])

            //clears colors of buttons
            newGameVC.firstChoiceButton.backgroundColor = UIColor.clearColor()
            newGameVC.secondChoiceButton.backgroundColor = UIColor.clearColor()
            newGameVC.thirdChoiceButton.backgroundColor = UIColor.clearColor()
            newGameVC.fourthChoiceButton.backgroundColor = UIColor.clearColor()

            // decide the right answers place
            let rnd = Int(arc4random_uniform(UInt32(4)))
            //////println("rightAnswer position is \(rnd)")

            // put answers to choice buttons
            for buttonCounter in 0..<newGameVC.choiceButtonArray.count {

                // puts the right answer
                if(buttonCounter == rnd){

                    newGameVC.choiceButtonArray[buttonCounter].setTitle(questions![currentQuestion].questionAnswer, forState: .Normal)
                    questions![currentQuestion].questionAnswerIndex = rnd
                    print("\(questions![currentQuestion].questionAnswer) ")
                } else {
                    // puts the other answers
                    if(!(questions![currentQuestion].questionAlternativeAnswer1Added)){

                        newGameVC.choiceButtonArray[buttonCounter].setTitle(questions![currentQuestion].questionAlternativeAnswer1, forState: .Normal)
                        questions![currentQuestion].questionAlternativeAnswer1Added = true

                        print("\(questions![currentQuestion].questionAlternativeAnswer1) ")


                    } else if(!(questions![currentQuestion].questionAlternativeAnswer2Added)){

                        newGameVC.choiceButtonArray[buttonCounter].setTitle(questions![currentQuestion].questionAlternativeAnswer2, forState: .Normal)
                        questions![currentQuestion].questionAlternativeAnswer2Added = true

                        print("\(questions![currentQuestion].questionAlternativeAnswer2) ")

                    } else if(!(questions![currentQuestion].questionAlternativeAnswer3Added)){

                        newGameVC.choiceButtonArray[buttonCounter].setTitle(questions![currentQuestion].questionAlternativeAnswer3, forState: .Normal)
                        questions![currentQuestion].questionAlternativeAnswer3Added = true
                        
                        //////println("\(questions![currentQuestion].questionAlternativeAnswer3) ")
                    }
                }
            }
            //unlocks choice buttons

            //println("questionContent = \(questions![currentQuestion].questionContent!)")

            // question with picture or not
            if((questions![currentQuestion].questionContent!.rangeOfString(".")) != nil ){
                trivNoteView.addNote(questionContent:questions![currentQuestion].questionContent! , clefType:questions![currentQuestion].questionClefType! , sharpFlatValue: currentSharpFlatValue,majorMinorFlag: false,noteIndex:1)
            }
            else {

                getNoteSoundFromQuestionContent(questions![currentQuestion].questionContent!)

            }




            //getNoteSoundFromQuestionContent("D3|F3|A3")

            lockButtons(false)
        }
    }



    func getNoteSoundFromQuestionContent(questionContent:String){

        majorMinorFound=false // reset major minor status


        //get length of question content
        var questionContentLenght:Int = (questionContent).utf16Count
        //////println("count = \(questionContentLenght)")


        for characterCounter in 0..<questionContentLenght {


            if(questionContentLenght==2){
                //basic notes


                ////println("Will find \(questionContent)")

                //get noteValue
                if (characterCounter == 0){

                    var currentNoteCharacter:String =  String(Array(questionContent)[characterCounter])


                    for currentNoteCharacterCounter in 0..<noteArray.count {

                        if(noteArray[currentNoteCharacterCounter] == currentNoteCharacter){
                            ////println("currentNoteCharacter = \(currentNoteCharacter) and currentNoteValue = \(currentNoteCharacterCounter)")
                            currentNoteValue = String(currentNoteCharacterCounter)
                            break
                        }

                    }

                    //////println("currentNoteCharacter = \(currentNoteCharacter)")
                }

                // set currentSharpFlatValue to 0
                currentSharpFlatValue  = 0

                //get octav
                if (characterCounter == questionContentLenght-1){

                    currentOctav = String(Array(questionContent)[characterCounter]).toInt()!
                    //////println("currentOctav = \(currentOctav)")
                }

            } else if (questionContentLenght==3){


                ////println("Will find \(questionContent)")


                sharpFlatValueNotFound=true

                //get noteValue
                if (characterCounter == 1){

                    var currentNoteCharacter:String =  String(Array(questionContent)[characterCounter-1])+String(Array(questionContent)[characterCounter])


                    ////println("will look for \(currentNoteCharacter)")


                    for currentNoteCharacterCounter in 0..<noteArray.count {

                        if(noteArray[currentNoteCharacterCounter] == currentNoteCharacter){
                            ////println("currentNoteCharacter = \(currentNoteCharacter) and currentNoteValue = \(currentNoteCharacterCounter)")
                            currentNoteValue = String(currentNoteCharacterCounter)
                            currentSharpFlatValue = 0
                            //sharpFlatValueNotFound = false
                            break
                        }
                    }

                    // add comment here
                    if(true){

                        ////println("will look for \(currentNoteCharacter) not found")

                        currentNoteCharacter =  String(Array(questionContent)[characterCounter-1])

                        ////println("will look for \(currentNoteCharacter)")


                        for currentNoteCharacterCounter in 0..<noteArray.count {

                            if(noteArray[currentNoteCharacterCounter] == currentNoteCharacter){
                                ////println("currentNoteCharacter = \(currentNoteCharacter) and currentNoteValue = \(currentNoteCharacterCounter)")
                                currentNoteValue = String(currentNoteCharacterCounter)
                                currentSharpFlatValue = 0


                                ////println("possibleSharpOrFlatValue = \(String(Array(questionContent)[characterCounter]))")


                                if(String(Array(questionContent)[characterCounter])=="#"){

                                    currentSharpFlatValue  = 1

                                }else{

                                    currentSharpFlatValue  = -1

                                }
                                break
                            }
                        }
                    }

                    //////println("currentNoteCharacter = \(currentNoteCharacter)")

                }

                //get octav
                if (characterCounter == questionContentLenght-1){

                    currentOctav = String(Array(questionContent)[characterCounter]).toInt()!
                    ////println("currentOctav = \(currentOctav)")

                }
            } else {

                //minor or major note

                ////println("Will find \(questionContent)")


                let minorOrMajorNoteContentArray:[NSString] = split(questionContent as String, { $0 == "|" }, maxSplit: 3, allowEmptySlices: true)

                ////println("minorOrMajorNoteContentArray = \(minorOrMajorNoteContentArray)")


                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    // do some task
                    dispatch_async(dispatch_get_main_queue()) {
                        // update some UI
                        //sleep(2)
                        self.getNoteSoundFromQuestionContent(minorOrMajorNoteContentArray[0])

                        self.trivNoteView.addNote(questionContent:minorOrMajorNoteContentArray[0] , clefType:self.questions![currentQuestion].questionClefType! , sharpFlatValue: currentSharpFlatValue,majorMinorFlag: false,noteIndex:1)


                        NSThread.sleepForTimeInterval(0.5)
                        self.getNoteSoundFromQuestionContent(minorOrMajorNoteContentArray[1])
                        self.trivNoteView.addNote(questionContent:minorOrMajorNoteContentArray[1] , clefType:self.questions![currentQuestion].questionClefType! , sharpFlatValue: currentSharpFlatValue,majorMinorFlag: false,noteIndex:2)
                        NSThread.sleepForTimeInterval(0.5)
                        self.getNoteSoundFromQuestionContent(minorOrMajorNoteContentArray[2])
                        self.trivNoteView.addNote(questionContent:minorOrMajorNoteContentArray[2] , clefType:self.questions![currentQuestion].questionClefType! , sharpFlatValue: currentSharpFlatValue,majorMinorFlag: false,noteIndex:3)
                    }
                }
                
                
                
                
                majorMinorFound=true
                break
                //currentNote  = 110
                
            }
            
            //////println(Array((questions![currentQuestion].questionContent!))[characterCounter])
            
            
            
        }
        
        
        if(!majorMinorFound){
            currentNote = getCurrentNoteValue(octav:currentOctav, noteValue:currentNoteValue.toInt()!, sharpFlatValue:currentSharpFlatValue )

            println("currentSharpFlatValue= \(currentSharpFlatValue)")
            println("Will play note \(questionContent) and noteId = \(currentNote)")

            if(countElements(questions![currentQuestion].questionContent!) < 4){
                trivNoteView.addNote(questionContent:questions![currentQuestion].questionContent! , clefType:questions![currentQuestion].questionClefType! , sharpFlatValue: currentSharpFlatValue,majorMinorFlag: false,noteIndex:1)
            }


            
            ////println("Will play note \(questionContent) and noteId = \(currentNote)")

            playNote(currentNote)
            //majorMinorFound=false
        }

    }


    func getCurrentNoteValue(#octav:Int,noteValue:Int, sharpFlatValue:Int) -> Int32 {


        ////println("sharpFlatValue!!!!!!!!!!!!!!!! = \(sharpFlatValue)")

        var value:Int32  = 0


        if(noteValue != 0 && noteValue != 11 ){

            value = 12+(octav*12)+noteValue + sharpFlatValue

        }else{
            // if noteValue is equals 0 and 11 sharpFlatValue is important and it effects octav

            if(sharpFlatValue == 0){

                value = 12+(octav*12)+noteValue + sharpFlatValue

            }
            else if(sharpFlatValue == 1 && noteValue == 11) {

                value = 12+((octav+1)*12)+noteValue+sharpFlatValue

            }
            else if(sharpFlatValue == 1 && noteValue != 11) {

                value = 12+(octav*12)+noteValue + sharpFlatValue

            }
            else if(sharpFlatValue == -1 && noteValue != 0) {

                value = 12+(octav*12)+noteValue + sharpFlatValue

            }
            else if(sharpFlatValue == -1 && noteValue == 0) {
                
                value = 12+((octav-1)*12)+noteValue+sharpFlatValue
                
            }
        }
        
        ////println("noteValue = \(value)")
        
        return value
        
    }



    func resetQuestion(question:Question){

        question.questionAlternativeAnswer1Added = false
        question.questionAlternativeAnswer2Added = false
        question.questionAlternativeAnswer3Added = false

    }


    func lockButtons(status:Bool){

        for choiceButton in newGameVC.choiceButtonArray {

            if(status){
                choiceButton.enabled = false
            } else {

                choiceButton.enabled = true
            }
        }
    }


    
    func getNextQuestion(#isAnswerTrue:Bool){
        var arr = [isAnswerTrue]
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.75, target: self, selector: Selector("nextQuestion"), userInfo: arr, repeats: false)
    }

    @objc func nextQuestion() {

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


    @objc func updateRightAnswer(){

        pointLabel.text = String(counter++)

        if(counter==realScore){

            pointLabel.text = String(realScore)

            //////println("counter = \(counter) realScore = \(realScore)")

            timer.invalidate()
            bloat()

            answerLock = true
            getNextQuestion(isAnswerTrue:true)
            NSUserDefaults.standardUserDefaults().setInteger(realScore, forKey: "pointLabel")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }

    @objc func updateWrongAnswer(){

        pointLabel.text = String(counter--)

        if(counter==realScore){

            pointLabel.text = String(realScore)
            //////println("counter = \(counter) realScore = \(realScore)")
            counter=realScore
            timer.invalidate()
            bloat()
            answerLock = true
            getNextQuestion(isAnswerTrue:false)
            NSUserDefaults.standardUserDefaults().setInteger(realScore, forKey: "pointLabel")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }


    @objc func bloat() {
        var animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = NSNumber(float: 0.9)
        animation.duration = 0.2
        animation.repeatCount = 3.0
        animation.autoreverses = true
        pointLabel.layer.addAnimation(animation, forKey: nil)
    }



    func playNote(noteId:Int32){

        ////println("in play note")

        newGameVC.synthLock.lock()
        newGameVC.synth.playNote(noteId)
        newGameVC.synthLock.unlock()

        /*
        if(noteId<90){
        sleep(1)
        playNote(49)
        }
        */
    }





    
    
}