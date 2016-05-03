//
//  FilterPopUp.swift
//  Test2
//
//  Created by Shahas on 03/05/16.
//  Copyright © 2016 Bullfinch. All rights reserved.
//

import UIKit

public protocol FilterPopUpDelegate {
    func doneButtonDidPressed(list:Set<String>)
    func cancelButtonDidPressed()
}

public class FilterPopUp: UIView {

    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var tick1: UIImageView!
    @IBOutlet weak var tick2: UIImageView!
    @IBOutlet weak var tick3: UIImageView!
    @IBOutlet weak var tick4: UIImageView!
    @IBOutlet weak var tick5: UIImageView!
    
    @IBOutlet weak var contentView: UIView!
    
    public var delegate: FilterPopUpDelegate?
    
    var filterList: Set<String> = []
    
    let filterMapDictionary:[String: String] = ["button1":"Engineering", "button2":"Medicine", "button3":"MBA Programme", "button4":"Arts and Science", "button5":"Mathematics"]
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    class func create() -> FilterPopUp {
        // Create Navigation Bar card
        let filterPopUp = NSBundle.mainBundle().loadNibNamed("FilterPopUp", owner: nil, options: nil)[0] as! FilterPopUp
        filterPopUp.showTickImage(filterPopUp.tick1, hide: true)
        filterPopUp.showTickImage(filterPopUp.tick2, hide: true)
        filterPopUp.showTickImage(filterPopUp.tick3, hide: true)
        filterPopUp.showTickImage(filterPopUp.tick4, hide: true)
        filterPopUp.showTickImage(filterPopUp.tick5, hide: true)
        
        filterPopUp.buttonSelected(filterPopUp.button1, selected: false)
        filterPopUp.buttonSelected(filterPopUp.button2, selected: false)
        filterPopUp.buttonSelected(filterPopUp.button3, selected: false)
        filterPopUp.buttonSelected(filterPopUp.button4, selected: false)
        filterPopUp.buttonSelected(filterPopUp.button5, selected: false)
        
        filterPopUp.contentView.setCornerRadius(10.0)
        filterPopUp.cancelButton.setBorder(UIColor.blackColor(), thickness: 1.0)
        filterPopUp.doneButton.setBorder(UIColor.blackColor(), thickness: 1.0)
        filterPopUp.doneButton.setCornerRadius(5.0)
        filterPopUp.cancelButton.setCornerRadius(5.0)
        return filterPopUp
    }
    
    func showTickImage(imageView:UIImageView, hide:Bool) {
        imageView.hidden = hide
    }
    
    func buttonSelected(button:UIButton, selected:Bool) {
        button.selected = selected
    }
    
    func buttonPress(button:UIButton, image:UIImageView) {
        if(button.selected) {
            showTickImage(image, hide: true)
            button.selected = false;
            setFilterList(button, append: false)
        } else {
            showTickImage(image, hide: false)
            button.selected = true
            setFilterList(button, append: true)
        }
    }
    
    func setFilterList(button:UIButton, append:Bool) {
        switch button {
        case button1:
            if(append) {
                filterList.insert(filterMapDictionary["button1"]!)
            } else {
                filterList.remove(filterMapDictionary["button1"]! as String)
            }
        case button2:
            if(append) {
                filterList.insert(filterMapDictionary["button2"]!)
            } else {
                filterList.remove(filterMapDictionary["button2"]! as String)
            }
        case button3:
            if(append) {
                filterList.insert(filterMapDictionary["button3"]!)
            } else {
                filterList.remove(filterMapDictionary["button3"]! as String)
            }
        case button4:
            if(append) {
                filterList.insert(filterMapDictionary["button4"]!)
            } else {
                filterList.remove(filterMapDictionary["button4"]! as String)
            }
        case button5:
            if(append) {
                filterList.insert(filterMapDictionary["button5"]!)
            } else {
                filterList.remove(filterMapDictionary["button5"]! as String)
            }
        default:
            return
        }
    }
    
    @IBAction func button1DidPressed(sender: AnyObject) {
        buttonPress(button1, image: tick1)
    }
    @IBAction func button2DidPressed(sender: AnyObject) {
        buttonPress(button2, image: tick2)
    }
    @IBAction func button3DidPressed(sender: AnyObject) {
        buttonPress(button3, image: tick3)
    }
    @IBAction func button4DidPressed(sender: AnyObject) {
        buttonPress(button4, image: tick4)
    }
    @IBAction func button5DidPressed(sender: AnyObject) {
        buttonPress(button5, image: tick5)
    }
    @IBAction func doneButtonDidPressed(sender: AnyObject) {
        self.delegate?.doneButtonDidPressed(filterList)
    }

    @IBAction func cancelButtonDidPressed(sender: AnyObject) {
        filterList.removeAll()
        self.delegate?.cancelButtonDidPressed()
    }
}
