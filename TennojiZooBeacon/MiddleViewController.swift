//
//  MiddleViewController.swift
//  TennojiZooBeacon
//
//  Created by 仲西 渉 on 2016/03/23.
//  Copyright © 2016年 nwatabou. All rights reserved.
//

import Foundation
import UIKit

class MiddleViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var countLabel: UILabel!
    @IBAction func homeButton(sender: AnyObject) {
        let homeViewController = self.storyboard!.instantiateViewControllerWithIdentifier("home")
        self.presentViewController(homeViewController, animated: true, completion: nil)
    }
    @IBAction func endButton(sender: AnyObject) {
        let finishViewController = self.storyboard!.instantiateViewControllerWithIdentifier("finish")
        self.presentViewController(finishViewController, animated: true, completion: nil)
    }
    @IBAction func nextButton(sender: AnyObject) {
        let routeViewController = self.storyboard!.instantiateViewControllerWithIdentifier("route")
        self.presentViewController(routeViewController, animated: true, completion: nil)
    }
    
    //最初に宣言しておく
    let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    var count = 0
    var i = 0
    
    override func viewDidLoad() {
        let img = UIImage(named: "tyukan.png")
        imageView.image = img
        
        for(i = 0;i < appDelegate.cardFlg.count;i += 1){
            if(appDelegate.cardFlg[i] == "get"){
                count += 1
            }
        }
        
        self.countLabel.text = "\(count)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}