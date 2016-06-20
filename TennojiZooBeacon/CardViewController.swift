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
    //Homeボタン
    @IBAction func backButton(sender: AnyObject) {
            let homeViewController = self.storyboard!.instantiateViewControllerWithIdentifier("home")
            self.presentViewController(homeViewController, animated: true, completion: nil)
    }

    //カードリストへボタン
    @IBAction func cardListButton(sender: AnyObject) {
        appDelegate.listFlg = false
        
        let cardListViewController = self.storyboard!.instantiateViewControllerWithIdentifier("cardlist")
        self.presentViewController(cardListViewController, animated: true, completion: nil)
    }
    
    //下のボタン
    //appDelegate.listFlgがtrueなら、カードリストからカードを表示された時の処理(戻るボタン)
    @IBAction func leftButton(sender: AnyObject) {
        if(appDelegate.listFlg){
            let cardListViewController = self.storyboard!.instantiateViewControllerWithIdentifier("cardlist")
            self.presentViewController(cardListViewController, animated: true, completion: nil)
            
        //falseなら、クイズに正解してカードが表示された時の処理(図鑑ボタン)
        }else{
            dictionaryURL()
        }
    }
    
    @IBAction func rightButton(sender: AnyObject) {
        if(appDelegate.listFlg){
            dictionaryURL()
            
            //次の問題へボタン
        }else{
            let routeViewController = self.storyboard!.instantiateViewControllerWithIdentifier("route")
            self.presentViewController(routeViewController, animated: true, completion: nil)
        }
        
    }
    //最初に宣言しておく
    let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    var base:String = "http://www.hz.kutc.kansai-u.ac.jp/city.osaka/tennoji_app/animal_reference.html?animal_id=z"
    var add:String = ""
    
    //初期化用の変数
    let defaultNunber:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        add = appDelegate.data[appDelegate.route][appDelegate.dictionaryID]
        
        //appDelegateに画像を配列で定義しておいて、配列番号で参照する。
        let img = UIImage(named: appDelegate.data[appDelegate.route][appDelegate.image])
        
        imageView!.image = img
        
        //カード獲得保存処理
        //カードを獲得したら、appDelegate.cardFlgをfalseからgetにかえる
        
        appDelegate.cardFlg[appDelegate.route] = "get"

        //NSUserDefaults型でディスク書き込み(カード獲得情報記録の準備)
        NSUserDefaults.standardUserDefaults().setObject(appDelegate.cardFlg, forKey: "cardGet")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        print(appDelegate.route)
        
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
    
    
    //動物ごとの図鑑に移動処理（Web）
    func dictionaryURL(){
        let URLString = base + add
        let url:NSURL = NSURL(string: URLString)!
        if UIApplication.sharedApplication().canOpenURL(url){
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}