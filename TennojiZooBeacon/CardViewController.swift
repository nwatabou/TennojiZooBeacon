//
//  CardViewController.swift
//  TennojiZooBeacon
//
//  Created by 仲西 渉 on 2015/12/31.
//  Copyright © 2015年 nwatabou. All rights reserved.
//

import Foundation
import UIKit

class CardViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var cardListButton: UIButton!
    
    @IBAction func homeButton(sender: AnyObject) {
        let homeViewController = self.storyboard!.instantiateViewControllerWithIdentifier("home")
        self.presentViewController(homeViewController, animated: true, completion: nil)
    }
    @IBAction func nextButton(sender: AnyObject) {
        let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        appDelegate.decideRoute = 0
        appDelegate.route = 0
        
        let routeViewController = self.storyboard!.instantiateViewControllerWithIdentifier("route")
        self.presentViewController(routeViewController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //appDelegateに画像を配列で定義しておいて、配列番号で参照する。
        let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let img = UIImage(named: appDelegate.image[appDelegate.decideRoute])
        
        imageView!.image = img
        
        //カード獲得保存処理
        //カードを獲得したら、appDelegate.cardFlgをfalseからgetにかえる
        appDelegate.cardFlg[appDelegate.decideRoute] = "get"
        //NSUserDefaults型でディスク書き込み(カード獲得情報記録の準備)
        NSUserDefaults.standardUserDefaults().setObject(appDelegate.cardFlg, forKey: "cardGet")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        
        print(appDelegate.cardFlg[appDelegate.decideRoute])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}