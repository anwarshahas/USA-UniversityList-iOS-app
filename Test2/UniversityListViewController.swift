//
//  UniversityListViewController.swift
//  Test2
//
//  Created by Shahas on 02/05/16.
//  Copyright © 2016 Bullfinch. All rights reserved.
//

import UIKit

class UniversityListViewController: BaseViewController {

    // Table view
    @IBOutlet weak var universityListTable: UITableView!
    
    // Members
    var universityList: Array<University> = []
    var filterPopUp = FilterPopUp()
    var filterList: Array<University> = []
    var originalCopyList: Array<University> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUniversityList()
        universityListTable.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func initUIComponents() {
        
    }
    
    func initUIConstrinats() {
        
    }
    
    func createUniversityList() {
        
        //let path = NSBundle.mainBundle().pathForResource("Universities", ofType: "json")

        
        //let data = NSData(contentsOfURL: NSURL(fileURLWithPath: path!), options: NSDataReadingOptions.DataReadingMappedIfSafe)
        //let jsonObj = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
        //convertJsonIntoUniversityModel(jsonObj["university"])
 
        
        if let path = NSBundle.mainBundle().pathForResource("Universities", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                do {
                    let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    if let universities: [NSDictionary] = jsonResult["universities"] as? [NSDictionary] {
                        convertJsonIntoUniversityModel(universities)
                    }
                } catch {}
            } catch {}
        }
        
    }
    
    func showFilterPopUp() {
        if(view.subviews.contains(filterPopUp)) {
            filterPopUp.hidden = false
        } else {
            filterPopUp = FilterPopUp.create()
            filterPopUp.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
            filterPopUp.delegate = self
            view.insertSubview(filterPopUp, aboveSubview: view)
        }
        
    }
    
    func dismissFilterPopUp() {
        filterPopUp.hidden = true
    }
 
    @IBAction func filterButtonDidPressed(sender: AnyObject) {
        showFilterPopUp()
    }
    
    func convertJsonIntoUniversityModel(objects: Array<NSDictionary>) {
        for object in objects {
            let university = University.parseUniversityDictionary(object as! Dictionary<String, AnyObject>) as University
            universityList.append(university)
            originalCopyList.append(university)
        }
    }
    
    func filterFromList(list:Set<String>) {
        
        filterList.removeAll()
        
        for university in originalCopyList {
            if(list.isSubsetOf(university.courses)) {
                filterList.append(university)
            }
        }
        
        universityList.removeAll()
        copyArray(filterList)
        universityListTable.reloadData()
    }
    
    func copyArray(array:Array<University>) {
        universityList.removeAll()
        for item in array {
            universityList.append(item)
        }
    }
    
    func refreshPage() {
        universityList.removeAll()
        for university in originalCopyList {
            universityList.append(university)
        }
        universityListTable.reloadData()
    }
    
}



extension UniversityListViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 85
    }
}

extension UniversityListViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.universityList.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("UniversityTableViewCell", forIndexPath: indexPath) as! UniversityTableViewCell
        let university = universityList[indexPath.row]
        cell.setUniversity(university)
        cell.imageView!.layer.cornerRadius = cell.imageView!.frame.size.width / 2.0;
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
 
}

extension UniversityListViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if self.universityListTable == scrollView {
            
        }
    }
}

extension UniversityListViewController: FilterPopUpDelegate {
    
    func cancelButtonDidPressed() {
        dismissFilterPopUp()
        filterPopUp.removeFromSuperview()
        refreshPage()
    }
    
    func doneButtonDidPressed(list:Set<String>) {
        dismissFilterPopUp()
        filterFromList(list)
    }
    
}