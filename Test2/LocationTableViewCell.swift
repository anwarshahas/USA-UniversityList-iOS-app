//
//  LocationTableViewCell.swift
//  Test2
//
//  Created by Shahas on 05/05/16.
//  Copyright © 2016 Bullfinch. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var tickImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if(selected) {
            self.tickImageView.hidden = false
        } else {
            self.tickImageView.hidden = true
        }

        // Configure the view for the selected state
    }
    
    func setLocation(title: String) {
        self.titleLabel.text = title
        self.tickImageView.hidden = true
    }
    

}
