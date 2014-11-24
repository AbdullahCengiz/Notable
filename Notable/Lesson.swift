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
    var lessonCategory:Int?
    var lessonTitle:String?
    var lessonType:String?
    var lessonContent:String?
    var lessonVoiceTrack:String?
    var lessonExtra:String?
    var lessonPosition:Int?
    
    var status: Bool = false
    
    init(){
        
    }
    
    init(lessonsRowArray:NSArray){
        lessonId = lessonsRowArray[0] as? Int
        lessonCategory = lessonsRowArray[1] as? Int
        lessonTitle = lessonsRowArray[2] as? String
        lessonType = lessonsRowArray[3] as? String
        lessonContent = lessonsRowArray[4] as? String
        lessonVoiceTrack = lessonsRowArray[5] as? String
        lessonExtra = lessonsRowArray[6] as? String
        lessonPosition = lessonsRowArray[7] as? Int
        
    }
    
}
