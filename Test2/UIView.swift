//
//  UIView.swift
//  Test2
//
//  Created by Shahas on 02/05/16.
//  Copyright © 2016 Bullfinch. All rights reserved.
//

import Foundation
import QuartzCore
import ObjectiveC
import UIKit

extension UIView {
    
    func setBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        // function for setting top, right, botton or left border with color and thickness for uiviews and its subclass derivatives
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.Top:
            border.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), thickness)
            break
        case UIRectEdge.Bottom:
            border.frame = CGRectMake(0, CGRectGetHeight(self.frame) - thickness, CGRectGetWidth(self.frame), thickness)
            break
        case UIRectEdge.Left:
            border.frame = CGRectMake(0, 0, thickness, CGRectGetHeight(self.frame))
            break
        case UIRectEdge.Right:
            border.frame = CGRectMake(CGRectGetWidth(self.frame) - thickness, 0, thickness, CGRectGetHeight(self.frame))
            break
        default:
            break
        }
        
        border.backgroundColor = color.CGColor;
        
        self.layer.addSublayer(border)
    }
    
    func setBorder(color: UIColor, thickness: CGFloat) {
        //function for setting rectangular border for uiview and its subclass derivatives with color and thickness
        
        self.layer.borderColor = color.CGColor
        self.layer.borderWidth = thickness
    }
    
    func setCornerRadius(radius: CGFloat) {
        // function for setting corner radius for uiviews and its derivatives
        
        self.layer.cornerRadius = radius
    }
    
    func makeViewCircularWithBorderColor(color: UIColor, borderWidth: CGFloat) {
        self.layer.cornerRadius = self.frame.size.width/2.0
        self.clipsToBounds = true
        setBorder(color, thickness: borderWidth)
    }
}