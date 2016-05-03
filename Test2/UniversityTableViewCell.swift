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

    // UILImageViews
    @IBOutlet weak var universityImageView: UIImageView!
    
    // UIView
    @IBOutlet weak var cellView: UIView!
    
    // UILabels
    @IBOutlet weak var universityNameLabel: UILabel!
    @IBOutlet weak var universityPlaceLabel: UILabel!
    
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
        self.imageView!.kf_setImageWithURL(NSURL(string: university.universityImage)!, placeholderImage: UIImage(named: "homeBlack"))
        //self.imageView?.image = UIImage(named: "homeBlack")
        let imagenow = self.imageView?.image
        
        self.imageView!.image = resizeImage(imagenow!, newWidth: 60)
        self.universityNameLabel.text = university.universityName
        self.universityPlaceLabel.text = university.universityPlace
    }
    
    func initUIComponents() {
        self.imageView?.makeViewCircularWithBorderColor(kColorWhite, borderWidth: 1.0)
        imageView!.layer.masksToBounds = true;
        self.cellView.setCornerRadius(10.0)
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        //let newHeight = newWidth
        
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

}
