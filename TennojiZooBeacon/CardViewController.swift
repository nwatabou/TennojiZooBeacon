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
    
    @IBOutlet weak var homeButton: UIButton!
    @IBAction func homeButton(sender: AnyObject) {
        if(appDelegate.listFlg){
            self.dismissViewControllerAnimated(true, completion: nil)
        }else{
            let homeViewController = self.storyboard!.instantiateViewControllerWithIdentifier("home")
            self.presentViewController(homeViewController, animated: true, completion: nil)
        }
    }
    @IBAction func nextButton(sender: AnyObject) {
        //カードを獲得した時は次の動物へ、カードリストからカードを表示した時は図鑑へ画面移動するようにする
        if(appDelegate.listFlg){
            /*ここに図鑑移動処理を書く
            
            appDelegateにID配列を作って、appDelegate.decideRouteで今表示中の配列番号を参照して飛ぶようにする？
            
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
            nextButton.setTitle("詳しく！", forState: .Normal)
            homeButton.setTitle("＜戻る　　", forState: .Normal)
        }else{
            nextButton.setTitle("次の動物へ", forState: .Normal)
            homeButton.setTitle("Home　　", forState: .Normal)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}