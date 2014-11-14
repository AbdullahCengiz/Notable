//
//  ViewController.swift
//  Notable
//
//  Created by abdullah cengiz on 17/10/14.
//  Copyright (c) 2014 abdullah cengiz. All rights reserved.
//

import UIKit
import CoreData

class SplashScreenViewController: UIViewController {
    var cdHelper : CoreDataHelper?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cdHelper = CoreDataHelper()
        
        println("inSplashScreen")
        
        Timer("goToMainPage", 3) {
            // self .performSegueWithIdentifier("goToMainPage", sender: nil)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        getScreenSize()
        createGameDatabase()
        
    }
    
    func getScreenSize(){
        
        var bounds: CGRect = UIScreen.mainScreen().bounds
        var screenWidth:CGFloat = bounds.size.width
        var screenHeight:CGFloat = bounds.size.height
        
        saveScreenSize(width:screenWidth,height:screenHeight)
        
    }
    
    func saveScreenSize(#width:CGFloat, height:CGFloat){
        
        
        NSUserDefaults.standardUserDefaults().setObject(width, forKey: "width")
        NSUserDefaults.standardUserDefaults().setObject(height, forKey: "height")
        
        let width: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("width")
        let height: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("height")
    
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    
    
    func createGameDatabase(){
       
        //read file line by line
        var fileURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("data", ofType: "json")!)
        var jsonText : String = ""
        var newLine = "\n"
        
        if let aStreamReader = StreamReader(path: fileURL!.path!) {
            while let line = aStreamReader.nextLine() {
                jsonText = jsonText+line+newLine
                // println(line)
            }
            // You can close the underlying file explicitly. Otherwise it will be
            // closed when the reader is deallocated.
            aStreamReader.close()
        }
        
        
        //create
        var data: NSData = jsonText.dataUsingEncoding(NSUTF8StringEncoding)!
        var error: NSError?
        
        // convert NSData to 'AnyObject'
        let jsonObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0),
            error: &error)
        //println("Error: \(error)")
        //println(jsonObject!)
        
       let databaseDictionary : NSDictionary = jsonObject as NSDictionary
        
        //grab questions
        var tableArray:NSArray = databaseDictionary["objects"] as NSArray
        var questionDictionary:NSDictionary = tableArray[0] as NSDictionary
        var questionRowArray:NSArray = questionDictionary["rows"] as NSArray
        //println(questionRowArray)
    
        var questionsArray : [Question]  = []
        var counter=0
        for questionObjectArray in questionRowArray {
            
            var currentQuestion:Question = Question(questionRowArray: questionObjectArray as NSArray)
            questionsArray.insert(currentQuestion, atIndex: counter)
            counter++
            
        }
        
        //grab categories
        var categoriesDictionary:NSDictionary = tableArray[1] as NSDictionary
        var categoryRowArray:NSArray = categoriesDictionary["rows"] as NSArray
        
        var categoriesArray : [Category]  = []
        counter=0 // reset counter
        for categoryObjectArray in categoryRowArray {
            
            var currentCategory:Category = Category(categoriesRowArray: categoryObjectArray as NSArray)
            categoriesArray.insert(currentCategory, atIndex: counter)
            counter++
            
        }
        
        
        // grab Lessons
        var lessonsDictionary:NSDictionary = tableArray[3] as NSDictionary
        var lessonRowArray:NSArray = lessonsDictionary["rows"] as NSArray
        
        var lessonsArray : [Lesson]  = []
        counter=0 // reset counter
        for lessonObjectArray in lessonRowArray {
            
            var currentLesson:Lesson = Lesson(lessonsRowArray: lessonObjectArray as NSArray)
            lessonsArray.insert(currentLesson, atIndex: counter)
            counter++
            
        }

        
        //cdHelper!.saveData("question", data: questionsArray)
        //saveQuestions(questionsArray)
        //cdHelper!.removeAllData("question")
        //loadQuestions()
        //save the questions to core data
        //var savedQuestions : [Question] = cdHelper!.loadData("question") as [Question]
    
        //cdHelper!.saveData("category", data: categoriesArray)
        //var savedCategories : [Category] = cdHelper!.loadData("category") as [Category]
        //cdHelper!.removeAllData("category")
        
        //cdHelper!.saveData("lesson", data: lessonsArray)
        var savedLessons : [Lesson] = cdHelper!.loadData("lesson") as [Lesson]
        //cdHelper!.removeAllData("lesson")

        
    }
    

    /*
    
    func updateCategory(#categoryId: String , status: Bool){
    
    
    
    var appDel:AppDelegate = (UIApplication.sharedApplication().delegate) as AppDelegate
    var context:NSManagedObjectContext = appDel.managedObjectContext!
    
    var request = NSFetchRequest(entityName: "Categories")
    request.returnsObjectsAsFaults = false
    
    let categoryIdToUpdate: String = categoryId
    
    
    println("categoryIdToUpdate = \(categoryIdToUpdate)")
    
    request.predicate = NSPredicate(format: "categoryId = %@" , ""+categoryIdToUpdate)
    
    var results:NSArray = context.executeFetchRequest(request, error: nil)!
    
    
    println("loadedItemCount= \(results.count)")
    
    if(results.count > 0){
    
    
    
    for counter in 0..<results.count {
    
    var currentCategoryObject:NSManagedObject
    currentCategoryObject = results[counter] as NSManagedObject
    currentCategoryObject.setValue(status, forKey: "status")
    
    context.save(nil)
    
    
    }

    
    } else {
    
    println("Error!!!")
    
    }
    
    
    
    }
    */
    
}

