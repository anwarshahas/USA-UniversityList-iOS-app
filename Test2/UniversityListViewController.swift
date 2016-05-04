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
        University.fetchAllRooms { (universities: [University]?) in
            self.universityList = universities!
            self.universityListTable.reloadData()
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
        /*
        for university in originalCopyList {
            if(list.isSubsetOf(university.courses)) {
                filterList.append(university)
            }
        }
        
        universityList.removeAll()
        copyArray(filterList)
        if(universityList.count == 0) {
            let alert: UIAlertView = UIAlertView()
            alert.title = "Empty"
            alert.message = "Result not found"
            alert.addButtonWithTitle("Cancel")
            alert.delegate = self  // set the delegate here
            alert.show()
        }
        universityListTable.reloadData()
    */
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
        let university = universityList[indexPath.row] as University
        pushDetailsViewController(university)
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

extension UniversityListViewController:UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if(gestureRecognizer.isEqual(self.navigationController!.interactivePopGestureRecognizer)) {
            return false
        } else {
            return false
        }
        
    }
}
