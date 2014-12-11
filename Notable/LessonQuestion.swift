//
//  LessonQuestion.swift
//  Notable
//
//  Created by abdullah cengiz on 10/12/14.
//  Copyright (c) 2014 Trivato. All rights reserved.
//

import Foundation

class LessonQuestion
{

    var lessonId:Int?
    var questionType:String?
    var questionText:String?
    var questionTitle:String?
    var noteText:String?
    var clefType:String?
    var imageName:String?
    
    init(){

    }

    init(lessonId:Int,questionType:String,questionText:String,questionTitle:String,noteText:String,clefType:String,imageName:String){

        self.lessonId = lessonId
        self.questionType = questionType
        self.questionText = questionText
        self.questionType = questionTitle
        self.noteText = noteText
        self.clefType = clefType
        self.imageName = imageName

    }
    
}
