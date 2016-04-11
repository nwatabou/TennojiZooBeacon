//
//  FinishViewController.swift
//  TennojiZooBeacon
//
//  Created by 仲西 渉 on 2016/03/23.
//  Copyright © 2016年 nwatabou. All rights reserved.
//

import Foundation
import UIKit

class FinishViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBAction func homeButton(sender: AnyObject) {
        let homeViewController = self.storyboard!.instantiateViewControllerWithIdentifier("home")
        self.presentViewController(homeViewController, animated: true, completion: nil)
    }
    
    let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    var count = 0
    var i = 0
    
    //日付を扱う変数
    let now = NSDate()
    
    override func viewDidLoad() {
        let img = UIImage(named: "finish.png")
        imageView.image = img
        
        for(i=0;i<appDelegate.cardFlg.count;i += 1){
            if(appDelegate.cardFlg[i] == "get"){
                count += 1
            }
        }
        self.countLabel.text = "\(count)"

        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy年　MM月　dd日"
        let string = formatter.stringFromDate(now)
        self.dateLabel.text = string
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}