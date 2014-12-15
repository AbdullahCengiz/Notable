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
        //initPlayer()
        //trivNoteView.addNote(questionContent:"H4",clefType:"gClef",sharpFlatValue: -1)

        prepareQuestion(currentQuestion)

    }

    func initUI(){


    }

    func inOrder(s1: String, s2: String) -> Bool {
        return s1 < s2
    }


    func initVariables(){

        //init trivNoteView
        trivLessonNoteView = TrivLessonNoteView(noteView: newLessonVC.noteView, viewController: newLessonVC )

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
            //////////println("No sound value !!!!!")
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


    func prepareQuestion(currentQuestion:Int){


        currentLessonQuestion  = questions[currentQuestion]


        println("questionId = \(currentLessonQuestion.questionId!)")
        println("cleftype = \(currentLessonQuestion.clefType!)")
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


        //get type of question
        if(currentLessonQuestion.questionType! == "Image"){
            println("ImageType")

            if(currentLessonQuestion.noteText == ""){

                println("set imageview to image !!!!!")
                println("questionText:  \(currentLessonQuestion.questionText!)!!!!!")
                println("imageNameToSet: \(currentLessonQuestion.imageName!) !!!!!!!!!!")


                newLessonVC.pictureContainer.hidden = false
                newLessonVC.lineContainer.hidden = true
                newLessonVC.clefContainer.hidden = true
                newLessonVC.textContainer.hidden = true

                if(currentLessonQuestion.imageName! != ""){
                    newLessonVC.questionPicture.hidden = false
                    newLessonVC.questionPicture.image = UIImage(named: currentLessonQuestion.imageName!)
                    newLessonVC.questionTitleText.text = currentLessonQuestion.questionText
                }
                else{
                    newLessonVC.lineContainer.hidden = false
                    newLessonVC.clefContainer.hidden = false
                    newLessonVC.questionTitleText.text = currentLessonQuestion.questionText
                }

            }
            else{
                //play sound and draw note
                newLessonVC.questionTitleText.text = currentLessonQuestion.questionText



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
            

        }
        else{

            println("OtherType: \(currentLessonQuestion.questionType!)")
            newLessonVC.pictureContainer.hidden = false
            newLessonVC.lineContainer.hidden = false
            newLessonVC.clefContainer.hidden = false
            newLessonVC.textContainer.hidden = false

        }



        /*
        //lock choice buttons here
        newGameVC.newGame.lockButtons(true)

        // ********!!!change the number of questions here!!!*********

        //reset cell counter
        if(gameType=="practice"){
            cellCounter = 0
        }

        if (cellCounter == 10){

            var scoreScreen: NGScore = newGameVC.storyboard!.instantiateViewControllerWithIdentifier("HighScoreViewController") as NGScore
            scoreScreen.delegate = newGameVC
            newGameVC.presentViewController(scoreScreen, animated: true, completion: nil)

        }else{

            println("questionArraySize: \(questions.count) currentQuestionIndex= \(currentQuestion)")
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
                trivNoteView.addNote(questionContent:questions![currentQuestion].questionContent! , clefType:questions![currentQuestion].questionClefType! , sharpFlatValue: currentSharpFlatValue,majorMinorFlag: true,noteIndex:1)
            }
            else {
                getNoteSoundFromQuestionContent(questions![currentQuestion].questionContent!)
                //getNoteSoundFromQuestionContent("G2|Hb2|D3")

                println("QuestionContent!!!!!!!!!!!!!!!!!!!! : \(questions![currentQuestion].questionAnswer!)")
            }




            //getNoteSoundFromQuestionContent("D3|F3|A3")

            //lockButtons(false)
        }

        */
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


                minorOrMajorNoteContentArray = split(questionContent as String, { $0 == "|" }, maxSplit: 3, allowEmptySlices: true)

                ////println("minorOrMajorNoteContentArray = \(minorOrMajorNoteContentArray)")


                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                // do some task
                dispatch_async(dispatch_get_main_queue()) {
                // update some UI
                //sleep(2)


                //depends on number of notes to play

                self.getNoteSoundFromQuestionContent(minorOrMajorNoteContentArray[0])

                self.trivLessonNoteView.addNote(questionContent:minorOrMajorNoteContentArray[0] , clefType:self.questions![self.currentQuestion].clefType! , sharpFlatValue: currentSharpFlatValue,majorMinorFlag: false,noteIndex:1)
                NSThread.sleepForTimeInterval(0.5)

                self.getNoteSoundFromQuestionContent(minorOrMajorNoteContentArray[1])
                self.trivLessonNoteView.addNote(questionContent:minorOrMajorNoteContentArray[1] , clefType:self.questions![self.currentQuestion].clefType! , sharpFlatValue: currentSharpFlatValue,majorMinorFlag: false,noteIndex:2)
                NSThread.sleepForTimeInterval(0.5)

                self.getNoteSoundFromQuestionContent(minorOrMajorNoteContentArray[2])
                self.trivLessonNoteView.addNote(questionContent:minorOrMajorNoteContentArray[2] , clefType:self.questions![self.currentQuestion].clefType! , sharpFlatValue: currentSharpFlatValue,majorMinorFlag: false,noteIndex:3)
                }
                }




                var timer1 = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("majorMinorSelector1"), userInfo: nil, repeats: false)

                var timer2 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("majorMinorSelector2"), userInfo: nil, repeats: false)

                var timer3 = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: Selector("majorMinorSelector3"), userInfo: nil, repeats: false)



                majorMinorFound=true
                break
                //currentNote  = 110

            }

            //////println(Array((questions![currentQuestion].questionContent!))[characterCounter])



        }


        if(!majorMinorFound){

            currentNote = getCurrentNoteValue(octav:currentOctav, noteValue:currentNoteValue.toInt()!, sharpFlatValue:currentSharpFlatValue )

            //println("currentSharpFlatValue= \(currentSharpFlatValue)")


            if(countElements(questions![currentQuestion].noteText!) < 4){
                trivLessonNoteView.addNote(questionContent:questions![currentQuestion].noteText! , clefType:questions![currentQuestion].clefType! , sharpFlatValue: currentSharpFlatValue,majorMinorFlag: false,noteIndex:1)
            }




            //println("Will play note \(questionContent) and noteId = \(currentNote)")

            //playNote(currentNote)
            //majorMinorFound=false

        }


    }


    @objc func majorMinorSound1(){

        //sound.playSound(SoundFile(soundName: trivNoteView.soundFileName1, soundType: "aif"))

    }

    @objc func majorMinorSound2(){

        //sound.playSound(SoundFile(soundName: trivNoteView.soundFileName2, soundType: "aif"))

    }

    @objc func majorMinorSound3(){

        //sound.playSound(SoundFile(soundName: trivNoteView.soundFileName3, soundType: "aif"))

        //unlock replay button lock
        replayMajorMinorFlag = true

    }

    @objc func majorMinorSelector1(){

        self.getNoteSoundFromQuestionContent(minorOrMajorNoteContentArray[0])

        self.trivLessonNoteView.addNote(questionContent:minorOrMajorNoteContentArray[0] , clefType:self.questions![currentQuestion].clefType! , sharpFlatValue: currentSharpFlatValue,majorMinorFlag: true,noteIndex:1)


    }



    @objc func majorMinorSelector2(){

        self.getNoteSoundFromQuestionContent(minorOrMajorNoteContentArray[1])
        self.trivLessonNoteView.addNote(questionContent:minorOrMajorNoteContentArray[1] , clefType:self.questions![currentQuestion].clefType! , sharpFlatValue: currentSharpFlatValue,majorMinorFlag: true,noteIndex:2)


    }


    @objc func majorMinorSelector3(){

        self.getNoteSoundFromQuestionContent(minorOrMajorNoteContentArray[2])
        self.trivLessonNoteView.addNote(questionContent:minorOrMajorNoteContentArray[2] , clefType:self.questions![currentQuestion].clefType! , sharpFlatValue: currentSharpFlatValue,majorMinorFlag: true,noteIndex:3)

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


        if(status){
            newGameVC.playButton.enabled = false
        } else {

            newGameVC.playButton.enabled = true
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
