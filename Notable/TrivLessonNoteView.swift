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
    var sound:Sound!
    var soundFileName:String!
    var soundFileName1 = "",soundFileName2 = "",soundFileName3 = ""

    var majorMinorPositionIndex1 = 0,majorMinorPositionIndex2 = 0,majorMinorpositionIndex3 = 0

    init(noteView:UIView,viewController:LessonDetailViewController){

        self.noteView = noteView
        self.lessonVC = viewController
        sound = Sound()

    }




    func addNote(#questionContent:String,clefType:String,sharpFlatValue:Int,majorMinorFlag:Bool,noteIndex:Int){


        // gets current note index
        currentNoteIndex = noteIndex

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


        //println("soundFileName=\(soundFileName)")


        if(!majorMinorFlag || noteIndex==1){
            clearAllScrollNotes() //reset noteView
            resetMajorMinorValues()
            //arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            //println("drawing \(questionContent)")
        }
        else{

            //println("drawing \(questionContent)")

        }





        var note:UIImageView = UIImageView()
        var sharpFlat :UIImageView = UIImageView()




        noteView.setTranslatesAutoresizingMaskIntoConstraints(false)
        note.setTranslatesAutoresizingMaskIntoConstraints(false)
        sharpFlat.setTranslatesAutoresizingMaskIntoConstraints(false)

        noteView.addSubview(note)
        noteView.addSubview(sharpFlat)


        var noteHeight = height*(46/1136)

        noteView.addConstraint(NSLayoutConstraint(item:note, attribute:NSLayoutAttribute.Height,relatedBy:NSLayoutRelation.Equal, toItem: noteView,attribute:NSLayoutAttribute.Height, multiplier:(0.083), constant:0))

        noteView.addConstraint(NSLayoutConstraint(item:sharpFlat, attribute:NSLayoutAttribute.Height,relatedBy:NSLayoutRelation.Equal, toItem: nil,attribute:NSLayoutAttribute.NotAnAttribute, multiplier:(0.008), constant:30))


        var noteHeightConstraint = NSLayoutConstraint(item: note, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: note, attribute: NSLayoutAttribute.Height, multiplier: 700/442, constant: 0)

        var sharpFlatHeightConstraint = NSLayoutConstraint(item: sharpFlat, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: sharpFlat, attribute: NSLayoutAttribute.Height, multiplier: 30/40, constant: 0)

        noteView.addConstraint(noteHeightConstraint)
        noteView.addConstraint(sharpFlatHeightConstraint)

        //for shifting notes
        var shiftIndex:CGFloat!

        if(sharpFlatValue==0){

            shiftIndex = 0.66+(CGFloat(noteIndex-1)*0.15)
            
        }
        else{

            shiftIndex = 0.66+(CGFloat(noteIndex-1)*0.16)

        }

        noteView.addConstraint(NSLayoutConstraint(
            item:note, attribute:NSLayoutAttribute.CenterX,
            relatedBy:NSLayoutRelation.Equal, toItem:noteView,
            attribute:NSLayoutAttribute.CenterX, multiplier:shiftIndex, constant:0))

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
                setPositionIndex(noteIndex:noteIndex,positionIndex:2)

            case "D6":
                position = 0.249          //3
                setPositionIndex(noteIndex:noteIndex,positionIndex:3)

            case "C6":
                position = 0.332          //4
                setPositionIndex(noteIndex:noteIndex,positionIndex:4)

            case "H5":
                position = 0.415          //5
                setPositionIndex(noteIndex:noteIndex,positionIndex:5)

            case "A5":
                position = 0.504          //6
                setPositionIndex(noteIndex:noteIndex,positionIndex:6)

            case "G5":
                position = 0.588          //7
                setPositionIndex(noteIndex:noteIndex,positionIndex:7)

            case "F5":
                position = 0.671          //8
                setPositionIndex(noteIndex:noteIndex,positionIndex:8)

            case "D5":
                position = 0.837          //10
                setPositionIndex(noteIndex:noteIndex,positionIndex:10)

            case "D4":
                position = 1.418          //17
                setPositionIndex(noteIndex:noteIndex,positionIndex:17)

            case "C4":
                position = 1.501          //18
                setPositionIndex(noteIndex:noteIndex,positionIndex:18)

            case "E5":
                position = 0.754          //9
                setPositionIndex(noteIndex:noteIndex,positionIndex:9)

            case "C5":
                position = 0.920          //11
                setPositionIndex(noteIndex:noteIndex,positionIndex:11)

            case "H4":
                position = 1.003          //12
                setPositionIndex(noteIndex:noteIndex,positionIndex:12)

            case "G4":
                position = 1.169          //14
                setPositionIndex(noteIndex:noteIndex,positionIndex:14)

            case "F4":
                position = 1.252          //15
                setPositionIndex(noteIndex:noteIndex,positionIndex:15)

            case "E4":
                position = 1.335          //16
                setPositionIndex(noteIndex:noteIndex,positionIndex:16)

            case "H3":
                position = 1.584         //19
                setPositionIndex(noteIndex:noteIndex,positionIndex:19)

            case "F3":
                position = 1.833           //22
                setPositionIndex(noteIndex:noteIndex,positionIndex:22)

            case "A4":
                position = 1.086          //13
                setPositionIndex(noteIndex:noteIndex,positionIndex:13)

            case "G3":
                position = 1.750          //21
                setPositionIndex(noteIndex:noteIndex,positionIndex:21)

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
                setPositionIndex(noteIndex:noteIndex,positionIndex:3)

            case "C6":
                position = 0.332          //4
                setPositionIndex(noteIndex:noteIndex,positionIndex:4)

            case "H5":
                position = 0.415          //5
                setPositionIndex(noteIndex:noteIndex,positionIndex:5)

            case "C4":
                position = 0.504          //6 *
                setPositionIndex(noteIndex:noteIndex,positionIndex:6)

            case "H3":
                position = 0.588          //7 *
                setPositionIndex(noteIndex:noteIndex,positionIndex:7)

            case "A3":
                position = 0.671          //8 *
                setPositionIndex(noteIndex:noteIndex,positionIndex:8)

            case "F3":
                position = 0.837          //10
                setPositionIndex(noteIndex:noteIndex,positionIndex:10)

            case "F2":
                position = 1.418          //17  *
                setPositionIndex(noteIndex:noteIndex,positionIndex:17)

            case "E2":
                position = 1.501          //18
                setPositionIndex(noteIndex:noteIndex,positionIndex:18)

            case "G3":
                position = 0.754          //9 *
                setPositionIndex(noteIndex:noteIndex,positionIndex:9)

            case "E3":
                position = 0.920          //11 *
                setPositionIndex(noteIndex:noteIndex,positionIndex:11)

            case "D3":
                position = 1.003          //12 *
                setPositionIndex(noteIndex:noteIndex,positionIndex:12)

            case "H2":
                position = 1.169          //14 *
                setPositionIndex(noteIndex:noteIndex,positionIndex:14)

            case "A2":
                position = 1.252          //15 *
                setPositionIndex(noteIndex:noteIndex,positionIndex:15)

            case "G2":
                position = 1.335          //16 *
                setPositionIndex(noteIndex:noteIndex,positionIndex:16)

            case "D2":
                position = 1.584         //19 *
                setPositionIndex(noteIndex:noteIndex,positionIndex:19)

            case "A1":
                position = 1.833           //22 *
                setPositionIndex(noteIndex:noteIndex,positionIndex:22)

            case "C3":
                position = 1.086          //13 *
                setPositionIndex(noteIndex:noteIndex,positionIndex:13)

            case "H1":
                position = 1.750          //21 *
                setPositionIndex(noteIndex:noteIndex,positionIndex:21)

            case "C2":
                position = 1.667           //20 *
                setPositionIndex(noteIndex:noteIndex,positionIndex:20)

            case "G1":
                position = 1.833          //23 *
                setPositionIndex(noteIndex:noteIndex,positionIndex:23)

            default:
                position = -10          //24  //F1  4 lines required

            }



            //playSound
            sound.playSound(SoundFile(soundName: soundFileName, soundType: "aif"))
            //newGameVC.newGame.sound.playSound(SoundFile(soundName: "correct", soundType: "mp3"))



        }
        else{

            //newGameVC.lineContainer.hidden = true

            //newGameVC.questionPictureImage.image = UIImage(named: questionContent)

            //newGameVC.newGame.lockButtons(false)

        }




        noteView.addConstraint(NSLayoutConstraint(item:note, attribute:NSLayoutAttribute.CenterY,relatedBy:NSLayoutRelation.Equal, toItem: noteView,attribute:NSLayoutAttribute.CenterY, multiplier:position, constant:0))

        noteView.addConstraint(NSLayoutConstraint(item:sharpFlat, attribute:NSLayoutAttribute.CenterY,relatedBy:NSLayoutRelation.Equal, toItem: noteView,attribute:NSLayoutAttribute.CenterY, multiplier:position, constant:0))


        if(noteIndex == 1 && !majorMinorFlag){

            //clearUnwantedLines(majorMinorPositionIndex1)
            //unlock choice buttons
            //newGameVC.newGame.lockButtons(false)

        }
            //we have major or minor
        else if(noteIndex == 1){
            //clearUnwantedLines(majorMinorPositionIndex1)
        }
        else if(noteIndex == 3){


            //clearUnwantedLines(majorMinorPositionIndex1)
            //clearUnwantedLines(majorMinorPositionIndex2)
            //clearUnwantedLines(majorMinorpositionIndex3)



            //unlock choice buttons
            //newGameVC.newGame.lockButtons(false)
            resetMajorMinorValues()


        }

    }


    func resetMajorMinorValues(){

        majorMinorPositionIndex1=0
        majorMinorPositionIndex2=0
        majorMinorpositionIndex3=0
    }


    func clearUnwantedLines(majorMinorPositionIndex:Int){


        //println("Clear!!!!!!! \(majorMinorPositionIndex)")


        switch majorMinorPositionIndex {

        case 3:
            arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: true, thirdTopLineFlag: true, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
        case 4:
            arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: true, thirdTopLineFlag: true, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
        case 5:
            arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: true, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
        case 6:
            arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: true, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
        case 7:
            arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
        case 8:
            arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
        case 9:
            arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
        case 10:
            arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
        case 11:
            arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
        case 12:
            arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
        case 13:
            arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
        case 14:
            arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
        case 15:
            arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
        case 16:
            arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
        case 17:
            arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
        case 18:
            arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: true, secondBottomLineFlag: false, thirdBottomLineFlag: false)
        case 19:
            arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: true, secondBottomLineFlag: false, thirdBottomLineFlag: false)
        case 20:
            arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: true, secondBottomLineFlag: true, thirdBottomLineFlag: false)
        case 21:
            arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: true, secondBottomLineFlag: true, thirdBottomLineFlag: false)
        case 22:
            arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: true, secondBottomLineFlag: true, thirdBottomLineFlag: true)
        case 23:
            arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: true, secondBottomLineFlag: true, thirdBottomLineFlag: true)

        default:
            println()

        }


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


    func arrangeTopAndBottomLines(#firstTopLineFlag:Bool,secondTopLineFlag:Bool,thirdTopLineFlag:Bool,firstBottomLineFlag:Bool,secondBottomLineFlag:Bool,thirdBottomLineFlag:Bool){




        //for top extra lines
        if(!firstTopLineFlag){

            // check there is a note on this line or not
            if(majorMinorPositionIndex1 != 2 && majorMinorPositionIndex2 != 2 && majorMinorpositionIndex3 != 3){

                //newGameVC.firstTopLine.hidden = true

            }

        }
        else{
            //newGameVC.firstTopLine.hidden = false
        }

        if(!secondTopLineFlag){

            // check there is a note on this line or not
            if(majorMinorPositionIndex1 != 4 && majorMinorPositionIndex2 != 4 && majorMinorpositionIndex3 != 4){

                //newGameVC.secondTopLine.hidden = true

            }

        }
        else{
            //newGameVC.secondTopLine.hidden = false
        }

        if(!thirdTopLineFlag){


            // check there is a note on this line or not
            if(majorMinorPositionIndex1 != 6 && majorMinorPositionIndex2 != 6 && majorMinorpositionIndex3 != 6){

                //newGameVC.thirdTopLine.hidden = true

            }

        }
        else{
            //newGameVC.thirdTopLine.hidden = false
        }

        //for bottom extra lines

        if(!firstBottomLineFlag){

            // check there is a note on this line or not
            if(majorMinorPositionIndex1 != 18 && majorMinorPositionIndex2 != 18 && majorMinorpositionIndex3 != 18){

                //newGameVC.firstBottomLine.hidden = true

            }


        }
        else{
            //newGameVC.firstBottomLine.hidden = false
        }

        if(!secondBottomLineFlag){

            // check there is a note on this line or not
            if(majorMinorPositionIndex1 != 20 && majorMinorPositionIndex2 != 20 && majorMinorpositionIndex3 != 20){

                //newGameVC.secondBottomLine.hidden = true

            }


        }
        else{
            //newGameVC.secondBottomLine.hidden = false
        }

        if(!thirdBottomLineFlag){

            // check there is a note on this line or not
            if(majorMinorPositionIndex1 != 22 && majorMinorPositionIndex2 != 22 && majorMinorpositionIndex3 != 22){

                //newGameVC.thirdBottomLine.hidden = true

            }

        }
        else{
            //newGameVC.thirdBottomLine.hidden = false
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
    
    
    func setPositionIndex(#noteIndex:Int,positionIndex:Int){
        
        if(noteIndex == 1){
            
            majorMinorPositionIndex1 = positionIndex
            
        }
        else if(noteIndex == 2){
            
            majorMinorPositionIndex2 = positionIndex
            
        }
        else{
            
            majorMinorpositionIndex3 = positionIndex
            
        }
        
    }
    
    
}