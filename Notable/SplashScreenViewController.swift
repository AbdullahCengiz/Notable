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
        saveThemeColors()
        
        
    }
    
    func getScreenSize(){
        
        var bounds: CGRect = UIScreen.mainScreen().bounds
        var screenWidth: CGFloat = bounds.size.width
        var screenHeight: CGFloat = bounds.size.height
        
        saveScreenSize(width: screenWidth, height: screenHeight)
        
    }
    
    func saveScreenSize(#width: CGFloat, height: CGFloat){
        
        
        NSUserDefaults.standardUserDefaults().setObject(width, forKey: "width")
        NSUserDefaults.standardUserDefaults().setObject(height, forKey: "height")
        
        let width: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("width")
        let height: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("height")
    
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    
    
    func saveThemeColors(){
        
        
        //Second ThemeColor
        var secondThemeBackgroundColor = UIColor.blackColor()
        var secondThemeBackgroundColorData: NSData = NSKeyedArchiver.archivedDataWithRootObject(secondThemeBackgroundColor)
        NSUserDefaults.standardUserDefaults().setObject(secondThemeBackgroundColorData, forKey: "secondThemeBackgroundColor")
        
        var secondThemeButtonColor = UIColor(red:36/255.0, green:40/255.0, blue:48/255.0, alpha:1.0)
        var secondThemeButtonColorData: NSData = NSKeyedArchiver.archivedDataWithRootObject(secondThemeButtonColor)
        NSUserDefaults.standardUserDefaults().setObject(secondThemeButtonColorData, forKey:
            "secondThemeButtonColor")
        
        var secondThemeTextColor = UIColor.whiteColor()
        var secondThemeTextColorData: NSData = NSKeyedArchiver.archivedDataWithRootObject(secondThemeTextColor)
        NSUserDefaults.standardUserDefaults().setObject(secondThemeTextColorData, forKey:
            "secondThemeTextColor")
        
        //Third ThemeColor
        var thirdThemeBackgroundColor = UIColor(red:36/255.0, green:40/255.0, blue:48/255.0, alpha:1.0)
        var thirdThemeBackgroundColorData: NSData = NSKeyedArchiver.archivedDataWithRootObject(thirdThemeBackgroundColor)
        NSUserDefaults.standardUserDefaults().setObject(thirdThemeBackgroundColorData, forKey: "thirdThemeBackgroundColor")
        
        var thirdThemeButtonColor = UIColor(red:166/255.0, green:49/255.0, blue:58/255.0, alpha:1.0)
        var thirdThemeButtonColorData: NSData = NSKeyedArchiver.archivedDataWithRootObject(thirdThemeButtonColor)
        NSUserDefaults.standardUserDefaults().setObject(thirdThemeButtonColorData, forKey:
            "thirdThemeButtonColor")
        
        var thirdThemeTextColor = UIColor.whiteColor()
        var thirdThemeTextColorData: NSData = NSKeyedArchiver.archivedDataWithRootObject(thirdThemeTextColor)
        NSUserDefaults.standardUserDefaults().setObject(thirdThemeTextColorData, forKey:
            "thirdThemeTextColor")
        
        //Fourth ThemeColor
        var fourthThemeBackgroundColor = UIColor(red:36/255.0, green:40/255.0, blue:48/255.0, alpha:1.0)
        var fourthThemeBackgroundColorData: NSData = NSKeyedArchiver.archivedDataWithRootObject(fourthThemeBackgroundColor)
        NSUserDefaults.standardUserDefaults().setObject(fourthThemeBackgroundColorData, forKey: "fourthThemeBackgroundColor")
        
        var fourthThemeButtonColor = UIColor(red:110/255.0, green:213/255.0, blue:107/255.0, alpha:1.0)
        var fourthThemeButtonColorData: NSData = NSKeyedArchiver.archivedDataWithRootObject(fourthThemeButtonColor)
        NSUserDefaults.standardUserDefaults().setObject(fourthThemeButtonColorData, forKey:
            "fourthThemeButtonColor")
        
        var fourthThemeTextColor = UIColor.whiteColor()
        var fourthThemeTextColorData: NSData = NSKeyedArchiver.archivedDataWithRootObject(fourthThemeTextColor)
        NSUserDefaults.standardUserDefaults().setObject(fourthThemeTextColorData, forKey:
            "fourthThemeTextColor")
        
        //Fifth ThemeColor
        var fifthThemeBackgroundColor = UIColor(red:204/255.0, green:210/255.0, blue:216/255.0, alpha:1.0)
        var fifthThemeBackgroundColorData: NSData = NSKeyedArchiver.archivedDataWithRootObject(fifthThemeBackgroundColor)
        NSUserDefaults.standardUserDefaults().setObject(fifthThemeBackgroundColorData, forKey: "fifthThemeBackgroundColor")
        
        var fifthThemeButtonColor = UIColor(red:70/255.0, green:151/255.0, blue:233/255.0, alpha:1.0)
        var fifthThemeButtonColorData: NSData = NSKeyedArchiver.archivedDataWithRootObject(fifthThemeButtonColor)
        NSUserDefaults.standardUserDefaults().setObject(fifthThemeButtonColorData, forKey:
            "fifthThemeButtonColor")
        
        var fifthThemeTextColor = UIColor.whiteColor()
        var fifthThemeTextColorData: NSData = NSKeyedArchiver.archivedDataWithRootObject(fifthThemeTextColor)
        NSUserDefaults.standardUserDefaults().setObject(fifthThemeTextColorData, forKey:
            "fifthThemeTextColor")
        
        
        
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
            self.performSegueWithIdentifier("goToMainPage", sender: nil)
        }


        
    }
    

        
}

