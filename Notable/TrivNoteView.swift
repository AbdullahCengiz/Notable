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

    var noteView:UIView!
    var newGameVC:NewGameViewController!
    var position:CGFloat!

    init(noteView:UIView,viewController:NewGameViewController){

        self.noteView = noteView
        self.newGameVC = viewController

    }




    func addNote(#questionContent:String,cleffType:String){

        var note:UIImageView = UIImageView()

        noteView.setTranslatesAutoresizingMaskIntoConstraints(false)
        note.setTranslatesAutoresizingMaskIntoConstraints(false)

        noteView.addSubview(note)

        // dnoteView.alpha  = 0.5

        // println(" (secondNoteLine.X)=\(secondNoteLine.bounds.origin.x)")
        println(" (secondNoteLine.maxY)=\(newGameVC.secondNoteLine.frame.maxY)")

        var noteHeight = height*(46/1136)

        noteView.addConstraint(NSLayoutConstraint(item:note, attribute:NSLayoutAttribute.Height,relatedBy:NSLayoutRelation.Equal, toItem: noteView,attribute:NSLayoutAttribute.Height, multiplier:(0.083), constant:0))


        var heightConstraint = NSLayoutConstraint(item: note, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: note, attribute: NSLayoutAttribute.Height, multiplier: 700/442, constant: 0)

        noteView.addConstraint(heightConstraint)


        noteView.addConstraint(NSLayoutConstraint(
            item:note, attribute:.CenterX,
            relatedBy:.Equal, toItem:noteView,
            attribute:.CenterX, multiplier:1, constant:0))

        println("heightConstraint == !!!!!!! \(heightConstraint.constant)")


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
        //position = 1.086          //13
        //position = 1.169          //14
        //position = 1.252          //15
        //position = 1.335          //16
        //position = 1.418          //17
        //position = 1.440          //18
        //position = 1.501          //19
        //position = 1.584          //20
        //position = 1.667          //21
        //position = 1.750          //22
        //position = 1.833          //23
        //position = 1.916          //24

        // blank = 0.150


        /*
        if(cleffType == "gCleff"){

            switch questionContent {
            case "G5":
                position = 0.375
            case "D5":
                position = 0.5
            case "C5":
                position = 0.875
            case "B4":
                position = 1
            case "E4":
                position = 1.5
            case "F4":
                position = 1.375
            case "A4":
                position = 1.125
            case "G4":
                position = 1.25
            default:
                position = 1.125
            }
        }
        else{
            
            switch questionContent {

            case "B3":
                position = 0.375
            case "A3":
                position = 0.5
            case "G3":
                position = 0.625
            case "E3":
                position = 0.875
            case "B4":
                position = 1
            case "D3":
                position = 1
            case "B2":
                position = 1.25
            case "G2":
                position = 1.5
            case "A2":
                position = 1.375
            case "D3":
                position = 1
            default:
                position = 1.125
            }

        }
*/



        noteView.addConstraint(NSLayoutConstraint(item:note, attribute:NSLayoutAttribute.CenterY,relatedBy:NSLayoutRelation.Equal, toItem: noteView,attribute:NSLayoutAttribute.CenterY, multiplier:position, constant:0))

    }

}