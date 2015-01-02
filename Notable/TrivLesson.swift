//
//  TrivLesson.swift
//  Notable
//
//  Created by abdullah cengiz on 14/12/14.
//  Copyright (c) 2014 Trivato. All rights reserved.
//

import Foundation

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





class TrivLesson
{

    var trivLessonNoteView:TrivLessonNoteView!
    var questions : [LessonQuestion]!
    var sound : Sound!
    var majorMinorFound: Bool = false
    var currentQuestion: Int = 0
    var replayMajorMinorFlag:Bool = true
    var newLessonVC:LessonDetailViewController!
    var currentLessonQuestion : LessonQuestion!


    init(viewController:LessonDetailViewController){

        newLessonVC = viewController
        questions = []
        //creates sound object
        sound = Sound()
        currentQuestion = 0

    }


    func initLesson(){

        initUI()
        initVariables()
        setSoundValue()
        prepareQuestion(currentQuestion)

    }

    func initUI(){


    }

    func inOrder(s1: String, s2: String) -> Bool {
        return s1 < s2
    }


    func initVariables(){

        //init trivNoteView
        println(newLessonVC)
        println(newLessonVC.noteView)

        trivLessonNoteView = TrivLessonNoteView(noteView: newLessonVC.noteView, viewController: newLessonVC,newLesson:self)

        //initiliaze noteArray
        noteArray = ["C","C#","D","D#","E","F","F#","G","G#","A","A#","H"]
        setSoundValue()

    }

    func setSoundValue(){

        println("in set sound value !!!!!!!")

        // gets initial sound level
        var soundLevel: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("sound")
        // control initial sound value
        if(soundLevel==nil){

            println("in sound value is nil !!!!!!!")
            NSUserDefaults.standardUserDefaults().setObject(0.5, forKey: "sound")
            NSUserDefaults.standardUserDefaults().synchronize()
            soundLevelValue = 0.5;

        }else{

            //initial sound value found
            soundLevelValue = soundLevel! as Float

        }

        sound.setSoundVolume(soundLevelValue)

    }


    func addNote(){

        var note:UIView = UIView()

        newGameVC.noteView.setTranslatesAutoresizingMaskIntoConstraints(false)
        note.setTranslatesAutoresizingMaskIntoConstraints(false)
        note.backgroundColor = UIColor.redColor()

        newGameVC.noteView.addSubview(note)

        var noteHeight = height*(46/1136)

        newGameVC.noteView.addConstraint(NSLayoutConstraint(item:note, attribute:NSLayoutAttribute.Height,relatedBy:NSLayoutRelation.Equal, toItem: newGameVC.noteView,attribute:NSLayoutAttribute.Height, multiplier:(0.1227), constant:0))


        var heightConstraint = NSLayoutConstraint(item: note, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: note, attribute: NSLayoutAttribute.Height, multiplier: 1/1, constant: 0)

        newGameVC.noteView.addConstraint(heightConstraint)

        newGameVC.noteView.addConstraint(NSLayoutConstraint(
            item:note, attribute:.CenterX,
            relatedBy:.Equal, toItem:newGameVC.noteView,
            attribute:.CenterX, multiplier:1, constant:0))

        newGameVC.noteView.addConstraint(NSLayoutConstraint(
            item:note, attribute:.CenterY,
            relatedBy:.Equal, toItem: newGameVC.noteView,
            attribute:.CenterY, multiplier:1.125, constant:0))

    }


