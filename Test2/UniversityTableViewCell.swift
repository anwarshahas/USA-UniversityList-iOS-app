//
//  UniversityTableViewCell.swift
//  Test2
//
//  Created by Shahas on 02/05/16.
//  Copyright © 2016 Bullfinch. All rights reserved.
//

import UIKit
import Kingfisher

class UniversityTableViewCell: UITableViewCell {
    
    // UIView
    @IBOutlet weak var cellView: UIView!
    
    // UILabels
    @IBOutlet weak var universityNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityPinLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        initUIComponents()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUniversity(university:University) {
        initUIComponents()
        
        self.universityNameLabel.text = university.universityName
        self.addressLabel.text = university.address
        self.cityPinLabel.text = university.city + "-" + university.zip
        self.countryLabel.text = university.countryName
    }
    
    func initUIComponents() {
        self.imageView?.makeViewCircularWithBorderColor(kColorWhite, borderWidth: 1.0)
        imageView!.layer.masksToBounds = true;
        self.cellView.setCornerRadius(10.0)
    }

}
