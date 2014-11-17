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
        createGameDatabase()
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        getScreenSize()
        
        
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
        
        //get questions
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
        
        //get categories
        var categoriesDictionary:NSDictionary = tableArray[1] as NSDictionary
        var categoryRowArray:NSArray = categoriesDictionary["rows"] as NSArray
        
        var categoriesArray : [Category]  = []
        counter=0 // reset counter
        for categoryObjectArray in categoryRowArray {
            
            var currentCategory:Category = Category(categoriesRowArray: categoryObjectArray as NSArray)
            categoriesArray.insert(currentCategory, atIndex: counter)
            counter++
            
        }
        
        
        //get Lessons
        var lessonsDictionary:NSDictionary = tableArray[3] as NSDictionary
        var lessonRowArray:NSArray = lessonsDictionary["rows"] as NSArray
        
        var lessonsArray : [Lesson]  = []
        counter=0 // reset counter
        for lessonObjectArray in lessonRowArray {
            
            var currentLesson:Lesson = Lesson(lessonsRowArray: lessonObjectArray as NSArray)
            lessonsArray.insert(currentLesson, atIndex: counter)
            counter++
            
        }

        
        //
        //saveQuestions(questionsArray)
        cdHelper!.removeAllData("question")
        //loadQuestions()
        //save the questions to core data
        
        
        // /ontrol for questions if there is not any get them from json
        if(cdHelper!.loadData("question") == nil){
            
            cdHelper!.saveData("question", data: questionsArray)
            
        }
        else{
            
            println("There are some lessons in CoreData")
            
        }


        

        //cdHelper!.saveData("category", data: categoriesArray)
        //var savedCategories : [Category] = cdHelper!.loadData("category") as [Category]
        cdHelper!.removeAllData("category")
        
        
        //control for category if there is not any get them from json
        if(cdHelper!.loadData("category") == nil){
            
            cdHelper!.saveData("category", data: categoriesArray)
            
        }
        else{
            
            println("There are some questions in CoreData")
            
        }


        
        
        
        
        //cdHelper!.saveData("lesson", data: lessonsArray)
        //var savedLessons : [Lesson] = cdHelper!.loadData("lesson") as [Lesson]
        cdHelper!.removeAllData("lesson")
        
        
        //control for lesson if there is not any get them from json
        if(cdHelper!.loadData("lesson") == nil){
            cdHelper!.saveData("lesson", data: lessonsArray)
        }
        else{
            println("There are some lessons in CoreData")
        }
        
        //go to main function
        Timer("goToMainPage", 2) {
            self .performSegueWithIdentifier("goToMainPage", sender: nil)
        }


        
    }
    

        
}

