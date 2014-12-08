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
    var questionAnswer : String!
    var questionAlternativeAnswer1 :String!
    var questionAlternativeAnswer2 :String!
    var questionAlternativeAnswer3 :String!
    var questionAlternativeAnswerId1 :Int? = -1 //not set
    var questionAlternativeAnswerId2 :Int? = -1 //not set
    var questionAlternativeAnswerId3 :Int? = -1 //not set
    var questionAnswerIndex:Int = 0
    var questionClefType:String!

    var questionAlternativeAnswer1Added : Bool = false
    var questionAlternativeAnswer2Added : Bool = false
    var questionAlternativeAnswer3Added : Bool = false

    var questionCategory : Int?
    var questionExtraInfo : String?
    
    init(questionRowArray:NSArray){
        
        questionType = questionRowArray[0] as? String

         println("questionType= \(questionType)")

        questionId = questionRowArray[1] as? Int
        questionContent = questionRowArray[2] as? String
        questionCorrect = questionRowArray[3] as? Int
        questionIncorrect = questionRowArray[4] as? Int
        questionAnswer = questionRowArray[5] as? String
        questionCategory = questionRowArray[6] as? Int
        //questionExtraInfo = questionRowArray[7] as? String
        questionClefType =  questionRowArray[7] as? String

        println("questionClefType= \(questionClefType)")
        
    }
    
    init(){
        
        
    }
    
}
