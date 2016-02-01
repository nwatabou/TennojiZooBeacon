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
    
    //NavigationBarに表示されるボタン
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var cardListButton: UIButton!
    
    //下に表示されるボタン
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!

    
    //上のボタン
    @IBAction func backButton(sender: AnyObject) {
            appDelegate.decideRoute = 0
            let homeViewController = self.storyboard!.instantiateViewControllerWithIdentifier("home")
            self.presentViewController(homeViewController, animated: true, completion: nil)
    }

    @IBAction func cardListButton(sender: AnyObject) {
        appDelegate.listFlg = false
        
        let cardListViewController = self.storyboard!.instantiateViewControllerWithIdentifier("cardlist")
        self.presentViewController(cardListViewController, animated: true, completion: nil)
    }
    
    //下のボタン
    @IBAction func leftButton(sender: AnyObject) {
        if(appDelegate.listFlg){
            appDelegate.decideRoute = 0
            
            let cardListViewController = self.storyboard!.instantiateViewControllerWithIdentifier("cardlist")
            self.presentViewController(cardListViewController, animated: true, completion: nil)
        }else{
            /*
            ここに図鑑移動処理を書く
            URL + id = ○○
            */
        }
    }
    
    @IBAction func rightButton(sender: AnyObject) {
        if(appDelegate.listFlg){
            /*
            ここに図鑑移動処理を書く
            URL + id = ○○
            */
        }else{
            appDelegate.decideRoute = 0
            appDelegate.route = 0
            
            let routeViewController = self.storyboard!.instantiateViewControllerWithIdentifier("route")
            self.presentViewController(routeViewController, animated: true, completion: nil)
        }
        
    }
    //最初に宣言しておく
    let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //appDelegateに画像を配列で定義しておいて、配列番号で参照する。
        let img = UIImage(named: appDelegate.image[appDelegate.decideRoute])
        
        imageView!.image = img
        
        //カード獲得保存処理
        //カードを獲得したら、appDelegate.cardFlgをfalseからgetにかえる
        appDelegate.cardFlg[appDelegate.decideRoute] = "get"
        //NSUserDefaults型でディスク書き込み(カード獲得情報記録の準備)
        NSUserDefaults.standardUserDefaults().setObject(appDelegate.cardFlg, forKey: "cardGet")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        
        print(appDelegate.cardFlg[appDelegate.decideRoute])
        
        
        if(appDelegate.listFlg){
            //カードリストから表示されたパターン
            backButton.setTitle("Home　　", forState: .Normal)
            rightButton.setTitle("詳しく！", forState: .Normal)
            leftButton.setTitle("カードリストへ", forState: .Normal)
            cardListButton.hidden = true
        }else{
            //カードゲットした時パターン
            backButton.setTitle("Home　　", forState: .Normal)
            rightButton.setTitle("次へ", forState: .Normal)
            leftButton.setTitle("詳しく！", forState: .Normal)
            cardListButton.hidden = false
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}