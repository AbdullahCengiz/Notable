//
//  CategoriesViewController.swift
//  Notable
//
//  Created by abdullah cengiz on 24/10/14.
//  Copyright (c) 2014 abdullah cengiz. All rights reserved.
//

import UIKit
import CoreData

class CategoriesViewController: UIViewController,UITableViewDelegate ,UITableViewDataSource  {
    @IBOutlet var navItem: UINavigationItem!
    let checkBoxUnCheckedImage = UIImage(named: "checkbox_unchecked") as UIImage?
    let checkBoxCheckedImage = UIImage(named: "checkbox_checked") as UIImage?
    
    var arrayOfCategories: [Category] = [Category]()
    var loadedArrayOfCategories: [Category] = [Category]()
    
    var checkBoxButton:UIButton  = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    // for initial status of checkAll button
    var isAllOfCategoriesChecked: Bool = true
    
    @IBOutlet var categoriesTableView: UITableView!
    
    
    var navBar:UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar = self.navigationController?.navigationBar
        // Do any additional setup after loading the view.
        
        self.categoriesTableView.delegate = self
        self.categoriesTableView.dataSource = self
        
        self.automaticallyAdjustsScrollViewInsets = false;
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        loadCategories()
        
        prepareNavigationBar()
    }
    
    func prepareNavigationBar(){
        
        //for back button
        let image = UIImage(named: "backbutton") as UIImage?
        let uiButton    = UIButton.buttonWithType(UIButtonType.System) as UIButton
        uiButton.frame  = CGRectMake(0, 0, 25, 25)
        uiButton.setBackgroundImage(image, forState: UIControlState.Normal)
        uiButton.setTitle("", forState: UIControlState.Normal);
        uiButton.addTarget(self, action:"backButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        navItem.setLeftBarButtonItem(UIBarButtonItem(customView: uiButton), animated: true)
        navItem.hidesBackButton=true
        
        
        //for settings button
        let checkBoxImage = UIImage(named: "checkbox_unchecked") as UIImage?
        checkBoxButton.frame  = CGRectMake(0, 0, 20, 20)
        checkBoxButton.setBackgroundImage(checkBoxImage, forState: UIControlState.Normal)
        checkBoxButton.setTitle("", forState: UIControlState.Normal);
        checkBoxButton.tag=0 // if tag=0 button is unticked
        
        // if all of categories are ticked
        
        if(isAllOfCategoriesChecked){
            
            checkBoxButton.setBackgroundImage(checkBoxCheckedImage, forState: UIControlState.Normal)
            
            checkBoxButton.tag=1 // if tag=1 button is ticked
            
        }
        
        checkBoxButton.addTarget(self, action:"checkAllButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        navItem.setRightBarButtonItem(UIBarButtonItem(customView: checkBoxButton), animated: true)
        navItem.hidesBackButton=true
        

        
    
    }
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return loadedArrayOfCategories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let categoryCell :CategoryTableCell = self.categoriesTableView.dequeueReusableCellWithIdentifier("categoryCell") as CategoryTableCell
        
        let currentCategory = loadedArrayOfCategories[indexPath.row]
        
        if(currentCategory.status){
            categoryCell.tickImage.hidden=false
            
        }
        else{
            categoryCell.tickImage.hidden = true
        }
        
        
        categoryCell.setCell(currentCategory.categoryName)
        return categoryCell
        
    }
    
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
        let categoryCell :CategoryTableCell = categoriesTableView.cellForRowAtIndexPath(indexPath) as CategoryTableCell
        
        var selectedCategory : Category = loadedArrayOfCategories[indexPath.row]
        
        if(selectedCategory.status){
            selectedCategory.status = false
            
            
            dispatch_async(dispatch_get_main_queue()) {
                self.checkBoxButton.setBackgroundImage(self.checkBoxUnCheckedImage, forState: UIControlState.Normal)
            }
            
        }
        else{
            selectedCategory.status = true
        }
        
        var selectedCategoryName :String = categoryCell.categoryNameLabel.text as String!
        
       
        //println("selectedCategory = \(selectedCategoryName)")
        
        
        updateCategory(categoryId:selectedCategory.categoryId, status:selectedCategory.status)
        
        categoriesTableView.reloadData()
        
    }

    
    
    @IBAction func backButtonAction(sender:UIButton)
    {
        println("Button Action From Code")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func  checkAllButtonAction(sender:UIButton)
    {
        
        if(sender.tag == 0){
            
            sender.setBackgroundImage(checkBoxCheckedImage, forState: UIControlState.Normal)
            sender.tag = 1
            
            // tick all categories
            for category in loadedArrayOfCategories {
                
                category.status=true
                
                updateCategory(categoryId: category.categoryId, status: category.status)
                
            }
            
            
        }
        else {
            
            sender.setBackgroundImage(checkBoxUnCheckedImage, forState: UIControlState.Normal)
            sender.tag = 0
            
            // untick all categories
            for category in loadedArrayOfCategories {
                
                category.status=false
                
                updateCategory(categoryId: category.categoryId, status: category.status)
                
                
            }

        }
        
        // reload categories tableview
        categoriesTableView.reloadData()
        
        
        
    }
    
    
    
    func setUpCategories(){
        
        var category1 = Category(categoryId:"1", categoryName: "category1", status: false)
        var category2 = Category(categoryId:"2", categoryName: "category2", status: false)
        var category3 = Category(categoryId:"3", categoryName: "category3", status: false)
        var category4 = Category(categoryId:"4", categoryName: "category4", status: false)
        var category5 = Category(categoryId:"5", categoryName: "category5", status: false)
        var category6 = Category(categoryId:"6", categoryName: "category6", status: false)
        var category7 = Category(categoryId:"7", categoryName: "category7", status: false)
        var category8 = Category(categoryId:"8", categoryName: "category8", status: false)
        var category9 = Category(categoryId:"9", categoryName: "category9", status: false)
        var category10 = Category(categoryId:"10", categoryName: "category10", status: false)
        
        
        arrayOfCategories.append(category1)
        arrayOfCategories.append(category2)
        arrayOfCategories.append(category3)
        arrayOfCategories.append(category4)
        arrayOfCategories.append(category5)
        arrayOfCategories.append(category6)
        arrayOfCategories.append(category7)
        arrayOfCategories.append(category8)
        arrayOfCategories.append(category9)
        arrayOfCategories.append(category10)
        
        //deleteAll()
        
        saveCategories(arrayOfCategories)

        
    }
    
    
    func saveCategories(arrayOfCategories: [Category]){
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate) as AppDelegate
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        
        println("in save categories")
        
        
        
        for category in arrayOfCategories{
            
            var currentCategory:AnyObject
            println("\(category.categoryName)")
            currentCategory = NSEntityDescription.insertNewObjectForEntityForName("Categories", inManagedObjectContext: context) as NSManagedObject
            
            currentCategory.setValue(category.categoryName, forKey: "categoryName")
            currentCategory.setValue(category.status, forKey: "status")
            currentCategory.setValue(category.categoryId, forKey: "categoryId")
            
            context.save(nil)
           //  println("Object Saved")
            
        }
        
        println()
        
        loadCategories()
        
        
    }
    
    
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
            
            
            
            loadCategories()
            
            
            
            
        } else {
            
            println("Error!!!")
            
        }

        
        
    }
    
    
    func loadCategories(){
        
        loadedArrayOfCategories.removeAll(keepCapacity: false)
        
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate) as AppDelegate
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Categories")
        request.returnsObjectsAsFaults = false
        
        var results:NSArray = context.executeFetchRequest(request, error: nil)!
        
        
        println("loadedItemCount= \(results.count)")
        
        if(results.count > 0){
            
            for counter in 0..<results.count {
                
                var currentCategoryObject:NSManagedObject
                var currentCategory:Category = Category()
                
                currentCategoryObject = results[counter] as NSManagedObject
                currentCategory.categoryName = currentCategoryObject.valueForKey("categoryName") as String
                currentCategory.status = currentCategoryObject.valueForKey("status") as Bool
                currentCategory.categoryId = currentCategoryObject.valueForKey("categoryId") as String
                
                if(!currentCategory.status){
                    isAllOfCategoriesChecked = false
                }
                
                
                println("categoryName: \(currentCategory.categoryName)  categoryStatus: \(currentCategory.status)")
                
                loadedArrayOfCategories.append(currentCategory)
                
            }
            
            
            for category in loadedArrayOfCategories{
                
                println("\(category.categoryName)")
                
            }

            
            
        } else {
            
             setUpCategories()
             println("Error!!!")
            
        }
        
        
        
        
    }
    
    
    
    func deleteAll(){
       
        loadedArrayOfCategories.removeAll(keepCapacity: false)
        
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate) as AppDelegate
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Categories")
        request.returnsObjectsAsFaults = false
        
        var results:NSArray = context.executeFetchRequest(request, error: nil)!
        
        
        println("loadedItemCount= \(results.count)")
        
        if(results.count > 0){
            
            
            var currentCategoryObject:NSManagedObject!
            for currentCategoryObject: AnyObject in results
            {
                context.deleteObject(currentCategoryObject as NSManagedObject)
            }
            
            context.save(nil)
            
            
    
            
            
        } else {
            
            println("Error!!!")
            
        }

        
        
    }

    
    
}





