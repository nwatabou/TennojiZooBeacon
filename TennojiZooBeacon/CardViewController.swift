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
    @IBAction func backButton(_ sender: AnyObject) {
            let homeViewController = self.storyboard!.instantiateViewController(withIdentifier: "home")
            self.present(homeViewController, animated: true, completion: nil)
    }

    //カードリストへボタン
    @IBAction func cardListButton(_ sender: AnyObject) {
        appDelegate.listFlg = false
        
        let cardListViewController = self.storyboard!.instantiateViewController(withIdentifier: "cardlist")
        self.present(cardListViewController, animated: true, completion: nil)
    }
    
    //下のボタン
    //appDelegate.listFlgがtrueなら、カードリストからカードを表示された時の処理(戻るボタン)
    @IBAction func leftButton(_ sender: AnyObject) {
        if(appDelegate.listFlg){
            self.dismiss(animated: true, completion: nil)
            
        //falseなら、クイズに正解してカードが表示された時の処理(図鑑ボタン)
        }else{
            dictionaryURL()
        }
    }
    
    @IBAction func rightButton(_ sender: AnyObject) {
        if(appDelegate.listFlg){
            dictionaryURL()
            
            //次の問題へボタン
        }else{
            let routeViewController = self.storyboard!.instantiateViewController(withIdentifier: "route")
            self.present(routeViewController, animated: true, completion: nil)
        }
    }

    
    let appDelegate:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    let base:String = "http://www.hz.kutc.kansai-u.ac.jp/city.osaka/tennoji_app/animal_reference.html?animal_id=z"
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
        UserDefaults.standard.set(appDelegate.cardFlg, forKey: "cardGet")
        UserDefaults.standard.synchronize()
        
        if(appDelegate.listFlg){
            //カードリストから表示されたパターン
            backButton.setTitle("Home　　", for: UIControlState())
            rightButton.setTitle("詳しく！", for: UIControlState())
            leftButton.setTitle("カードリストへ", for: UIControlState())
            cardListButton.isHidden = true
        }else{
            //カードゲットした時パターン
            backButton.setTitle("Home　　", for: UIControlState())
            rightButton.setTitle("次へ", for: UIControlState())
            leftButton.setTitle("詳しく！", for: UIControlState())
            cardListButton.isHidden = false
        }
        
        
    }
    
    
    //動物ごとの図鑑に移動処理（Web）
    func dictionaryURL(){
        let URLString = base + add
        let url:URL = URL(string: URLString)!
        if UIApplication.shared.canOpenURL(url){
            UIApplication.shared.openURL(url)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
