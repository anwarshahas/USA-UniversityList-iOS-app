//
//  FilterPopUpViewController.swift
//  Test2
//
//  Created by Shahas on 04/05/16.
//  Copyright © 2016 Bullfinch. All rights reserved.
//

import UIKit

public protocol FilterPopUpViewControllerDelegate {
    func applayButtonDidPressed(dictionary:Dictionary<String, AnyObject>, filteredLocations: Set<String>)
    func clearButtonDidPressed()
}


class FilterPopUpViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var locationTableView: UITableView!
    
    @IBOutlet weak var applayButton: UIButton!
    @IBOutlet weak var ascendingButton: UIButton!
    @IBOutlet weak var descendingButton: UIButton!
    var locations:Array<String> = []
    var filteredLocations:Set<String> = []
    var filterDictionary: Dictionary<String, AnyObject> = [:]
    
    var delegate: FilterPopUpViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.setCornerRadius(10)
        
        self.locationTableView.allowsMultipleSelection = true
        self.ascendingButton.selected = false
        self.descendingButton.selected = false
        initData()
        applayButton.setCornerRadius(10.0)
        //singleCornerRadius()

        // Do any additional setup after loading the view.
    }
    
    func singleCornerRadius() {
        let path = UIBezierPath(roundedRect:applayButton.bounds, byRoundingCorners:[.BottomRight], cornerRadii: CGSizeMake(10, 10))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.CGPath
        applayButton.layer.mask = maskLayer
    }
    
    func initData() {
        filterDictionary["sort"] = ["enable":false]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func applayButtonDidPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.delegate?.applayButtonDidPressed(filterDictionary, filteredLocations: filteredLocations)
    }
    @IBAction func clearButtonDidPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.delegate?.clearButtonDidPressed()
    }

    
    @IBAction func descendingButtonDidPressed(sender: AnyObject) {
        ascendingButton.selected = false
        if(descendingButton.selected) {
            descendingButton.selected = false
            filterDictionary["sort"] = ["enable":false]
        } else {
            descendingButton.selected = true
            filterDictionary["sort"] = ["enable":true, "order":"z-a"]
        }
    }
    @IBAction func ascendingButtonDidPressed(sender: AnyObject) {
        descendingButton.selected = false
        if(ascendingButton.selected) {
            ascendingButton.selected = false
            filterDictionary["sort"] = ["enable":false]
        } else {
            ascendingButton.selected = true
            filterDictionary["sort"] = ["enable":true, "order":"a-z"]
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FilterPopUpViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }
}

extension FilterPopUpViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("LocationTableViewCell", forIndexPath: indexPath) as! LocationTableViewCell
        let location = locations[indexPath.row]
        cell.setLocation(location)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
 
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
        filteredLocations.insert(locations[indexPath.row])
        /*
        let university = universityList[indexPath.row] as University
        pushDetailsViewController(university)
 */
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        //tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
        filteredLocations.remove(locations[indexPath.row])
    }
    
}

