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
        
        
        categoryCell.setCell(currentCategory.categoryName!)
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
        
        
        //updateCategory(categoryId:selectedCategory.categoryId!, status:selectedCategory.status!)
        
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
                
                //updateCategory(categoryId: category.categoryId, status: category.status)
                
            }
            
            
        }
        else {
            
            sender.setBackgroundImage(checkBoxUnCheckedImage, forState: UIControlState.Normal)
            sender.tag = 0
            
            // untick all categories
            for category in loadedArrayOfCategories {
                
                category.status=false
                
                //updateCategory(categoryId: category.categoryId, status: category.status)
                
                
            }

        }
        
        // reload categories tableview
        categoriesTableView.reloadData()
        
        
        
    }
    
    
    
    func setUpCategories(){
        
        
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
        
        
    }
    
    
       
    
    
    
   
    
    
}





