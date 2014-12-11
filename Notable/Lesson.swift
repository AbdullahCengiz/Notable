//
//  Lessons.swift
//  Notable
//
//  Created by abdullah cengiz on 14/11/14.
//  Copyright (c) 2014 Trivato. All rights reserved.
//

import Foundation

class Lesson
{
    var lessonId:Int?
    var lessonName:String?
    var lessonHint:String?
    var lessonQuestions : [LessonQuestion]?
    
    init(){
        
    }
    
    init(lessonId:Int,lessonName:String,lessonHint:String){
        
        self.lessonId = lessonId
        self.lessonName = lessonName
        self.lessonHint = lessonHint
        self.lessonQuestions = []

    }
    
}
