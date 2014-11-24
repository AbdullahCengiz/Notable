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
    var categoryId:Int?
    var categoryName:String?
    var categoryPosition:Int?
    var categoryReqLevel:Int?
    var status: Bool?
    
    init(){
        
    }

    init(categoriesRowArray:NSArray){
        categoryId = categoriesRowArray[0] as? Int
        categoryName = categoriesRowArray[1] as? String
        categoryPosition = categoriesRowArray[2] as? Int
        status = false
    }

}
