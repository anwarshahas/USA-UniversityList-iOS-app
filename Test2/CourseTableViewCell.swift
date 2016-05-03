//
//  CourseTableViewCell.swift
//  Test2
//
//  Created by Shahas on 03/05/16.
//  Copyright © 2016 Bullfinch. All rights reserved.
//

import UIKit

class CourseTableViewCell: UITableViewCell {

    // UILabels
    @IBOutlet weak var courseNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCourse(name:String) {
        self.courseNameLabel.text = name
    }

}
