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
        //カード表示された状況によって挙動の修正
        if(appDelegate.listFlg){
            appDelegate.decideRoute = 0
            let homeViewController = self.storyboard!.instantiateViewControllerWithIdentifier("home")
            self.presentViewController(homeViewController, animated: true, completion: nil)
        }else{
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    //セクション別に動物を定義
    //この辺のカード獲得保存処理スマートにしたいなー
    let honyurui = ["アミメキリン","アムールトラ","ヴィクトリアコアラ","カリフォルニアアシカ","コビトマングース","シシオザル","タイゾウ","チュウゴクオオカミ","チンパンジー","ヒガシクロサイ","ヒツジ","フサオネズミカンガルー","フタコブラクダ","ホッキョクグマ","ムフロン","メガネグマ","ライオン"]
    let tyorui = ["コサンケイ","シロフクロウ","セーカーハヤブサ","ソデグロヅル","チリーフラミンゴ","ニホンコウノトリ","フンボルトペンギン","ホオアカトキ"]
    let hatyurui = ["ヨウスコウワニ"]
    let ryoseirui = ["シリケンイモリ"]
    let gyorui = ["コイ"]
    
    var Hhonyurui = ["","","","","","","","","","","","","","","","",""]
    var Htyorui = ["","","","","","","",""]
    var Hhatyurui = [""]
    var Hryoseirui = [""]
    var Hgyorui = [""]

    let honyuruiSection = 0
    let tyoruiSection = 1
    let hatyuruiSection = 2
    let ryoseiruiSection = 3
    let gyoruiSection = 4
    
    
    //この配列に画像名を格納
    let sections = ["ho.png","tyou.png","hatyu.png","ryou.png","gyo.png"]
    
    var displayWidth: CGFloat = 0.0
    
    //最初に宣言しておく
    let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
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
        appDelegate.cardFlg = (NSUserDefaults.standardUserDefaults().arrayForKey("cardGet") as? [String])!
        
        
        if(section == honyuruiSection){
            //セクションごとの分類の配列を回す
            for(var i = 0;i < honyurui.count; i++){
                //次に、その配列と、appDelegateで定義した動物名の配列を回す
                for(var j = 1;j < appDelegate.animals.count; j++){
                    //哺乳類の動物リストと、すべての動物リストを比較
                    if(honyurui[i] == appDelegate.animals[j]){
                        //動物名が同じなら、その配列番号のカード獲得状況を参照
                        //getなら獲得
                        if(appDelegate.cardFlg[j] == "get"){
                           Hhonyurui[i] = appDelegate.animals[j]
                        //そうでないなら未獲得
                        }else{
                            Hhonyurui[i] = "　　?　?　?"
                        }
                    }
                }
            }
            return honyurui.count
            
            
        }else if(section == tyoruiSection){
            for(var i = 0;i < tyorui.count; i++){
                for(var j = 0;j < appDelegate.animals.count; j++){
                    if(tyorui[i] == appDelegate.animals[j]){
                        if(appDelegate.cardFlg[j] == "get"){
                            Htyorui[i] = appDelegate.animals[j]
                        }else{
                            Htyorui[i] = "　　?　?　?"
                        }
                    }
                }
            }
            return tyorui.count
            
            
        }else if(section == hatyuruiSection){
            for(var i = 0;i < hatyurui.count; i++){
                for(var j = 0;j < appDelegate.animals.count; j++){
                    if(hatyurui[i] == appDelegate.animals[j]){
                        if(appDelegate.cardFlg[j] == "get"){
                            Hhatyurui[i] = appDelegate.animals[j]
                        }else{
                            Hhatyurui[i] = "　　?　?　?"
                        }
                    }
                }
            }

            return hatyurui.count
            
            
        }else if(section == ryoseiruiSection){
            for(var i = 0;i < ryoseirui.count; i++){
                for(var j = 0;j < appDelegate.animals.count; j++){
                    if(ryoseirui[i] == appDelegate.animals[j]){
                        if(appDelegate.cardFlg[j] == "get"){
                            Hryoseirui[i] = appDelegate.animals[j]
                        }else{
                            Hryoseirui[i] = "　　?　?　?"
                        }
                    }
                }
            }
            return ryoseirui.count
            
            
        }else if(section == gyoruiSection){
            for(var i = 0;i < gyorui.count; i++){
                for(var j = 0;j < appDelegate.animals.count; j++){
                    if(gyorui[i] == appDelegate.animals[j]){
                        if(appDelegate.cardFlg[j] == "get"){
                            Hgyorui[i] = appDelegate.animals[j]
                        }else{
                            Hgyorui[i] = "　　?　?　?"
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
        if(indexPath.section == hatyuruiSection){
            cell.textLabel!.text = "\(Hhonyurui[indexPath.row])"
            
        }else if(indexPath.section == tyoruiSection){
            cell.textLabel!.text = "\(Htyorui[indexPath.row])"
            
        }else if(indexPath.section == hatyuruiSection){
            cell.textLabel!.text = "\(Hhatyurui[indexPath.row])"
            
        }else if(indexPath.section == ryoseiruiSection){
            cell.textLabel!.text = "\(Hryoseirui[indexPath.row])"
            
        }else if(indexPath.section == gyoruiSection){
            cell.textLabel!.text = "\(Hgyorui[indexPath.row])"
        }
        
        return cell
    }
    
    

    //選択されたcellを判断する処理
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //選択されたセル番号をセクションごとに判定
        //哺乳類セクション
        if(indexPath.section == honyuruiSection){
            var i:Int
            for(i = 0; i < appDelegate.animals.count - 1; i++){
                //選択されたセル番号の動物名と、AppDelegateで定義した動物リストと比較
                if(appDelegate.animals[i] == honyurui[indexPath.row]){
                    //比較した動物名が同じで、その動物のカードを獲得していたら画面遷移
                    break
                }
            }
            if(appDelegate.cardFlg[i] == "get"){
                //移動先でカードを表示するためにappDelegate.decideRouteに代入
                //appDelegate.listFlgをtrueにすることで、カード表示画面のボタン処理を変更
                appDelegate.decideRoute = i
                appDelegate.listFlg = true
                let cardViewController = self.storyboard!.instantiateViewControllerWithIdentifier("card")
                self.presentViewController(cardViewController, animated: true, completion: nil)
            }
            
            
            
            //鳥類セクション
        }else if(indexPath.section == tyoruiSection){
            var i:Int
            for(i = 0; i < appDelegate.animals.count; i++){
                if(appDelegate.animals[i] == tyorui[indexPath.row]){
                    break
                }
            }
            if(appDelegate.cardFlg[i] == "get"){
                appDelegate.decideRoute = i
                appDelegate.listFlg = true
                let cardViewController = self.storyboard!.instantiateViewControllerWithIdentifier("card")
                self.presentViewController(cardViewController, animated: true, completion: nil)
            }
            
            
            //爬虫類セクション
        }else if(indexPath.section == hatyuruiSection){
            var i:Int
            for(i = 0; i < appDelegate.animals.count; i++){
                if(appDelegate.animals[i] == hatyurui[indexPath.row]){
                    break
                }
            }
            if(appDelegate.cardFlg[i] == "get"){
                appDelegate.decideRoute = i
                appDelegate.listFlg = true
                let cardViewController = self.storyboard!.instantiateViewControllerWithIdentifier("card")
                self.presentViewController(cardViewController, animated: true, completion: nil)
            }

            
            
            //両生類セクション
        }else if(indexPath.section == ryoseiruiSection){
            var i:Int
            for(i = 0; i < appDelegate.animals.count; i++){
                if(appDelegate.animals[i] == ryoseirui[indexPath.row]){
                    break
                }
            }
            if(appDelegate.cardFlg[i] == "get"){
                appDelegate.decideRoute = i
                appDelegate.listFlg = true
                let cardViewController = self.storyboard!.instantiateViewControllerWithIdentifier("card")
                self.presentViewController(cardViewController, animated: true, completion: nil)
            }

            
            
            //魚類セクション
        }else if(indexPath.section == gyoruiSection){
            var i:Int
            for(i = 0; i < appDelegate.animals.count; i++){
                if(appDelegate.animals[i] == ryoseirui[indexPath.row]){
                    break
                }
            }
            if(appDelegate.cardFlg[i] == "get"){
                appDelegate.decideRoute = i
                appDelegate.listFlg = true
                let cardViewController = self.storyboard!.instantiateViewControllerWithIdentifier("card")
                self.presentViewController(cardViewController, animated: true, completion: nil)
            }
        }
    }
}