    func prepareQuestion(currentQuestion:Int){

        // for locking buttons
        lockButtons(true)

        currentLessonQuestion  = questions[currentQuestion]

        //decide cleftype if it is available
        if(currentLessonQuestion.clefType! == "gclef"){

            newLessonVC.lineContainer.hidden = false
            newLessonVC.clefContainer.hidden = false
            newLessonVC.gClef.hidden = false
            newLessonVC.fClef.hidden = true

        }
        else if(currentLessonQuestion.clefType! == "fclef"){
            newLessonVC.lineContainer.hidden = false
            newLessonVC.clefContainer.hidden = false
            newLessonVC.gClef.hidden = true
            newLessonVC.fClef.hidden = false

        }
        else{
            newLessonVC.lineContainer.hidden = false
            newLessonVC.clefContainer.hidden = false
            newLessonVC.gClef.hidden = true
            newLessonVC.fClef.hidden = true

        }


        // set playButton status
        if(currentLessonQuestion.noteText! != ""){

            newLessonVC.playButton.hidden = false

        }
        else{

            newLessonVC.playButton.hidden = true

        }


        //get type of question
        if(currentLessonQuestion.questionType! == "Image" && currentLessonQuestion.questionType! != "Label"){
            println("ImageType")


            if(currentLessonQuestion.noteText == ""){

                println("set imageview to image !!!!!")
                println("questionText:  \(currentLessonQuestion.questionText!)!!!!!")
                println("imageNameToSet: \(currentLessonQuestion.imageName!) !!!!!!!!!!")


                if(currentLessonQuestion.imageName! == ""){
                    newLessonVC.pictureContainer.hidden = true
                }
                else{
                    newLessonVC.pictureContainer.hidden = false
                }

                newLessonVC.lineContainer.hidden = true
                newLessonVC.clefContainer.hidden = true
                newLessonVC.textContainer.hidden = true

                if(currentLessonQuestion.imageName! != ""){
                    newLessonVC.questionPicture.hidden = false
                    newLessonVC.questionPicture.image = UIImage(named: currentLessonQuestion.imageName!)
                    newLessonVC.questionTitleText.text = currentLessonQuestion.questionText
                    lockButtons(false)
                }
                else{
                    newLessonVC.lineContainer.hidden = false
                    newLessonVC.clefContainer.hidden = false
                    newLessonVC.questionTitleText.text = currentLessonQuestion.questionText
                    lockButtons(false)
                }

            }
            else{


                //if question type is not image hide question image
                newLessonVC.pictureContainer.hidden = true

                //if question type is not text hide question text
                newLessonVC.textContainer.hidden = true



                //play sound and draw note
                newLessonVC.questionTitleText.text = currentLessonQuestion.questionText

                println("Will try to draw note!!! and noteText = \(currentLessonQuestion.noteText!)")
                getNoteSoundFromQuestionContent(currentLessonQuestion.noteText!)


            }

        }
        else if(currentLessonQuestion.questionType! == "Text"){
            println("TextType")

            newLessonVC.pictureContainer.hidden = true
            newLessonVC.lineContainer.hidden = true
            newLessonVC.clefContainer.hidden = true
            newLessonVC.textContainer.hidden = false

            newLessonVC.questionText.text = currentLessonQuestion.questionText
            newLessonVC.questionTitleText.text = currentLessonQuestion.questionTitle

            lockButtons(false)


        }
        else{

            println("OtherType: \(currentLessonQuestion.questionType!)")
            newLessonVC.pictureContainer.hidden = true
            newLessonVC.lineContainer.hidden = false
            newLessonVC.clefContainer.hidden = false
            newLessonVC.textContainer.hidden = true
            newLessonVC.playButton.hidden = true
            trivLessonNoteView.drawOtherQuetionTypes()

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

                        currentNoteCharacter =  String(Array(questionContent)[characterCounter-1])

                        for currentNoteCharacterCounter in 0..<noteArray.count {

                            if(noteArray[currentNoteCharacterCounter] == currentNoteCharacter){
                                ////println("currentNoteCharacter = \(currentNoteCharacter) and currentNoteValue = \(currentNoteCharacterCounter)")
                                currentNoteValue = String(currentNoteCharacterCounter)
                                currentSharpFlatValue = 0

                                if(String(Array(questionContent)[characterCounter])=="#"){

                                    currentSharpFlatValue  = 1

                                }else{

                                    currentSharpFlatValue  = -1

                                }
                                break
                            }
                        }
                    }

                }

