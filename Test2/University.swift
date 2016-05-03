//
//  University.swift
//  Test2
//
//  Created by Shahas on 02/05/16.
//  Copyright © 2016 Bullfinch. All rights reserved.
//

import UIKit

class University: NSObject {
    
    var id:Int
    var universityName:String
    var universityPlace:String
    var universityImage:String
    var courses:Set<String>
    
    init(id:Int, name:String, place:String, image:String, courses:Set<String>) {
        self.id = id
        self.universityName = name
        self.universityPlace = place
        self.universityImage = image
        self.courses = courses
    }
    
    class func parseUniversityDictionary(dictionary:Dictionary<String, AnyObject>)-> University {
        var university:University
        let id = dictionary["id"] as! Int
        let name = dictionary["name"] as! String
        let place = dictionary["place"] as! String
        let image = dictionary["image"] as! String
        let coursesArray = dictionary["courses"] as! Array<String>
        //let courses = convertArrayToSet(coursesArray) as! Set<String>
        var set:Set<String> = []
        for item in coursesArray {
            set.insert(item)
        }
        let courses = set
        university = University(id: id, name: name, place: place, image: image, courses: courses)
        return university
    }
    
    func convertArrayToSet(array:Array<String>)->Set<String> {
        var set:Set<String> = []
        for item in array {
            set.insert(item)
        }
        
        return set;
    }
    

}
