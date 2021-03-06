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
                currentQuestion.setValue(question.questionClefType, forKey: "questionClefType")
        
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
                    currentCategory.setValue(category.status, forKey: "status")
                    
                }
                //Save questions
                context.save(nil)


        case "lesson":
            
            for lesson : Lesson in dataSet as [Lesson]{
                
                var currentLesson:AnyObject
                currentLesson = NSEntityDescription.insertNewObjectForEntityForName("Lessons", inManagedObjectContext: context) as NSManagedObject
                
                currentLesson.setValue(lesson.lessonId, forKey: "lessonId")
                currentLesson.setValue(lesson.lessonName, forKey: "lessonName")
                currentLesson.setValue(lesson.lessonHint, forKey: "lessonHint")
            }
            //Save questions
            context.save(nil)

        case "lessonQuestion":

            for lessonQuestion : LessonQuestion in dataSet as [LessonQuestion]{

                var currentLessonQuestion:AnyObject
                currentLessonQuestion = NSEntityDescription.insertNewObjectForEntityForName("LessonQuestions", inManagedObjectContext: context) as NSManagedObject

                currentLessonQuestion.setValue(lessonQuestion.lessonId, forKey: "lessonId")
                currentLessonQuestion.setValue(lessonQuestion.clefType, forKey: "clefType")
                currentLessonQuestion.setValue(lessonQuestion.imageName, forKey: "imageName")
                currentLessonQuestion.setValue(lessonQuestion.noteText, forKey: "noteText")
                currentLessonQuestion.setValue(lessonQuestion.questionText, forKey: "questionText")
                currentLessonQuestion.setValue(lessonQuestion.questionTitle, forKey: "questionTitle")
                currentLessonQuestion.setValue(lessonQuestion.questionType, forKey: "questionType")
                currentLessonQuestion.setValue(lessonQuestion.questionId, forKey: "questionId")


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
                currentCategory.setValue(category.status, forKey: "status")
                
            }
            //Save questions
            context.save(nil)

        
        default:
            println("Someone else")
        }
        
        
    }
    
    
    
    func loadData(dataType:String) -> (data:[AnyObject], checkStatus:Bool)?{
        var data: [AnyObject]? = []
    
        var context:NSManagedObjectContext = appDel!.managedObjectContext!
        var request : NSFetchRequest?
        var isAllOfCategoriesChecked:Bool = true
    
        switch dataType {
        case "question":
            
            request = NSFetchRequest(entityName: "Questions")
            request!.returnsObjectsAsFaults = false

            //request!.predicate = NSPredicate(format: "order by lessonName")
            
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
                     currentQuestion.questionClefType = currentQuestionObject.valueForKey("questionClefType") as? String
                    
                    data?.append(currentQuestion)

                }
                
            } else {
                
                return nil
                
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
                    currentCategory.status = currentCategorybject.valueForKey("status") as? Bool
                    
                    
                    println("id: \(currentCategory.categoryId!) status: \(currentCategory.status!)")
                    
                    if(!currentCategory.status!){
                        isAllOfCategoriesChecked = false
                    }
                    
                    data?.append(currentCategory)
                    
                }
                
            } else {
                
                return nil
                
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
                    currentLesson.lessonName = currentLessonObject.valueForKey("lessonName") as? String
                    currentLesson.lessonHint = currentLessonObject.valueForKey("lessonHint") as? String

                    //control lesson4 status
                    var lesson4: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("lesson4")

                    if(lesson4 as Int == 1){

                            data?.append(currentLesson)

                    }
                    else{

                        if(currentLesson.lessonId != 3){

                            data?.append(currentLesson)
                            
                        }

                    }

                    

                    
                }
                
            } else {
                
                return nil
                
            }
            
            context.save(nil)


        default:
            println("Undefined Type")
        }

        return (data!,isAllOfCategoriesChecked)
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
    

    func updateCategory(#categoryId: Int , status: Bool){
        
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate) as AppDelegate
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Categories")
        request.returnsObjectsAsFaults = false
        
        let categoryIdToUpdate: String = String(categoryId)
        
        println("categoryIdToUpdate = \(categoryIdToUpdate)")
        request.predicate = NSPredicate(format: "categoryId = %@" , ""+categoryIdToUpdate)
        var results:NSArray = context.executeFetchRequest(request, error: nil)!
        println("loadedItemCount= \(results.count)")
        
        
        println("categoryId:\(categoryId) newStatus=\(status)")

        if(results.count > 0){
            
            for counter in 0..<results.count {
                
                var currentCategoryObject:NSManagedObject
                currentCategoryObject = results[counter] as NSManagedObject
                currentCategoryObject.setValue(status, forKey: "status")


            }

            context.save(nil)
            
        } else {
            
            println("Error!!!")
            
        }
    }



    func getCategories() -> [AnyObject] {

        var data: [AnyObject]? = []

        var context:NSManagedObjectContext = appDel!.managedObjectContext!
        var isAllOfCategoriesChecked:Bool = true



            var request = NSFetchRequest(entityName: "Categories")
            request.returnsObjectsAsFaults = false
            request.predicate = NSPredicate(format: "status = %@" , true)
            var results:NSArray = context.executeFetchRequest(request, error: nil)!


            println("getCategories Category Count= \(results.count)")

            if(results.count > 0){

                for counter in 0..<results.count {

                    var currentCategorybject:NSManagedObject
                    var currentCategory:Category = Category()

                    currentCategorybject = results[counter] as NSManagedObject
                    currentCategory.categoryId = currentCategorybject.valueForKey("categoryId") as? Int
                    currentCategory.categoryName = currentCategorybject.valueForKey("categoryName") as? String
                    currentCategory.categoryPosition = currentCategorybject.valueForKey("categoryPosition") as? Int
                    currentCategory.status = currentCategorybject.valueForKey("status") as? Bool

                    if(currentCategory.status!){
                        data?.append(currentCategory)
                    }

                }

            }


        return data!
    }


    func getQuestionsOfLesson(#lessonId:Int) -> [AnyObject] {

        var data: [AnyObject]? = []

        var context:NSManagedObjectContext = appDel!.managedObjectContext!


        var request = NSFetchRequest(entityName: "LessonQuestions")
        request.returnsObjectsAsFaults = false
        println("lessonId: \(lessonId)")
        request.predicate = NSPredicate(format: "lessonId = %d",lessonId)
        var results:NSArray = context.executeFetchRequest(request, error: nil)!


        println("getLessonQuestions  Count= \(results.count) !!!!!!!!!!!!!!!!!!!!!!!!!!!!!")



        if(results.count > 0){


            for counter in 0..<results.count {


                var currentLessonQuestionObject:NSManagedObject
                var currentLessonQuestion:LessonQuestion = LessonQuestion()

                currentLessonQuestionObject = results[counter] as NSManagedObject
                currentLessonQuestion.lessonId = currentLessonQuestionObject.valueForKey("lessonId") as? Int
                println("currentLessonQuestion.lessonId \(currentLessonQuestion.lessonId)")
                currentLessonQuestion.clefType = currentLessonQuestionObject.valueForKey("clefType") as? String
                println("currentLessonQuestion.clefType \(currentLessonQuestion.clefType)")
                currentLessonQuestion.imageName = currentLessonQuestionObject.valueForKey("imageName") as? String
                println("currentLessonQuestion.imageName \(currentLessonQuestion.imageName)")
                currentLessonQuestion.noteText = currentLessonQuestionObject.valueForKey("noteText") as? String
                println("currentLessonQuestion.noteText \(currentLessonQuestion.noteText)")
                currentLessonQuestion.questionText = currentLessonQuestionObject.valueForKey("questionText") as? String
                println("currentLessonQuestion.questionText \(currentLessonQuestion.questionText)")
                currentLessonQuestion.questionTitle = currentLessonQuestionObject.valueForKey("questionTitle") as? String
                println("currentLessonQuestion.questionTitle \(currentLessonQuestion.questionTitle)")
                currentLessonQuestion.questionType = currentLessonQuestionObject.valueForKey("questionType") as? String
                println("currentLessonQuestion.questionType \(currentLessonQuestion.questionType)")
                currentLessonQuestion.questionId = currentLessonQuestionObject.valueForKey("questionId") as? Int
                
                data?.insert(currentLessonQuestion, atIndex: counter)
                
            }

        }


        return data!
    }



    func getQuestionsOfCategories(arrayOfCategories:[Category]) -> [AnyObject] {

        var data: [Question]? = []

        var context:NSManagedObjectContext = appDel!.managedObjectContext!
        var isAllOfCategoriesChecked:Bool = true


        println("Number of selected categories = \(arrayOfCategories.count)")

        //create query
        var questionQuery = ""

        for index in 0..<arrayOfCategories.count {

            //if there is only one category selected
            if(index==0 && arrayOfCategories.count==1){

                questionQuery = "questionCategory = \(arrayOfCategories[index].categoryId!)"
                break
            }

            //if selected categories greater than 1
            if(index==0 && arrayOfCategories.count>1){
                questionQuery = "questionCategory = \(arrayOfCategories[index].categoryId!) OR "
            }
            else if(index==(arrayOfCategories.count-1)){

                questionQuery  = "\(questionQuery) questionCategory = \(arrayOfCategories[index].categoryId!)"

            }
            else{

                questionQuery  = "\(questionQuery) questionCategory = \(arrayOfCategories[index].categoryId!) OR "

            }


        }


        println(questionQuery)


        var request = NSFetchRequest(entityName: "Questions")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: questionQuery)


        var results:NSArray = context.executeFetchRequest(request, error: nil)!


        println("getQuestion question Count= \(results.count)")

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
                currentQuestion.questionClefType = currentQuestionObject.valueForKey("questionClefType") as? String

                data?.insert(currentQuestion, atIndex: counter)

            }

        }

        /*
        //question contents before shuffle
        for counter in 0..<data!.count {

            println(data![counter].questionContent!)

        }
        */

        println("!!!!!!!!!!!!!!!!!!!**********************!!!!!!!!!!!!!!!!!!!!!!")



        //set other answers for questions
        for counter in 0..<data!.count {

            var randomQuestionFlag:Bool = true

            println("Question \(counter) right answer's category = \(data![counter].questionCategory!)  it is  = \(data![counter].questionAnswer!) ")


            while(randomQuestionFlag){

                let rnd = Int(arc4random_uniform(UInt32((data!.count)-1)))


                if(rnd != counter){

                    if(data![counter].questionCategory == data![rnd].questionCategory){

                        if((data![counter].questionAlternativeAnswerId1!) == -1){
                            data![counter].questionAlternativeAnswerId1 = data![rnd].questionId
                            data![counter].questionAlternativeAnswer1 = data![rnd].questionAnswer
                            println("Question \(counter) questionAlternativeAnswerId1 was set and it is \(data![counter].questionAlternativeAnswerId1!) it's answer = \(data![rnd].questionAnswer!)")

                        }else if((data![counter].questionAlternativeAnswerId2!) == -1){

                            if(data![rnd].questionId != data![counter].questionAlternativeAnswerId1){
                                data![counter].questionAlternativeAnswerId2 = data![rnd].questionId
                                data![counter].questionAlternativeAnswer2 = data![rnd].questionAnswer
                                println("Question \(counter) questionAlternativeAnswerId2 was set  it is \(data![counter].questionAlternativeAnswerId2!) it's answer = \(data![rnd].questionAnswer!)")
                            }

                        }
                        else if((data![counter].questionAlternativeAnswerId3!) == -1){

                            if(data![rnd].questionId != data![counter].questionAlternativeAnswerId1 && data![rnd].questionId != data![counter].questionAlternativeAnswerId2){
                                data![counter].questionAlternativeAnswerId3 = data![rnd].questionId
                                data![counter].questionAlternativeAnswer3 = data![rnd].questionAnswer
                                println("Question \(counter) questionAlternativeAnswerId3 was set it is \(data![counter].questionAlternativeAnswerId3!) and it's answer = \(data![rnd].questionAnswer!)")
                                randomQuestionFlag = false

                            }

                        }

                    }

                }


            }







        }



          // shuffle questions were commented

        //for shuffle array
        for idx in 0..<data!.count {
            let rnd = Int(arc4random_uniform(UInt32(idx)))
            if rnd != idx {
                swap(&data![idx], &data![rnd])
            }
        }


        //question contents after shuffle
        for counter in 0..<data!.count {

            println(data![counter].questionContent!)
            
        }
        

        return data!

    }



    
    
}

