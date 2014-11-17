//
//  Question.swift
//  Notable
//
//  Created by abdullah cengiz on 13/11/14.
//  Copyright (c) 2014 Trivato. All rights reserved.
//

import Foundation

class Question
{
    var questionType : String?
    var questionId : Int?
    var questionContent : String?
    var questionCorrect : Int?
    var questionIncorrect : Int?
    var questionAnswer : String?
    var questionCategory : Int?
    var questionExtraInfo : String?
    
    init(questionRowArray:NSArray){
        
        questionType = questionRowArray[0] as? String
        questionId = questionRowArray[1] as? Int
        questionContent = questionRowArray[2] as? String
        questionCorrect = questionRowArray[3] as? Int
        questionIncorrect = questionRowArray[4] as? Int
        questionAnswer = questionRowArray[5] as? String
        questionCategory = questionRowArray[6] as? Int
        questionExtraInfo = questionRowArray[7] as? String
        
    }
    
    init(){
        
        
    }
    
}
