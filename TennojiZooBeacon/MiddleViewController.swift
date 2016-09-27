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
    
    @IBAction func homeButton(_ sender: AnyObject) {
        let homeViewController = self.storyboard!.instantiateViewController(withIdentifier: "home")
        self.present(homeViewController, animated: true, completion: nil)
    }
    
    @IBAction func endButton(_ sender: AnyObject) {
        let finishViewController = self.storyboard!.instantiateViewController(withIdentifier: "finish")
        self.present(finishViewController, animated: true, completion: nil)
    }
    
    @IBAction func nextButton(_ sender: AnyObject) {
        let routeViewController = self.storyboard!.instantiateViewController(withIdentifier: "route")
        self.present(routeViewController, animated: true, completion: nil)
    }
    
    //最初に宣言しておく
    let appDelegate:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    let defaultNumber = 0
    
    let defaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        if((defaults.object(forKey: "cardGet")) != nil){
            appDelegate.cardFlg = (UserDefaults.standard.array(forKey: "cardGet") as? [String])!
        }
        
        var count = defaultNumber
        
        let img = UIImage(named: "tyukan.png")
        imageView.image = img
        
        for i in 0 ..< appDelegate.data.count {
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
