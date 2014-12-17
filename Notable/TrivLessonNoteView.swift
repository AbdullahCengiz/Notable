//
//  TrivLessonNoteView.swift
//  Notable
//
//  Created by abdullah cengiz on 14/12/14.
//  Copyright (c) 2014 Trivato. All rights reserved.
//

import Foundation

class TrivLessonNoteView
{
    var currentNoteIndex:Int!
    var noteView:UIView!
    var lessonVC:LessonDetailViewController!
    var position:CGFloat!
    var position2:CGFloat!
    var sound:Sound!
    var soundFileName:String!
    var soundFileName1 = "",soundFileName2 = "",soundFileName3 = ""
    var previousShiftIndex=0
    var majorMinorValueArray:[Int]!
    var newLesson:TrivLesson!

    var majorMinorPositionIndex1 = 0,majorMinorPositionIndex2 = 0,majorMinorpositionIndex3 = 0

    init(noteView:UIView,viewController:LessonDetailViewController,newLesson:TrivLesson){

        self.noteView = noteView
        self.lessonVC = viewController
        self.newLesson = newLesson
        sound = Sound()
        majorMinorValueArray = []

    }


    func addNote(#questionContent:String,clefType:String,sharpFlatValue:Int,majorMinorFlag:Bool,noteIndex:Int,bufferSize:Int){


        // for locking buttons
        if(noteIndex == 1){
            newLesson.lockButtons(true)
        }





        if(noteIndex == 1){
            majorMinorValueArray.removeAll(keepCapacity: false)
        }

        majorMinorValueArray.append(sharpFlatValue)

        // gets current note index
        currentNoteIndex = noteIndex

        //for deciding there is a line or not
        var positionIndex=0

        var realNoteName = questionContent

        var questionContent = questionContent


        //println("clefType: \(clefType)")
        //println("sharpFlatValue: \(sharpFlatValue)")
        // println("questionContent= \(questionContent)")

        soundFileName = getSoundFileNameFromQuestionContent(questionContent:questionContent)

        soundFileName = soundFileName.stringByReplacingOccurrencesOfString("H", withString: "B", options: nil, range: nil)

        //set question soundfilenames
        if(noteIndex == 1){

            soundFileName1 = soundFileName

        }
        else if (noteIndex == 2){

            soundFileName2 = soundFileName

        }
        else if(noteIndex == 3){

            soundFileName3 = soundFileName

        }


        if(!majorMinorFlag || noteIndex==1){
            clearAllScrollNotes() //reset noteView
        }
        else{
            //println("drawing \(questionContent)")
        }


        var note:UIImageView = UIImageView()
        var sharpFlat :UIImageView = UIImageView()
        var noteName:UILabel = UILabel()
        var line:UIView = UIView()

        noteView.setTranslatesAutoresizingMaskIntoConstraints(false)
        note.setTranslatesAutoresizingMaskIntoConstraints(false)
        noteName.setTranslatesAutoresizingMaskIntoConstraints(false)
        line.setTranslatesAutoresizingMaskIntoConstraints(false)
        sharpFlat.setTranslatesAutoresizingMaskIntoConstraints(false)

        line.backgroundColor = UIColor.blackColor()

        noteView.addSubview(line)
        noteView.addSubview(note)
        noteView.addSubview(sharpFlat)
        noteView.addSubview(noteName)


        var noteHeight = height*(46/1136)

        //for note height
        noteView.addConstraint(NSLayoutConstraint(item:note, attribute:NSLayoutAttribute.Height,relatedBy:NSLayoutRelation.Equal, toItem: noteView,attribute:NSLayoutAttribute.Height, multiplier:(0.083), constant:0))

        //for line height
        noteView.addConstraint(NSLayoutConstraint(item:line, attribute:NSLayoutAttribute.Height,relatedBy:NSLayoutRelation.Equal, toItem: noteView,attribute:NSLayoutAttribute.Height, multiplier:(0.0065), constant:0))

        //for noteName height
        noteView.addConstraint(NSLayoutConstraint(item:noteName, attribute:NSLayoutAttribute.Height,relatedBy:NSLayoutRelation.Equal, toItem: noteView,attribute:NSLayoutAttribute.Height, multiplier:(0.083), constant:0))

        //for sharpFlat
        noteView.addConstraint(NSLayoutConstraint(item:sharpFlat, attribute:NSLayoutAttribute.Height,relatedBy:NSLayoutRelation.Equal, toItem: nil,attribute:NSLayoutAttribute.NotAnAttribute, multiplier:(0.008), constant:30))

        //for note width
        var noteHeightConstraint = NSLayoutConstraint(item: note, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: note, attribute: NSLayoutAttribute.Height, multiplier: 700/442, constant: 0)

        //for line width
        var lineHeightConstraint = NSLayoutConstraint(item: line, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: note, attribute: NSLayoutAttribute.Height, multiplier: 3/1, constant: 0)

        //for noteName width
        var noteNameHeightConstraint = NSLayoutConstraint(item: noteName, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: note, attribute: NSLayoutAttribute.Height, multiplier: 3/1, constant: 0)

        //for sharpFlat width
        var sharpFlatHeightConstraint = NSLayoutConstraint(item: sharpFlat, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: sharpFlat, attribute: NSLayoutAttribute.Height, multiplier: 30/40, constant: 0)

        noteView.addConstraint(noteHeightConstraint)
        noteView.addConstraint(noteNameHeightConstraint)
        noteView.addConstraint(sharpFlatHeightConstraint)
        noteView.addConstraint(lineHeightConstraint)

        //for shifting notes
        var shiftIndex:CGFloat!

        println("sharpFlatValue= \(sharpFlatValue)  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")



        shiftIndex = 0

            for counter in 0..<majorMinorValueArray.count {

                if(counter==0){

                    if(majorMinorValueArray[counter]==0){

                        shiftIndex = 0.65

                    }
                    else{
                        shiftIndex = 0.65
                    }

                }
                else{

                    if(majorMinorValueArray[counter]==0){

                        shiftIndex = shiftIndex + 0.1 + 0.1

                    }
                    else{
                        shiftIndex = shiftIndex +  0.30
                    }
                    
                    
                    
                }



        }



        println("shiftIndex")



        //for note x position
        noteView.addConstraint(NSLayoutConstraint(
            item:note, attribute:NSLayoutAttribute.CenterX,
            relatedBy:NSLayoutRelation.Equal, toItem:noteView,
            attribute:NSLayoutAttribute.CenterX, multiplier:shiftIndex, constant:0))

        //for line x position
        noteView.addConstraint(NSLayoutConstraint(
            item:line, attribute:NSLayoutAttribute.CenterX,
            relatedBy:NSLayoutRelation.Equal, toItem:noteView,
            attribute:NSLayoutAttribute.CenterX, multiplier:shiftIndex, constant:0))

        var shiftIndexForNoteName:CGFloat!



        if(sharpFlatValue==0){
            shiftIndexForNoteName = shiftIndex+0.1
        }
        else {
            shiftIndexForNoteName = shiftIndex
        }


        //for noteName x position
        noteView.addConstraint(NSLayoutConstraint(
            item:noteName, attribute:NSLayoutAttribute.CenterX,
            relatedBy:NSLayoutRelation.Equal, toItem:noteView,
            attribute:NSLayoutAttribute.CenterX, multiplier:shiftIndexForNoteName, constant:0))

        //for sharpFlat x position
        noteView.addConstraint(NSLayoutConstraint(
            item:sharpFlat, attribute:NSLayoutAttribute.Trailing,
            relatedBy:.Equal, toItem:note,
            attribute:NSLayoutAttribute.Leading, multiplier:1, constant:0))

        var sharpImage:UIImage!

        //decide the sharpFlat Value
        if(sharpFlatValue==1){

            sharpImage = UIImage(named: "sharp.jpeg")
            sharpFlat.image = sharpImage

        }
        else if(sharpFlatValue == -1){

            sharpImage = UIImage(named: "flat.jpeg")
            sharpFlat.image = sharpImage

        }

        //remove # or b character
        questionContent = questionContent.stringByReplacingOccurrencesOfString("#", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        questionContent = questionContent.stringByReplacingOccurrencesOfString("b", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)


        let noteImage = UIImage(named: "whole_note.jpeg")
        note.image = noteImage


        //position = 0.083          //1
        //position = 0.166          //2
        //position = 0.249          //3
        //position = 0.332          //4
        //position = 0.415          //5
        //position = 0.504          //6
        //position = 0.588          //7
        //position = 0.671          //8
        //position = 0.754          //9
        //position = 0.837          //10
        //position = 0.920          //11
        //position = 1.003          //12
        position = 1.086          //13
        //position = 1.169          //14
        //position = 1.252          //15
        //position = 1.335          //16
        //position = 1.418          //17
        //position = 1.501          //18
        //position = 1.584          //19
        //position = 1.667          //20
        //position = 1.750          //21
        //position = 1.833          //22
        //position = 1.916          //23

        // blank = 0.150


        println("questionContent!!!!!!!! = \(questionContent)")



        if(clefType == "gclef"){
            //makes line container visible
           // newGameVC.lineContainer.hidden = false

            //newGameVC.fclefImage.hidden=true
            //newGameVC.gclefImage.hidden=false


            switch questionContent {

            case "E6":
                position = 0.166          //2
                positionIndex=2

            case "D6":
                position = 0.249          //3
                positionIndex=3

            case "C6":
                position = 0.332          //4
                positionIndex=4

            case "H5":
                position = 0.415          //5
                positionIndex=5

            case "A5":
                position = 0.504          //6
                positionIndex=6

            case "G5":
                position = 0.588          //7
                positionIndex=7

            case "F5":
                position = 0.671          //8
                positionIndex=8

            case "D5":
                position = 0.837          //10
                positionIndex=10

            case "D4":
                position = 1.418          //17
                positionIndex=17

            case "C4":
                position = 1.501          //18
                positionIndex=18

            case "E5":
                position = 0.754          //9
                positionIndex=9

            case "C5":
                position = 0.920          //11
                positionIndex=11

            case "H4":
                position = 1.003          //12
                positionIndex=12

            case "G4":
                position = 1.169          //14
                positionIndex=14

            case "F4":
                position = 1.252          //15
                positionIndex=15

            case "E4":
                position = 1.335          //16
                positionIndex=16

            case "H3":
                position = 1.584         //19
                positionIndex=19

            case "F3":
                position = 1.833           //22
                positionIndex=22

            case "A4":
                position = 1.086          //13
                positionIndex=13

            case "G3":
                position = 1.750          //21
                positionIndex=21

            default:
                position = -10
            }

            //playSound
            sound.playSound(SoundFile(soundName: soundFileName, soundType: "aif"))

            //newGameVC.newGame.sound.playSound(SoundFile(soundName: "correct", soundType: "mp3"))
        }
        else if (clefType == "fclef"){
            //makes line container visible
            //newGameVC.lineContainer.hidden = false

            //newGameVC.fclefImage.hidden=false
            //newGameVC.gclefImage.hidden=true

            switch questionContent {
            case "D6":
                position = 0.249          //3
                positionIndex=3

            case "C6":
                position = 0.332          //4
                positionIndex=4

            case "H5":
                position = 0.415          //5
                positionIndex=5

            case "C4":
                position = 0.504          //6 *
                positionIndex=6

            case "H3":
                position = 0.588          //7 *
                positionIndex=7

            case "A3":
                position = 0.671          //8 *
                positionIndex=8

            case "F3":
                position = 0.837          //10
                positionIndex=10

            case "F2":
                position = 1.418          //17  *
                positionIndex=17

            case "E2":
                position = 1.501          //18
                positionIndex=18

            case "G3":
                position = 0.754          //9 *
                positionIndex=9

            case "E3":
                position = 0.920          //11 *
                positionIndex=11

            case "D3":
                position = 1.003          //12 *
                positionIndex=12

            case "H2":
                position = 1.169          //14 *
                positionIndex=14

            case "A2":
                position = 1.252          //15 *
                positionIndex=15

            case "G2":
                position = 1.335          //16 *
                positionIndex=16

            case "D2":
                position = 1.584         //19 *
                positionIndex=19

            case "A1":
                position = 1.833           //22 *
                positionIndex=22

            case "C3":
                position = 1.086          //13 *
                positionIndex=13

            case "H1":
                position = 1.750          //21 *
                positionIndex=21

            case "C2":
                position = 1.667           //20 *
                positionIndex=20

            case "G1":
                position = 1.833          //23 *
                positionIndex=23

            default:
                position = -10          //24  //F1  4 lines required

            }



            //playSound
            sound.playSound(SoundFile(soundName: soundFileName, soundType: "aif"))
            //newGameVC.newGame.sound.playSound(SoundFile(soundName: "correct", soundType: "mp3"))



        }



        //for note y coordinate
        noteView.addConstraint(NSLayoutConstraint(item:note, attribute:NSLayoutAttribute.CenterY,relatedBy:NSLayoutRelation.Equal, toItem: noteView,attribute:NSLayoutAttribute.CenterY, multiplier:position, constant:0))

        //for note y coordinate
        noteView.addConstraint(NSLayoutConstraint(item:line, attribute:NSLayoutAttribute.CenterY,relatedBy:NSLayoutRelation.Equal, toItem: noteView,attribute:NSLayoutAttribute.CenterY, multiplier:position, constant:0))

        //for note y coordinate
        noteView.addConstraint(NSLayoutConstraint(item:noteName, attribute:NSLayoutAttribute.CenterY,relatedBy:NSLayoutRelation.Equal, toItem: noteView,attribute:NSLayoutAttribute.CenterY, multiplier:1.750, constant:0))

        //for sharpFlat y coordinate
        noteView.addConstraint(NSLayoutConstraint(item:sharpFlat, attribute:NSLayoutAttribute.CenterY,relatedBy:NSLayoutRelation.Equal, toItem: noteView,attribute:NSLayoutAttribute.CenterY, multiplier:position, constant:0))

        //set value to noteName
        noteName.text = realNoteName

        //decide line is visible or not
        if(positionIndex != 2 && positionIndex != 4 && positionIndex != 6 && positionIndex != 18 && positionIndex != 20 && positionIndex != 22 ){
            line.hidden = true
        }
        else{
            line.hidden=false
        }


        // unlock buttons
        if(noteIndex == bufferSize){

            newLesson.lockButtons(false)

        }

    }


    func drawOtherQuetionTypes(){

        var fourImageTop:UIImageView = UIImageView()
        var fourImageBottom:UIImageView = UIImageView()

        noteView.setTranslatesAutoresizingMaskIntoConstraints(false)
        fourImageTop.setTranslatesAutoresizingMaskIntoConstraints(false)
        fourImageBottom.setTranslatesAutoresizingMaskIntoConstraints(false)

        var fourImage = UIImage(named: "four_image.png")
        fourImageTop.image = fourImage
        fourImageBottom.image = fourImage

        noteView.addSubview(fourImageTop)
        noteView.addSubview(fourImageBottom)


        var noteHeight = 2*height*(46/1136)

        //for fourImageTop height
        noteView.addConstraint(NSLayoutConstraint(item:fourImageTop, attribute:NSLayoutAttribute.Height,relatedBy:NSLayoutRelation.Equal, toItem: noteView,attribute:NSLayoutAttribute.Height, multiplier:(0.163), constant:0))

        //for fourImageBottom height
        noteView.addConstraint(NSLayoutConstraint(item:fourImageBottom, attribute:NSLayoutAttribute.Height,relatedBy:NSLayoutRelation.Equal, toItem: noteView,attribute:NSLayoutAttribute.Height, multiplier:(0.163), constant:0))

        //for fourImageTop width
        var fourImageTopWidthConstraint = NSLayoutConstraint(item: fourImageTop, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: fourImageTop, attribute: NSLayoutAttribute.Height, multiplier: 30/48, constant: 0)

        //for fourImageBottom width
        var fourImageBottomWidthConstraint = NSLayoutConstraint(item: fourImageBottom, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: fourImageTop, attribute: NSLayoutAttribute.Height, multiplier: 30/48, constant: 0)

        noteView.addConstraint(fourImageTopWidthConstraint)
        noteView.addConstraint(fourImageBottomWidthConstraint)

        //for shifting notes
        var shiftIndex:CGFloat! = 0.66


        //for fourImageTop x position
        noteView.addConstraint(NSLayoutConstraint(
            item:fourImageTop, attribute:NSLayoutAttribute.CenterX,
            relatedBy:NSLayoutRelation.Equal, toItem:noteView,
            attribute:NSLayoutAttribute.CenterX, multiplier:shiftIndex, constant:0))

        //for fourImageBottom x position
        noteView.addConstraint(NSLayoutConstraint(
            item:fourImageBottom, attribute:NSLayoutAttribute.CenterX,
            relatedBy:NSLayoutRelation.Equal, toItem:noteView,
            attribute:NSLayoutAttribute.CenterX, multiplier:shiftIndex, constant:0))

        position = 0.837          //10
        position2 = 1.169          //14

        //for fourImageTop y coordinate
        noteView.addConstraint(NSLayoutConstraint(item:fourImageTop, attribute:NSLayoutAttribute.CenterY,relatedBy:NSLayoutRelation.Equal, toItem: noteView,attribute:NSLayoutAttribute.CenterY, multiplier:position, constant:0))

        //for fourImageBottom y coordinate
        noteView.addConstraint(NSLayoutConstraint(item:fourImageBottom, attribute:NSLayoutAttribute.CenterY,relatedBy:NSLayoutRelation.Equal, toItem: noteView,attribute:NSLayoutAttribute.CenterY, multiplier:position2, constant:0))

    }


    func clearAllScrollNotes ()
    {

        let theSubviews = noteView.subviews

        for (var view) in theSubviews
        {

            if view is UIView
            {
                    view.removeFromSuperview()
            }

        }
    }




    func getSoundFileNameFromQuestionContent(#questionContent:String)->String{

        var sharpFloatValueFound:Bool = false
        var currentNoteValue:String = ""
        var questionContentLenght:Int = (questionContent).utf16Count
        if(questionContentLenght==2){
            //normal note

            //decide sound file name
            var octavCharacter:String =  String(Array(questionContent)[1])
            var currentNoteCharacter:String =  String(Array(questionContent)[0])

            if(currentNoteCharacter == "H"){
                currentNoteCharacter = "B"
            }

            currentNoteValue =  currentNoteCharacter+octavCharacter

        }
        else{

            // we have flat or sharp
            var octavCharacter:String =  String(Array(questionContent)[2])
            var currentNoteCharacter:String =  String(Array(questionContent)[0])+String(Array(questionContent)[1])
            var sharpFlatValue:String = String(Array(questionContent)[1])

            if(currentNoteCharacter == "H"){
                currentNoteCharacter = "B"
            }

            //for sharp value
            if(sharpFlatValue == "#"){

                //search for sharp value
                for currentNoteCharacterCounter in 0..<noteArray.count {

                    if(noteArray[currentNoteCharacterCounter] == currentNoteCharacter){
                        ////println("currentNoteCharacter = \(currentNoteCharacter) and currentNoteValue = \(currentNoteCharacterCounter)")
                        currentNoteValue = noteArray[currentNoteCharacterCounter]+octavCharacter
                        sharpFloatValueFound=true
                        break
                    }
                }


                if(!sharpFloatValueFound){

                    // still search for sharp value
                    currentNoteCharacter = String(Array(questionContent)[0])
                    
                    for currentNoteCharacterCounter in 0..<noteArray.count {
                        
                        if(noteArray[currentNoteCharacterCounter] == currentNoteCharacter){
                            ////println("currentNoteCharacter = \(currentNoteCharacter) and currentNoteValue = \(currentNoteCharacterCounter)")
                            
                            if(currentNoteCharacterCounter == noteArray.count-1 ){
                                currentNoteCharacter = noteArray[0]
                                octavCharacter = String(octavCharacter.toInt()!+1)
                            }else{
                                
                                currentNoteCharacter = noteArray[currentNoteCharacterCounter+1]
                                
                            }
                            
                            currentNoteValue = currentNoteCharacter+octavCharacter
                            
                            break
                        }
                    }
                }
                
            }
            else{
                //for flat value
                
                currentNoteCharacter = String(Array(questionContent)[0])
                
                for currentNoteCharacterCounter in 0..<noteArray.count {
                    
                    if(noteArray[currentNoteCharacterCounter] == currentNoteCharacter){
                        ////println("currentNoteCharacter = \(currentNoteCharacter) and currentNoteValue = \(currentNoteCharacterCounter)")
                        
                        if(currentNoteCharacterCounter == 0 ){
                            currentNoteCharacter = noteArray[noteArray.count-1]
                            octavCharacter = String(octavCharacter.toInt()!-1)
                        }else{
                            
                            currentNoteCharacter = noteArray[currentNoteCharacterCounter-1]
                            
                        }
                        
                        currentNoteValue = currentNoteCharacter+octavCharacter
                        
                        break
                    }
                }
                
            }
            
        }
        
        return currentNoteValue
    }
    

    
}