//
//  University.swift
//  Test2
//
//  Created by Shahas on 02/05/16.
//  Copyright © 2016 Bullfinch. All rights reserved.
//

import UIKit
import Alamofire

class University: NSObject {
    
    // Members

    var universityName: String
    var city: String
    var address: String
    var webAddress: String
    var zip: String
    var countryName: String
    
    
    init(name:String, address:String, city:String, countryName:String, zip:String, webAddress:String) {
        self.universityName = name
        self.address = address
        self.city = city
        self.countryName = countryName
        self.zip = zip
        self.webAddress = webAddress
    }
    
    class func parseUniversityDictionary(dictionary:Dictionary<String, AnyObject>)-> University {
        var university:University
        let name = dictionary["INSTNM"] as! String
        let address = dictionary["ADDR"] as! String
        let city = dictionary["CITY"] as! String
        let countryName = dictionary["COUNTYNM"] as! String
        let zip = dictionary["ZIP"] as! String
        let webAddress = dictionary["WEBADDR"] as! String
        
        university = University(name: name, address:address, city: city, countryName: countryName, zip: zip, webAddress: webAddress)
        return university
    }
    
    func convertArrayToSet(array:Array<String>)->Set<String> {
        var set:Set<String> = []
        for item in array {
            set.insert(item)
        }
        
        return set;
    }
    
   class func fetchAllRooms(completion: ([University]?) -> Void) {
        Alamofire.request(
            .GET,
            "https://inventory.data.gov/api/action/datastore_search?resource_id=38625c3d-5388-4c16-a30f-d105432553a4&limit=200",
            encoding: .URL)
            .validate()
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(response.result.error)")
                    completion(nil)
                    return
                }
                
                guard let value = response.result.value as? [String: AnyObject],
                    result = value["result"] as? [String: AnyObject],
                records = result["records"] as? [[String: AnyObject]] else {
                        print("Malformed data received from fetchAllRooms service")
                        completion(nil)
                        return
                }
                
                var universities: Array<University> = []
                
                for record in records {
                    let university = parseUniversityDictionary(record)
                    universities.append(university)
                }
                
                completion(universities)
        }
    }

    

}
