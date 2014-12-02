//
//  Point.swift
//  Notable
//
//  Created by abdullah cengiz on 23/10/14.
//  Copyright (c) 2014 abdullah cengiz. All rights reserved.
//

import Foundation
/*
NSUserDefaults.standardUserDefaults().objectForKey("highscoreName")

FIX 26/11!!!!!!!!!!
*/


class Point {
    
    var userName = "Alexander"
    var point = "point"
    var madelsImage = "madelsImage"
    
    init(userName: String, point: String, madelsImage: String){
        self.userName = userName
        self.point = point
        self.madelsImage = madelsImage
        
    }
}

