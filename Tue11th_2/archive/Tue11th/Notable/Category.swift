//
//  Category.swift
//  Notable
//
//  Created by abdullah cengiz on 30/10/14.
//  Copyright (c) 2014 abdullah cengiz. All rights reserved.
//

import Foundation

class Category
{
    var categoryId:String = "categoryId"
    var categoryName:String = "categoryName"
    var status: Bool = false
    
    init(){
        
        
    }
    
    
    init(categoryId:String, categoryName: String, status: Bool){
        self.categoryId = categoryId
        self.categoryName = categoryName
        self.status = status
    }
    
    
}
