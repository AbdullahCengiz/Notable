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
        saveTheme()
        saveAnimateBtn()
        checkReklamStatus()
        checkHighScoreStatus()
        checkAnimateBtnStatus()
        scoreNumber()
        scoreName()
        highscoreNumber()
        textFieldName()
        nameTextField()
        inAppPurchases()

    }

        func scoreNumber(){
        
         var pointLabel: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("pointLabel")
        
        if(pointLabel==nil){
            
            NSUserDefaults.standardUserDefaults().setObject(0, forKey: "pointLabel")
            NSUserDefaults.standardUserDefaults().synchronize()

       }
    }
    
    func scoreName(){
        
        var highscoreName: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("highscoreName")
        if(highscoreName==nil){
            
            NSUserDefaults.standardUserDefaults().setObject(0, forKey: "highscoreName")
            NSUserDefaults.standardUserDefaults().synchronize()

        }
    }


    func inAppPurchases(){

        var removeAd: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("removeAd")

        if(removeAd==nil){

            NSUserDefaults.standardUserDefaults().setObject(0, forKey: "removeAd")
            NSUserDefaults.standardUserDefaults().synchronize()

        }


        var lesson4: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("lesson4")

        if(lesson4==nil){

            NSUserDefaults.standardUserDefaults().setObject(0, forKey: "lesson4")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }

    }
    
    func highscoreNumber(){
        
        var highscoreNumber: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("highscoreNumber")
        
        if(highscoreNumber==nil){
            
            NSUserDefaults.standardUserDefaults().setObject(0, forKey: "highscoreNumber")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            println("Did not reach highscore")
        }

        
        var goldValue:AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("pointLabel")
        var silverValue:AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("pointLabel")
        var bronzeValue:AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("pointLabel") 

        if (goldValue==nil) {
            NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "highscoreNumberGold")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        if (silverValue==nil) {
            NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "highscoreNumberSilver")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        if (bronzeValue==nil) {
            NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "highscoreNumberBronze")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    func nameTextField(){
        
        var highscoreName: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("highscoreName")
        
        if(highscoreName==nil){
            
            NSUserDefaults.standardUserDefaults().setObject(0, forKey: "highscoreName")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
    var goldValueName:AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("highscoreNameGold")
    var silverValueName:AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("highscoreNameSilver")
    var bronzeValueName:AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("highscoreNameBronze")
        
    if (goldValueName==nil) {
        NSUserDefaults.standardUserDefaults().setObject("No record", forKey: "highscoreNameGold")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    if (silverValueName==nil) {
        NSUserDefaults.standardUserDefaults().setObject("No record", forKey: "highscoreNameSilver")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    if (bronzeValueName==nil) {
        NSUserDefaults.standardUserDefaults().setObject("No record", forKey: "highscoreNameBronze")
        NSUserDefaults.standardUserDefaults().synchronize()
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
        saveReklam()
        checkAnimateBtnStatus()
        saveAnimateBtn()
        textFieldName()

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
    
    func textFieldName(){

        var highscoreNumber: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("nameText")
        
        if(highscoreNumber==nil){
            
            NSUserDefaults.standardUserDefaults().setObject(0, forKey: "nameText")
            NSUserDefaults.standardUserDefaults().synchronize()
        

        println("textName is saved in SplashScreen!")
        
        }
    }
    func saveReklam(){
        
    let removedReklam: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("removedReklam")

    }
    
    func saveAnimateBtn(){
        
    let removedAnimateBtn: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("removedAnimateBtn")
    }
    
    func saveTheme(){
        
        let selectedTheme: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("selectedTheme")
        
        
        if(selectedTheme==nil){
            
            NSUserDefaults.standardUserDefaults().setObject(0, forKey: "selectedTheme")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
    }
    
    func checkReklamStatus(){
        
        let reklam: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("reklam")
        
        
        if(reklam==nil){
            
            
            NSUserDefaults.standardUserDefaults().setObject(1, forKey: "reklam")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    func checkAnimateBtnStatus(){
        
        let animateBtn: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("animateBtn")
        
        
        if(animateBtn==nil){
            
            
            NSUserDefaults.standardUserDefaults().setObject(1, forKey: "animateBtn")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    func checkHighScoreStatus(){
        
        let zeroHighScore: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("zeroHighScore")
        
        
        if(zeroHighScore==nil){
            
            
            NSUserDefaults.standardUserDefaults().setObject(0, forKey: "zeroHighScore")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
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


            println(questionObjectArray)
            
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
        
        /*
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
*/
        
        
        //
        //saveQuestions(questionsArray)
        //cdHelper!.removeAllData("question")
        //loadQuestions()
        //save the questions to core data
        
        
        // /ontrol for questions if there is not any get them from json
        if(cdHelper!.loadData("question") == nil){
            
            cdHelper!.saveData("question", data: questionsArray)
            
        }else{
            
            println("There are some questions in CoreData")
            
        }


        

        //cdHelper!.saveData("category", data: categoriesArray)
        //var savedCategories : [Category] = cdHelper!.loadData("category") as [Category]
        //cdHelper!.removeAllData("category")
        
        
        //control for category if there is not any get them from json
        if(cdHelper!.loadData("category") == nil){
            
            cdHelper!.saveData("category", data: categoriesArray)
            
        }
        else{
            
            println("There are some categories in CoreData")
            
        }


        
        
        
        
        //cdHelper!.saveData("lesson", data: lessonsArray)
        //var savedLessons : [Lesson] = cdHelper!.loadData("lesson") as [Lesson]
        //cdHelper!.removeAllData("lesson")

        var lessonsArray : [Lesson]  = []
        var staticLessonData = LessonData()


        
        
        //control for lesson if there is not any get them from json

        if(cdHelper!.loadData("lesson") == nil){

            lessonsArray = staticLessonData.createLessons()


            for lesson in lessonsArray{

                println("lesson name: \(lesson.lessonName!) numbOfQuestions= \(lesson.lessonQuestions!.count)")

            }


            cdHelper!.saveData("lesson", data: lessonsArray)

            for lesson in lessonsArray {


                cdHelper!.saveData("lessonQuestion", data: lesson.lessonQuestions)
                println("\(lesson.lessonName) questions were saved !!!!!!!!!!!!!!!!!!!!!!!!!!!!")

            }


        }
        else{
            println("There are some lessons in CoreData !!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        }

        
        //go to main function
        Timer("goToMainPage", 2) {
            self.performSegueWithIdentifier("goToMainPage", sender: nil)
        }
        
    }
    

        
}

