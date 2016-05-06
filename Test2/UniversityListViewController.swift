//
//  UniversityListViewController.swift
//  Test2
//
//  Created by Shahas on 02/05/16.
//  Copyright © 2016 Bullfinch. All rights reserved.
//

import UIKit
import JGProgressHUD

class UniversityListViewController: BaseViewController, UIPopoverPresentationControllerDelegate {

    // Table view
    @IBOutlet weak var universityListTable: UITableView!
    
    // Members
    var universityList: Array<University> = []
    var filterPopUp = FilterPopUp()
    var filterList: Array<University> = []
    var originalCopyList: Array<University> = []
    
    var filterPopUpViewController = FilterPopUpViewController()
    
    var locations:Array<String> = []
    
    var presented:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        initUIComponents()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //universityListTable.reloadData()
    }
    
    func initUIComponents() {
        //self.navigationController!.interactivePopGestureRecognizer!.enabled = false
        self.navigationController!.interactivePopGestureRecognizer!.delegate = self;
    }
    
    func initUIConstrinats() {
        
    }
    
    func fetchData() {
        let hud = JGProgressHUD(style: JGProgressHUDStyle.Dark)
        
        hud.textLabel.text = "Fetching Data"
        hud.showInView(self.view)
        
        /*
        JGProgressHUD *HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
        HUD.textLabel.text = @"Loading";
        [HUD showInView:self.view];
        [HUD dismissAfterDelay:3.0];
 */
        University.fetchAllRooms { (status: Bool, universities: [University]?) in
            hud.dismiss()
            if(status) {
                self.universityList = universities!
                self.originalCopyList = universities!
                self.universityListTable.reloadData()
                self.createLocationList()
            }
        }
    }
    
    func createLocationList() {
        var locationList: Set<String> = []
        for university in universityList {
            locationList.insert(university.countryName)
        }
        
        locations = Array(locationList).sort()
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
        //showFilterPopUp()
        showFilterPopUpViewController(sender)
    }
    
    func showFilterPopUpViewController(sender: AnyObject) {
        
        if(presented) {
            presentViewController(filterPopUpViewController, animated: true, completion: nil)
        } else {
            let storyboard : UIStoryboard = UIStoryboard(
                name: "Main",
                bundle: nil)
            let menuViewController: FilterPopUpViewController = storyboard.instantiateViewControllerWithIdentifier("FilterPopUpViewController") as! FilterPopUpViewController
            
            menuViewController.locations = self.locations
            menuViewController.delegate = self
            
            menuViewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
//            menuViewController.preferredContentSize = CGSizeMake(100, 100)
            menuViewController.definesPresentationContext = true
            
            self.filterPopUpViewController = menuViewController
            
//            let popoverMenuViewController = menuViewController.popoverPresentationController
            
//            popoverMenuViewController?.delegate = self
            
//            popoverMenuViewController!.sourceView = self.view
 //           popoverMenuViewController!.sourceRect = self.view.bounds
            //popoverMenuViewController!.backgroundColor = UIColor.clearColor()
            
   //         popoverMenuViewController!.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0)
            //popoverController.sourceRect = CGRectMake(width/4, hieght/4, width/2, hieght/2);
            presented = true
            presentViewController(menuViewController, animated: true, completion: nil)
        }
    }
    
    func convertJsonIntoUniversityModel(objects: Array<NSDictionary>) {
        for object in objects {
            let university = University.parseUniversityDictionary(object as! Dictionary<String, AnyObject>) as University
            universityList.append(university)
            originalCopyList.append(university)
        }
    }
    
    func filterFromList(dictionary:Dictionary<String, AnyObject>, filteredLocations: Set<String>) {
        
        universityList.removeAll()
        
        if(filteredLocations.count > 0) {
            filterList.removeAll()
            for university in originalCopyList {
                if(filteredLocations.contains(university.countryName)) {
                    filterList.append(university)
                }
            }
        } else {
            filterList = originalCopyList
        }
        
        if(dictionary["sort"]!["enable"] as! Bool) {
            if(dictionary["sort"]!["order"] as! String == "a-z") {
                
                universityList = filterList.sort {$0.universityName < $1.universityName }
            } else if(dictionary["sort"]!["order"] as! String == "z-a") {

                universityList = filterList.sort {$0.universityName > $1.universityName }
            }
            universityListTable.reloadData()
        } else {
            universityList = filterList
            universityListTable.reloadData()
        }
        
        
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
    
    func pushDetailsViewController(university:University) {
        let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let detailsViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("UniversityDetailsViewController") as! UniversityDetailsViewController
        detailsViewController.selectedUniversity = university
        self.navigationController!.pushViewController(detailsViewController, animated: true)
    }
    
}



extension UniversityListViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110
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
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //let university = universityList[indexPath.row] as University
        //pushDetailsViewController(university)
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
        
    }
    
}


extension UniversityListViewController: FilterPopUpViewControllerDelegate {
    
    func clearButtonDidPressed() {
        dismissFilterPopUp()
        filterPopUp.removeFromSuperview()
        presented = false
        refreshPage()
    }
    
    func applayButtonDidPressed(dictionary:Dictionary<String, AnyObject>, filteredLocations: Set<String>) {
        dismissFilterPopUp()
        filterFromList(dictionary, filteredLocations: filteredLocations)
    }
    
}



extension UniversityListViewController:UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if(gestureRecognizer.isEqual(self.navigationController!.interactivePopGestureRecognizer)) {
            return false
        } else {
            return false
        }
        
    }
}
