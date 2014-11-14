//
//  DatabaseHelper.swift
//  Notable
//
//  Created by abdullah cengiz on 14/11/14.
//  Copyright (c) 2014 Trivato. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper
{
    var dataSet : [AnyObject]?
    var appDel:AppDelegate?
    var context:NSManagedObjectContext?
    
    init(){
        
       appDel = (UIApplication.sharedApplication().delegate) as? AppDelegate
        context = appDel!.managedObjectContext!
    }
    
    
    func saveData(dataType:String, data:[AnyObject]?){
        dataSet=data!
        
        var context:NSManagedObjectContext = appDel!.managedObjectContext!
        
        switch dataType {
        case "question":
            
            for question : Question in dataSet as [Question]{
                
                var currentQuestion:AnyObject
                currentQuestion = NSEntityDescription.insertNewObjectForEntityForName("Questions", inManagedObjectContext: context) as NSManagedObject
                
                currentQuestion.setValue(question.questionType, forKey: "questionType")
                currentQuestion.setValue(question.questionId, forKey: "questionId")
                currentQuestion.setValue(question.questionContent, forKey: "questionContent")
                currentQuestion.setValue(question.questionCorrect, forKey: "questionCorrect")
                currentQuestion.setValue(question.questionIncorrect, forKey: "questionIncorrect")
                currentQuestion.setValue(question.questionAnswer, forKey: "questionAnswer")
                currentQuestion.setValue(question.questionCategory, forKey: "questionCategory")
                currentQuestion.setValue(question.questionExtraInfo, forKey: "questionExtraInfo")
        
            }
            //Save questions
            context.save(nil)

            case "category":
                
                for category : Category in dataSet as [Category]{
                    
                    var currentCategory:AnyObject
                    currentCategory = NSEntityDescription.insertNewObjectForEntityForName("Categories", inManagedObjectContext: context) as NSManagedObject
                    
                    currentCategory.setValue(category.categoryId, forKey: "categoryId")
                    currentCategory.setValue(category.categoryName, forKey: "categoryName")
                    currentCategory.setValue(category.categoryPosition, forKey: "categoryPosition")
                    
                }
                //Save questions
                context.save(nil)

            
        case "lesson":
            
            for lesson : Lesson in dataSet as [Lesson]{
                
                var currentLesson:AnyObject
                currentLesson = NSEntityDescription.insertNewObjectForEntityForName("Lessons", inManagedObjectContext: context) as NSManagedObject
                
                currentLesson.setValue(lesson.lessonId, forKey: "lessonId")
                currentLesson.setValue(lesson.lessonCategory, forKey: "lessonCategory")
                currentLesson.setValue(lesson.lessonTitle, forKey: "lessonTitle")
                currentLesson.setValue(lesson.lessonType, forKey: "lessonType")
                currentLesson.setValue(lesson.lessonContent, forKey: "lessonContent")
                currentLesson.setValue(lesson.lessonVoiceTrack, forKey: "lessonVoiceTrack")
                currentLesson.setValue(lesson.lessonExtra, forKey: "lessonExtra")
                currentLesson.setValue(lesson.lessonPosition, forKey: "lessonPosition")
                
            }
            //Save questions
            context.save(nil)
            
        case "category":
            
            for category : Category in dataSet as [Category]{
                
                var currentCategory:AnyObject
                currentCategory = NSEntityDescription.insertNewObjectForEntityForName("Categories", inManagedObjectContext: context) as NSManagedObject
                
                currentCategory.setValue(category.categoryId, forKey: "categoryId")
                currentCategory.setValue(category.categoryName, forKey: "categoryName")
                currentCategory.setValue(category.categoryPosition, forKey: "categoryPosition")
                
            }
            //Save questions
            context.save(nil)

        
        default:
            println("Someone else")
        }
        
        
    }
    
    
    
    func loadData(dataType:String) -> [AnyObject]?{
        var data: [AnyObject]? = []
    
        var context:NSManagedObjectContext = appDel!.managedObjectContext!
        var request : NSFetchRequest?
    
        switch dataType {
        case "question":
            
            request = NSFetchRequest(entityName: "Questions")
            request!.returnsObjectsAsFaults = false
            
            var results:NSArray = context.executeFetchRequest(request!, error: nil)!
            
            
            println("loadedQuestionCount= \(results.count)")
            
            if(results.count > 0){
                
                for counter in 0..<results.count {
                    
                    var currentQuestionObject:NSManagedObject
                    var currentQuestion:Question = Question()
                    
                    currentQuestionObject = results[counter] as NSManagedObject
                    currentQuestion.questionId = currentQuestionObject.valueForKey("questionId") as? Int
                    currentQuestion.questionType = currentQuestionObject.valueForKey("questionType") as? String
                    currentQuestion.questionContent = currentQuestionObject.valueForKey("questionContent") as? String
                    currentQuestion.questionCorrect = currentQuestionObject.valueForKey("questionCorrect") as? Int
                    currentQuestion.questionIncorrect = currentQuestionObject.valueForKey("questionIncorrect") as? Int
                    currentQuestion.questionAnswer = currentQuestionObject.valueForKey("questionAnswer") as? String
                    currentQuestion.questionCategory = currentQuestionObject.valueForKey("questionCategory") as? Int
                    currentQuestion.questionExtraInfo = currentQuestionObject.valueForKey("questionExtraInfo") as? String
            
                    data?.insert(currentQuestion, atIndex: counter)

                }
                
            } else {
                
                
            }
            
            context.save(nil)
            
        case "category":
            
            request = NSFetchRequest(entityName: "Categories")
            request!.returnsObjectsAsFaults = false
            
            var results:NSArray = context.executeFetchRequest(request!, error: nil)!
            
            
            println("loadedCategoryCount= \(results.count)")
            
            if(results.count > 0){
                
                for counter in 0..<results.count {
                    
                    var currentCategorybject:NSManagedObject
                    var currentCategory:Category = Category()
                    
                    currentCategorybject = results[counter] as NSManagedObject
                    currentCategory.categoryId = currentCategorybject.valueForKey("categoryId") as? Int
                    currentCategory.categoryName = currentCategorybject.valueForKey("categoryName") as? String
                    currentCategory.categoryPosition = currentCategorybject.valueForKey("categoryPosition") as? Int
                    
                    data?.insert(currentCategory, atIndex: counter)
                    
                }
                
            } else {
                
                
            }
            
            context.save(nil)

        case "lesson":
            
            request = NSFetchRequest(entityName: "Lessons")
            request!.returnsObjectsAsFaults = false
            
            var results:NSArray = context.executeFetchRequest(request!, error: nil)!
            
            
            println("loadedLessonsCount= \(results.count)")
            
            if(results.count > 0){
                
                for counter in 0..<results.count {
                    
                    var currentLessonObject:NSManagedObject
                    var currentLesson:Lesson = Lesson()
                    
                    currentLessonObject = results[counter] as NSManagedObject
                    currentLesson.lessonId = currentLessonObject.valueForKey("lessonId") as? Int
                    currentLesson.lessonCategory = currentLessonObject.valueForKey("lessonCategory") as? Int
                    currentLesson.lessonTitle = currentLessonObject.valueForKey("lessonTitle") as? String
                    currentLesson.lessonType = currentLessonObject.valueForKey("lessonType") as? String
                    currentLesson.lessonContent = currentLessonObject.valueForKey("lessonContent") as? String
                    currentLesson.lessonVoiceTrack = currentLessonObject.valueForKey("lessonVoiceTrack") as? String
                    currentLesson.lessonExtra = currentLessonObject.valueForKey("lessonExtra") as? String
                    currentLesson.lessonPosition = currentLessonObject.valueForKey("lessonPosition") as? Int
                    
                    data?.insert(currentLesson, atIndex: counter)
                    
                }
                
            } else {
                
                
            }
            
            context.save(nil)

            
        default:
            println("Undefined Type")
        }

        return data
    }
    
    
    func removeAllData(dataType:String){
        
        var context:NSManagedObjectContext = appDel!.managedObjectContext!
        var request : NSFetchRequest?
        
        switch dataType {
        case "question":
            
            request = NSFetchRequest(entityName: "Questions")
            request!.returnsObjectsAsFaults = false
            
            var results:NSArray = context.executeFetchRequest(request!, error: nil)!
            println("Questions to delete= \(results.count)")
            
            if(results.count > 0){
                
                var currentQuestionObject:NSManagedObject!
                for currentQuestionObject: AnyObject in results
                {
                    context.deleteObject(currentQuestionObject as NSManagedObject)
                }
                
                
            } else {
                
                println("Question Delete Error!!!")
                
            }
            
            context.save(nil)
    
        case "category":
            
            request = NSFetchRequest(entityName: "Categories")
            request!.returnsObjectsAsFaults = false
            
            var results:NSArray = context.executeFetchRequest(request!, error: nil)!
            println("Categories to delete= \(results.count)")
            
            if(results.count > 0){
                
                var currentCategoryObject:NSManagedObject!
                for currentCategoryObject: AnyObject in results
                {
                    context.deleteObject(currentCategoryObject as NSManagedObject)
                }
                
            } else {
                
                println("Category Delete Error!!!")
                
            }
            
            context.save(nil)
            
        case "lesson":
            
            request = NSFetchRequest(entityName: "Lessons")
            request!.returnsObjectsAsFaults = false
            
            var results:NSArray = context.executeFetchRequest(request!, error: nil)!
            println("Lessons to delete= \(results.count)")
            
            if(results.count > 0){
                
                var currentLessonObject:NSManagedObject!
                for currentLessonObject: AnyObject in results
                {
                    context.deleteObject(currentLessonObject as NSManagedObject)
                }
                
            } else {
                
                println("Lesson Delete Error!!!")
                
            }
            
            context.save(nil)
            
        default:
            println("Someone else")
        }

    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

