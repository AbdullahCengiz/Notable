//
//  TrivNoteView.swift
//  Notable
//
//  Created by abdullah cengiz on 04/12/14.
//  Copyright (c) 2014 Trivato. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import AVFoundation
import QuartzCore




class TrivNoteView
{
    var currentNoteIndex:Int!
    var noteView:UIView!
    var newGameVC:NewGameViewController!
    var position:CGFloat!

    init(noteView:UIView,viewController:NewGameViewController){

        self.noteView = noteView
        self.newGameVC = viewController

    }




    func addNote(#questionContent:String,clefType:String,sharpFlatValue:Int,majorMinorFlag:Bool,noteIndex:Int){

        // makes extra lines visible
        //makeExtraLinesVisible()
        currentNoteIndex = noteIndex

        var questionContent = questionContent


        println("clefType: \(clefType)")
        println("sharpFlatValue: \(sharpFlatValue)")


        if(majorMinorFlag || noteIndex==1){
            clearAllScrollNotes() //reset noteView
            println("drawing \(questionContent)")
        }
        else{

            println("drawing \(questionContent)")

        }





        var note:UIImageView = UIImageView()
        var sharpFlat :UIImageView = UIImageView()




        noteView.setTranslatesAutoresizingMaskIntoConstraints(false)
        note.setTranslatesAutoresizingMaskIntoConstraints(false)
        sharpFlat.setTranslatesAutoresizingMaskIntoConstraints(false)

        noteView.addSubview(note)
        noteView.addSubview(sharpFlat)

        // dnoteView.alpha  = 0.5

        // println(" (secondNoteLine.X)=\(secondNoteLine.bounds.origin.x)")
        println(" (secondNoteLine.maxY)=\(newGameVC.secondNoteLine.frame.maxY)")

        var noteHeight = height*(46/1136)

        noteView.addConstraint(NSLayoutConstraint(item:note, attribute:NSLayoutAttribute.Height,relatedBy:NSLayoutRelation.Equal, toItem: noteView,attribute:NSLayoutAttribute.Height, multiplier:(0.083), constant:0))

        noteView.addConstraint(NSLayoutConstraint(item:sharpFlat, attribute:NSLayoutAttribute.Height,relatedBy:NSLayoutRelation.Equal, toItem: nil,attribute:NSLayoutAttribute.NotAnAttribute, multiplier:(0.012), constant:30))


        var noteHeightConstraint = NSLayoutConstraint(item: note, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: note, attribute: NSLayoutAttribute.Height, multiplier: 700/442, constant: 0)

        var sharpFlatHeightConstraint = NSLayoutConstraint(item: sharpFlat, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: sharpFlat, attribute: NSLayoutAttribute.Height, multiplier: 30/40, constant: 0)

        noteView.addConstraint(noteHeightConstraint)
        noteView.addConstraint(sharpFlatHeightConstraint)

        noteView.addConstraint(NSLayoutConstraint(
            item:note, attribute:.CenterX,
            relatedBy:.Equal, toItem:noteView,
            attribute:.CenterX, multiplier:1, constant:0))

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
            newGameVC.lineContainer.hidden = false

            newGameVC.fclefImage.hidden=true
            newGameVC.gclefImage.hidden=false
           

            switch questionContent {
            case "D6":
                position = 0.249          //3
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: true, thirdTopLineFlag: true, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "C6":
                position = 0.332          //4
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: true, thirdTopLineFlag: true, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "H5":
                position = 0.415          //5
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: true, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "G5":
                position = 0.588          //7
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "F5":
                position = 0.671          //8
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "D5":
                position = 0.837          //10
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "D4":
                position = 1.418          //17
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "C4":
                position = 1.501          //18
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: true, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "E5":
                position = 0.754          //9
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "C5":
                position = 0.920          //11
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "H4":
                position = 1.003          //12
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "G4":
                position = 1.169          //14
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "F4":
                position = 1.252          //15
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "E4":
                position = 1.335          //16
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "H3":
                position = 1.584         //19
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: true, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "F3":
                position = 1.833           //22
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: true, secondBottomLineFlag: true, thirdBottomLineFlag: true)
            case "A4":
                position = 1.086          //13
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "G3":
                position = 1.750          //21
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: true, secondBottomLineFlag: true, thirdBottomLineFlag: false)
            default:
                position = -10
            }
        }
        else if (clefType == "fclef"){
            //makes line container visible
            newGameVC.lineContainer.hidden = false

            newGameVC.fclefImage.hidden=false
            newGameVC.gclefImage.hidden=true
            
            switch questionContent {
            case "D6":
                position = 0.249          //3
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: true, thirdTopLineFlag: true, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "C6":
                position = 0.332          //4
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: true, thirdTopLineFlag: true, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "H5":
                position = 0.415          //5
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: true, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "C4":
                position = 0.504          //6 *
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: true, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "H3":
                position = 0.588          //7 *
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "A3":
                position = 0.671          //8 *
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "F3":
                position = 0.837          //10
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "F2":
                position = 1.418          //17  *
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "E2":
                position = 1.501          //18
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: true, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "G3":
                position = 0.754          //9 *
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "E3":
                position = 0.920          //11 *
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "D3":
                position = 1.003          //12 *
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "H2":
                position = 1.169          //14 *
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "A2":
                position = 1.252          //15 *
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "G2":
                position = 1.335          //16 *
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "D2":
                position = 1.584         //19 *
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: true, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "A1":
                position = 1.833           //22 *
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: true, secondBottomLineFlag: true, thirdBottomLineFlag: true)
            case "C3":
                position = 1.086          //13 *
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            case "H1":
                position = 1.750          //21 *
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: true, secondBottomLineFlag: true, thirdBottomLineFlag: false)
            case "C2":
                position = 1.667           //20 *
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: true, secondBottomLineFlag: true, thirdBottomLineFlag: false)
            case "G1":
                position = 1.833          //23 *
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: true, secondBottomLineFlag: true, thirdBottomLineFlag: true)
            default:
                position = -10          //24  //F1  4 lines required
                arrangeTopAndBottomLines(firstTopLineFlag: false, secondTopLineFlag: false, thirdTopLineFlag: false, firstBottomLineFlag: false, secondBottomLineFlag: false, thirdBottomLineFlag: false)
            }


        }
        else{

            newGameVC.lineContainer.hidden = true

            newGameVC.questionPictureImage.image = UIImage(named: questionContent)

        }




        noteView.addConstraint(NSLayoutConstraint(item:note, attribute:NSLayoutAttribute.CenterY,relatedBy:NSLayoutRelation.Equal, toItem: noteView,attribute:NSLayoutAttribute.CenterY, multiplier:position, constant:0))

         noteView.addConstraint(NSLayoutConstraint(item:sharpFlat, attribute:NSLayoutAttribute.CenterY,relatedBy:NSLayoutRelation.Equal, toItem: noteView,attribute:NSLayoutAttribute.CenterY, multiplier:position, constant:0))

    }


    func clearAllScrollNotes ()
    {

        println("Clear NoteView!!!!!")
        let theSubviews = noteView.subviews

        for (var view) in theSubviews
        {

            if view is UIView
            {
                //println("viewTag = \(view.tag)")
                if(view.tag != 1 && view.tag != 2){
                    view.removeFromSuperview()
                }

            }
            
        }
    }


    func arrangeTopAndBottomLines(#firstTopLineFlag:Bool,secondTopLineFlag:Bool,thirdTopLineFlag:Bool,firstBottomLineFlag:Bool,secondBottomLineFlag:Bool,thirdBottomLineFlag:Bool){

        if(currentNoteIndex == 1){


            //for top extra lines
            if(!firstTopLineFlag){
                newGameVC.firstTopLine.hidden = true
            }
            else{
                newGameVC.firstTopLine.hidden = false
            }

            if(!secondTopLineFlag){
                newGameVC.secondTopLine.hidden = true
            }
            else{
                newGameVC.secondTopLine.hidden = false
            }

            if(!thirdTopLineFlag){
                newGameVC.thirdTopLine.hidden = true
            }
            else{
                newGameVC.thirdTopLine.hidden = false
            }

            //for bottom extra lines

            if(!firstBottomLineFlag){
                newGameVC.firstBottomLine.hidden = true
            }
            else{
                newGameVC.firstBottomLine.hidden = false
            }

            if(!secondBottomLineFlag){
                newGameVC.secondBottomLine.hidden = true
            }
            else{
                newGameVC.secondBottomLine.hidden = false
            }

            if(!thirdBottomLineFlag){
                newGameVC.thirdBottomLine.hidden = true
            }
            else{
                newGameVC.thirdBottomLine.hidden = false
            }
            
        }
        
    }


}