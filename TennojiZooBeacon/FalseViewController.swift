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
    
    @IBOutlet weak var imageVIew: UIImageView!
    
    @IBAction func nextButton(sender: AnyObject) {
        let comentViewController = self.storyboard!.instantiateViewControllerWithIdentifier("coment")
        self.presentViewController(comentViewController, animated: true, completion: nil)
    }
    
    //最初に宣言しておく
    let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImage(named: "false.png")
        imageVIew.image = img
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}