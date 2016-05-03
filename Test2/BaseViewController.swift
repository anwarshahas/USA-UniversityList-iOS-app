//
//  BaseViewController.swift
//  Test2
//
//  Created by Shahas on 02/05/16.
//  Copyright © 2016 Bullfinch. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    func popCurrentViewController() {
        if let navController = self.navigationController {
            navController.popViewControllerAnimated(true)
        }
    }
    
}
