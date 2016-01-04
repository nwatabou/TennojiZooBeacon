//
//  CardListViewController.swift
//  TennojiZooBeacon
//
//  Created by 仲西 渉 on 2015/12/29.
//  Copyright © 2015年 nwatabou. All rights reserved.
//

import Foundation
import UIKit

class CardListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var cardList: UITableView!
    
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    //セクション別に動物を定義
    var honyurui = ["アミメキリン","アムールトラ","ヴィクトリアコアラ","エリマキキツネザル","カルオニアアシカ","コビトマングース","シシオザル","タイゾウ","チュウゴクオオカミ","チンパンジー","ツシマヤマネコ","ヒガシクロサイ","フサオネズミカンガルー","フタコブラクダ","ホッキョクグマ","ムフロン","ライオン"]
    var tyorui = ["キーウイ","コサンケイ キジ","セーカーハヤブサ","ソデグロヅル","ニホンコウノトリ","フンボルトペンギン","ホオアカトキ","ワライカワセミ"]
    var hatyurui = ["ホウシャガメ","ヨウスコウワニ"]
    var ryoseirui = ["シリケンイモリ","ヘルメットガエル"]
    var gyorui = ["コイ"]

    //この配列に画像名を格納
    let sections = ["ho.png","tyou.png","hatyu.png","ryou.png","gyo.png"]
    
    var displayWidth: CGFloat = 0.0
    
    var cardGet = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayWidth = UIApplication.sharedApplication().statusBarFrame.size.width
        
        // Cell名の登録をおこなう.
        cardList.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        // DataSourceの設定をする.
        cardList.dataSource = self
        
        // Delegateを設定する.
        cardList.delegate = self
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    //sectionの数を返す
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    
    
    
    //cellの数を返す
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //ここの条件分岐でカードを獲得したのかしていないのか判定する
        let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        appDelegate.cardFlg = (NSUserDefaults.standardUserDefaults().arrayForKey("cardGet") as? [String])!
        
        
        if(section == 0){
            //セクションごとの分類の配列を回す
            for(var i = 0;i < honyurui.count; i++){
                //次に、その配列と、appDelegateで定義した動物名の配列を回す
                for(var j = 0;j < appDelegate.animals.count; j++){
                    //哺乳類の動物リストと、すべての動物リストを比較
                    if(honyurui[i] == appDelegate.animals[j]){
                        //動物名が同じなら、その配列番号のカード獲得状況を参照
                        //getなら獲得
                        if(appDelegate.cardFlg[j] == "get"){
                           honyurui[i] = appDelegate.animals[j]
                        //そうでないなら未獲得
                        }else{
                            honyurui[i] = "　　?　?　?"
                        }
                    }
                }
            }
            return honyurui.count
        }else if(section == 1){
            for(var i = 0;i < tyorui.count; i++){
                for(var j = 0;j < appDelegate.animals.count; j++){
                    if(tyorui[i] == appDelegate.animals[j]){
                        if(appDelegate.cardFlg[j] == "get"){
                            tyorui[i] = appDelegate.animals[j]
                        }else{
                            tyorui[i] = "　　?　?　?"
                        }
                    }
                }
            }

            return tyorui.count
        }else if(section == 2){
            for(var i = 0;i < hatyurui.count; i++){
                for(var j = 0;j < appDelegate.animals.count; j++){
                    if(hatyurui[i] == appDelegate.animals[j]){
                        if(appDelegate.cardFlg[j] == "get"){
                            hatyurui[i] = appDelegate.animals[j]
                        }else{
                            hatyurui[i] = "　　?　?　?"
                        }
                    }
                }
            }

            return hatyurui.count
        }else if(section == 3){
            for(var i = 0;i < ryoseirui.count; i++){
                for(var j = 0;j < appDelegate.animals.count; j++){
                    if(ryoseirui[i] == appDelegate.animals[j]){
                        if(appDelegate.cardFlg[j] == "get"){
                            ryoseirui[i] = appDelegate.animals[j]
                        }else{
                            ryoseirui[i] = "　　?　?　?"
                        }
                    }
                }
            }
            return ryoseirui.count
        }else if(section == 4){
            for(var i = 0;i < gyorui.count; i++){
                for(var j = 0;j < appDelegate.animals.count; j++){
                    if(gyorui[i] == appDelegate.animals[j]){
                        if(appDelegate.cardFlg[j] == "get"){
                            gyorui[i] = appDelegate.animals[j]
                        }else{
                            gyorui[i] = "　　?　?　?"
                        }
                    }
                }
            }
            return gyorui.count
        }else{
            return 0
        }
    }
    
    

    
    //sectionの記述処理
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section] as String
    }
    
    
    
    
    //セクション記述処理
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView()
        let sectionImage = UIImage(named: sections[section])
        let sectionImageView = UIImageView(image: sectionImage)
        sectionImageView.frame = CGRectMake(0, 0, displayWidth, 50)
        sectionView.addSubview(sectionImageView)
        
        return sectionView
    }
    
    
    

    //cellの記述処理
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        
        // Cellに値を設定する.
        //セクションごとにセルの記述処理をする
        if(indexPath.section == 0){
            cell.textLabel!.text = "\(honyurui[indexPath.row])"
        }else if(indexPath.section == 1){
            cell.textLabel!.text = "\(tyorui[indexPath.row])"
        }else if(indexPath.section == 2){
            cell.textLabel!.text = "\(hatyurui[indexPath.row])"
        }else if(indexPath.section == 3){
            cell.textLabel!.text = "\(ryoseirui[indexPath.row])"
        }else if(indexPath.section == 4){
            cell.textLabel!.text = "\(gyorui[indexPath.row])"
        }
        
        return cell
    }
    
    
    /*
    //選択されたcellを判断する処理
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        //選択されたセル番号をセクションごとに判定
        if(indexPath.section == 0){
            var i:Int
            for(i = 0; i < appDelegate.animals.count; i++){
                //選択されたセル番号の動物名と、AppDelegateで定義した動物リストと比較
                if(appDelegate.animals[i] == hatyurui[indexPath.row]){
                    //比較した動物名が同じで、その動物のカードを獲得していたら画面遷移
                    break
                }
                print(i)
            }
            if(appDelegate.cardFlg[i] == "get"){
                //移動先でカードを表示するためにappDelegate.decideRouteに代入
                appDelegate.decideRoute = i
                let cardViewController = self.storyboard!.instantiateViewControllerWithIdentifier("card")
                self.presentViewController(cardViewController, animated: true, completion: nil)
            }
        }else if(indexPath.section == 1){
            for(var i = 0; i < appDelegate.animals.count; i++){
                if(appDelegate.animals[i] == tyorui[indexPath.row]){
                    if(appDelegate.cardFlg[i] == "get"){
                        appDelegate.decideRoute = i
                        let cardViewController = self.storyboard!.instantiateViewControllerWithIdentifier("card")
                        self.presentViewController(cardViewController, animated: true, completion: nil)
                    }
                }
            }
        }else if(indexPath.section == 2){
            for(var i = 0; i < appDelegate.animals.count; i++){
                if(appDelegate.animals[i] == hatyurui[indexPath.row]){
                    if(appDelegate.cardFlg[i] == "get"){
                        appDelegate.decideRoute = i
                        let cardViewController = self.storyboard!.instantiateViewControllerWithIdentifier("card")
                        self.presentViewController(cardViewController, animated: true, completion: nil)
                    }
                }
            }
        }else if(indexPath.section == 3){
            for(var i = 0; i < appDelegate.animals.count; i++){
                if(appDelegate.animals[i] == ryoseirui[indexPath.row]){
                    if(appDelegate.cardFlg[i] == "get"){
                        appDelegate.decideRoute = i
                        let cardViewController = self.storyboard!.instantiateViewControllerWithIdentifier("card")
                        self.presentViewController(cardViewController, animated: true, completion: nil)
                    }
                }
            }
        }else if(indexPath.section == 4){
            for(var i = 0; i < appDelegate.animals.count; i++){
                if(appDelegate.animals[i] == gyorui[indexPath.row]){
                    if(appDelegate.cardFlg[i] == "get"){
                        appDelegate.decideRoute = i
                        let cardViewController = self.storyboard!.instantiateViewControllerWithIdentifier("card")
                        self.presentViewController(cardViewController, animated: true, completion: nil)
                    }
                }
            }
        }
        print(indexPath.row)
    }*/
}