                //get octav
                if (characterCounter == questionContentLenght-1){

                    currentOctav = String(Array(questionContent)[characterCounter]).toInt()!

                }
            } else {

                //minor or major note

                minorOrMajorNoteContentArray = split(questionContent as String, { $0 == "|" }, maxSplit: 10, allowEmptySlices: true)

                println("minorOrMajorNoteContentArray = \(minorOrMajorNoteContentArray)")

                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    // do some task
                    dispatch_async(dispatch_get_main_queue()) {
                        // update some UI

                        var initialDelay:Float = 0.5


                        for counter in  0..<minorOrMajorNoteContentArray.count {

                            var passingVariables:[AnyObject] = [counter+1,minorOrMajorNoteContentArray[counter],minorOrMajorNoteContentArray.count]

                            let delay = 0.5

                            var timer:NSTimer!


                            switch counter {
                            case 0:
                                timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("majorMinorSelector:"), userInfo: passingVariables, repeats: false)
                            case 1:
                                timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("majorMinorSelector:"), userInfo: passingVariables, repeats: false)
                            case 2:
                                timer = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: Selector("majorMinorSelector:"), userInfo: passingVariables, repeats: false)
                            case 3:
                                timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector("majorMinorSelector:"), userInfo: passingVariables, repeats: false)
                            case 4:
                                timer = NSTimer.scheduledTimerWithTimeInterval(2.5, target: self, selector: Selector("majorMinorSelector:"), userInfo: passingVariables, repeats: false)
                            case 5:
                                timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: Selector("majorMinorSelector:"), userInfo: passingVariables, repeats: false)
                            case 6:
                                timer = NSTimer.scheduledTimerWithTimeInterval(3.5, target: self, selector: Selector("majorMinorSelector:"), userInfo: passingVariables, repeats: false)
                            case 7:
                                timer = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: Selector("majorMinorSelector:"), userInfo: passingVariables, repeats: false)
                            case 8:
                                timer = NSTimer.scheduledTimerWithTimeInterval(4.5, target: self, selector: Selector("majorMinorSelector:"), userInfo: passingVariables, repeats: false)
                            default:
                                println("in timer default")


                            }

                        }


                    }

                }



                majorMinorFound=true
                break

            }

        }


        if(!majorMinorFound){

            if(countElements(questions![currentQuestion].noteText!) < 4){

                println(questions![currentQuestion].noteText!)
                println(questions![currentQuestion].clefType!)
                println(questions![currentQuestion].clefType!)
                println(currentSharpFlatValue)

                trivLessonNoteView.addNote(questionContent:questions![currentQuestion].noteText! , clefType:questions![currentQuestion].clefType! , sharpFlatValue: currentSharpFlatValue,majorMinorFlag: false,noteIndex:1,bufferSize:1)
            }

        }


    }


    @objc func majorMinorSelector(timer: NSTimer){

        var passingVariables:[AnyObject] = timer.userInfo as [AnyObject]

        println("index = \(passingVariables[0] as Int)")
        println("noteToDraw = \(passingVariables[1] as String)")
        println("bufferSize = \(passingVariables[2] as Int)")

        self.getNoteSoundFromQuestionContent(passingVariables[1] as String)

        self.trivLessonNoteView.addNote(questionContent: passingVariables[1] as String, clefType:self.questions![currentQuestion].clefType! , sharpFlatValue: currentSharpFlatValue,majorMinorFlag: true,noteIndex:passingVariables[0] as Int,bufferSize:passingVariables[2] as Int)

    }
    
    
    func getCurrentNoteValue(#octav:Int,noteValue:Int, sharpFlatValue:Int) -> Int32 {
        
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
        
        return value
        
    }
    
    
    
    func resetQuestion(question:Question){
        
        question.questionAlternativeAnswer1Added = false
        question.questionAlternativeAnswer2Added = false
        question.questionAlternativeAnswer3Added = false
        
    }
    
    
    func lockButtons(status:Bool){
        
        if(status){
            newLessonVC.playButton.enabled = false
            newLessonVC.nextButton.enabled = false
            newLessonVC.previousButton.enabled = false
            
        } else {
            newLessonVC.playButton.enabled = true
            newLessonVC.nextButton.enabled = true
            newLessonVC.previousButton.enabled = true
        }
        
        
    }
    
    
    func playMajorMinorSound(){
        
        println("play majorMinorSound!!!!!!!!!!!")
        
        if(replayMajorMinorFlag){
            
            replayMajorMinorFlag = false
            var timer1 = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector: Selector("majorMinorSound1"), userInfo: nil, repeats: false)
            
            var timer2 = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("majorMinorSound2"), userInfo: nil, repeats: false)
            
            var timer3 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("majorMinorSound3"), userInfo: nil, repeats: false)
            
        }
        
    }
    
    
}
