//
//  FalseViewController.swift
//  TennojiZooBeacon
//
//  Created by 仲西 渉 on 2015/12/28.
//  Copyright © 2015年 nwatabou. All rights reserved.
//

import Foundation
import UIKit

class FalseViewController: UIViewController {
    
    
    @IBAction func nextButton(sender: AnyObject) {
        let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        appDelegate.decideRoute = 0
        appDelegate.route = 0
        
        let routeViewController = self.storyboard!.instantiateViewControllerWithIdentifier("route")
        self.presentViewController(routeViewController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}