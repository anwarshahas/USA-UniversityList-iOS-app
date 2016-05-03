//
//  UniversityDetailsViewController.swift
//  Test2
//
//  Created by Shahas on 03/05/16.
//  Copyright © 2016 Bullfinch. All rights reserved.
//

import UIKit

class UniversityDetailsViewController: BaseViewController {

    // UILabels
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    // UIImageViews
    @IBOutlet weak var imageView: UIImageView!
    
    // Member
    var selectedUniversity:University!
    
    // UITableViews
    @IBOutlet weak var courseTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUIComponents()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.interactivePopGestureRecognizer!.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initUIComponents() {
        
        self.imageView!.kf_setImageWithURL(NSURL(string: selectedUniversity.universityImage)!, placeholderImage: UIImage(named: "homeBlack"))
        self.nameLabel.text = selectedUniversity.universityName
        self.placeLabel.text = selectedUniversity.universityPlace
        navigationController?.interactivePopGestureRecognizer!.delegate = self
        //self.navigationController!.interactivePopGestureRecognizer!.enabled = true
        imageView.setCornerRadius(10.0)
        imageView.layer.masksToBounds = true
    }

    @IBAction func backButtonDidPressed(sender: AnyObject) {
        popCurrentViewController()
    }

}

extension UniversityDetailsViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }
}

extension UniversityDetailsViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedUniversity.courses.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CourseTableViewCell", forIndexPath: indexPath) as! CourseTableViewCell
        let name = selectedUniversity.courses[selectedUniversity.courses.startIndex.advancedBy(indexPath.row)]
        cell.setCourse(name)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
}

extension UniversityDetailsViewController:UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if(gestureRecognizer.isEqual(self.navigationController!.interactivePopGestureRecognizer)) {
            return true
        } else {
            return false
        }
        
    }
}
