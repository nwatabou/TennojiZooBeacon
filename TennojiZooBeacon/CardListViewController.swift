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
    
    @IBOutlet weak var backButton: UIButton!
    @IBAction func backButton(sender: AnyObject) {
        //カード表示された状況によって挙動の修正
        //flgがtrueならHome画面へ
        if(appDelegate.listFlg){
            appDelegate.route = defaultNum
            let homeViewController = self.storyboard!.instantiateViewControllerWithIdentifier("home")
            self.presentViewController(homeViewController, animated: true, completion: nil)
        //falseなら前の画面へ
        }else{
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    //セクション別に動物を定義
    //この辺のカード獲得保存処理スマートにしたいなー
    var honyurui = ["アミメキリン","アムールトラ","ヴィクトリアコアラ","カバ","カリフォルニアアシカ","コビトマングース","シシオザル","スナドリネコ","タイゾウ","チュウゴクオオカミ","チンパンジー","ヒガシクロサイ","ヒツジ","ピューマ","フサオネズミカンガルー","ホッキョクグマ","ムフロン","メガネグマ","ヤギ","ライオン"]
    var tyorui = ["コサンケイ","シロフクロウ","セーカーハヤブサ","チリーフラミンゴ","フンボルトペンギン","ホオアカトキ"]
    var hatyurui = ["ミシシッピワニ"]
    var ryoseirui = ["ホソオオトカゲ"]
    var gyorui = ["コイ"]

    let honyuruiSection = 0
    let tyoruiSection = 1
    let hatyuruiSection = 2
    let ryoseiruiSection = 3
    let gyoruiSection = 4

    let defaultNum = 0
    
    //この配列に画像名を格納
    let sections = ["ho.png","tyou.png","hatyu.png","ryou.png","gyo.png"]
    
    var displayWidth: CGFloat = 0.0
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
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
        
        if(appDelegate.listFlg){
            backButton.setTitle("Home　　", forState: .Normal)
        }else{
            backButton.setTitle("＜戻る　　", forState: .Normal)
        }
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
        if((defaults.objectForKey("cardGet")) != nil){
            appDelegate.cardFlg = (NSUserDefaults.standardUserDefaults().arrayForKey("cardGet") as? [String])!
        }
        
        switch section {
        case honyuruiSection:
            for i in defaultNum ..< honyurui.count{
                //次に、その配列と、appDelegateで定義した動物名の配列を回す
                for j in defaultNum ..< appDelegate.data.count{
                    //哺乳類の動物リストと、すべての動物リストを比較
                    if(honyurui[i] == appDelegate.data[j][appDelegate.name]){
                        //動物名が同じなら、その配列番号のカード獲得状況を参照
                        //getなら獲得
                        if(appDelegate.cardFlg[j] == "get"){
                            honyurui[i] = appDelegate.data[j][appDelegate.name]
                            //そうでないなら未獲得
                        }else{
                            honyurui[i] = "　　?　?　?"
                        }
                        break
                    }
                }
            }
            return honyurui.count
            
            
        case tyoruiSection:
            for i in defaultNum ..<  tyorui.count{
                for j in defaultNum ..< appDelegate.data.count{
                    if(tyorui[i] == appDelegate.data[j][appDelegate.name]){
                        if(appDelegate.cardFlg[j] == "get"){
                            tyorui[i] = appDelegate.data[j][appDelegate.name]
                        }else{
                            tyorui[i] = "　　?　?　?"
                        }
                        break
                    }
                }
            }
            return tyorui.count
            
            
        case hatyuruiSection:
            for i in defaultNum ..< hatyurui.count{
                for j in defaultNum ..< appDelegate.data.count{
                    if(hatyurui[i] == appDelegate.data[j][appDelegate.name]){
                        if(appDelegate.cardFlg[j] == "get"){
                            hatyurui[i] = appDelegate.data[j][appDelegate.name]
                        }else{
                            hatyurui[i] = "　　?　?　?"
                        }
                        break
                    }
                }
            }
            
            return hatyurui.count
            
            
            
        case ryoseiruiSection:
            for i in defaultNum ..< ryoseirui.count{
                for j in defaultNum ..< appDelegate.data.count{
                    if(ryoseirui[i] == appDelegate.data[j][appDelegate.name]){
                        if(appDelegate.cardFlg[j] == "get"){
                            ryoseirui[i] = appDelegate.data[j][appDelegate.name]
                        }else{
                            ryoseirui[i] = "　　?　?　?"
                        }
                        break
                    }
                }
            }
            return ryoseirui.count
            
            
        case gyoruiSection:
            for i in defaultNum ..< gyorui.count{
                for j in defaultNum ..< appDelegate.data.count{
                    if(gyorui[i] == appDelegate.data[j][appDelegate.name]){
                        if(appDelegate.cardFlg[j] == "get"){
                            gyorui[i] = appDelegate.data[j][appDelegate.name]
                        }else{
                            gyorui[i] = "　　?　?　?"
                        }
                        break
                    }
                }
            }
            return gyorui.count
            
            
        default:
            return 0
        }
    }
    
        /*
        if(section == honyuruiSection){
            //セクションごとの分類の配列を回す
            for i in defaultNum ..< honyurui.count{
                //次に、その配列と、appDelegateで定義した動物名の配列を回す
                for j in defaultNum ..< appDelegate.data.count{
                    //哺乳類の動物リストと、すべての動物リストを比較
                    if(honyurui[i] == appDelegate.data[j][appDelegate.name]){
                        //動物名が同じなら、その配列番号のカード獲得状況を参照
                        //getなら獲得
                        if(appDelegate.cardFlg[j] == "get"){
                           honyurui[i] = appDelegate.data[j][appDelegate.name]
                        //そうでないなら未獲得
                        }else{
                            honyurui[i] = "　　?　?　?"
                        }
                        break
                    }
                }
            }
            return honyurui.count
            
            
        }else if(section == tyoruiSection){
            for i in defaultNum ..<  tyorui.count{
                for j in defaultNum ..< appDelegate.data.count{
                    if(tyorui[i] == appDelegate.data[j][appDelegate.name]){
                        if(appDelegate.cardFlg[j] == "get"){
                            tyorui[i] = appDelegate.data[j][appDelegate.name]
                        }else{
                            tyorui[i] = "　　?　?　?"
                        }
                        break
                    }
                }
            }
            return tyorui.count
            
            
        }else if(section == hatyuruiSection){
            for i in defaultNum ..< hatyurui.count{
                for j in defaultNum ..< appDelegate.data.count{
                    if(hatyurui[i] == appDelegate.data[j][appDelegate.name]){
                        if(appDelegate.cardFlg[j] == "get"){
                            hatyurui[i] = appDelegate.data[j][appDelegate.name]
                        }else{
                            hatyurui[i] = "　　?　?　?"
                        }
                        break
                    }
                }
            }

            return hatyurui.count
            
            
        }else if(section == ryoseiruiSection){
            for i in defaultNum ..< ryoseirui.count{
                for j in defaultNum ..< appDelegate.data.count{
                    if(ryoseirui[i] == appDelegate.data[j][appDelegate.name]){
                        if(appDelegate.cardFlg[j] == "get"){
                            ryoseirui[i] = appDelegate.data[j][appDelegate.name]
                        }else{
                            ryoseirui[i] = "　　?　?　?"
                        }
                        break
                    }
                }
            }
            return ryoseirui.count
            
            
        }else if(section == gyoruiSection){
            for i in defaultNum ..< gyorui.count{
                for j in defaultNum ..< appDelegate.data.count{
                    if(gyorui[i] == appDelegate.data[j][appDelegate.name]){
                        if(appDelegate.cardFlg[j] == "get"){
                            gyorui[i] = appDelegate.data[j][appDelegate.name]
                        }else{
                            gyorui[i] = "　　?　?　?"
                        }
                        break
                    }
                }
            }
            return gyorui.count
            
        }else{
            return 0
        }
     }
 */
 

    

    
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
        switch indexPath.section {
        case honyuruiSection:
            cell.textLabel!.text = "\(honyurui[indexPath.row])"
            
        case tyoruiSection:
            cell.textLabel!.text = "\(tyorui[indexPath.row])"
            
        case hatyuruiSection:
            cell.textLabel!.text = "\(hatyurui[indexPath.row])"
            
        case ryoseiruiSection:
            cell.textLabel!.text = "\(ryoseirui[indexPath.row])"
            
        case gyoruiSection:
            cell.textLabel!.text = "\(gyorui[indexPath.row])"
            
        default:
            break
        }
        return cell
    }
    
    

    //選択されたcellを判断する処理
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //選択されたセル番号をセクションごとに判定
        //哺乳類セクション
        
        //軽量化コード
        //func()を使って処理をひとまとめにするといいかも？
        switch (indexPath.section){
        case honyuruiSection:
            for i in 0 ..< appDelegate.data.count{
                //選択されたセル番号の動物名と、AppDelegateで定義した動物リストと比較
                if(appDelegate.data[i][appDelegate.name] == honyurui[indexPath.row]){
                    //比較した動物名が同じで、その動物のカードを獲得していたら画面遷移
                    if(appDelegate.cardFlg[i] == "get"){
                        screenTransitionCardlist(i)
                        break
                    }
                }
            }
            
        case tyoruiSection:
            for i in defaultNum ..< appDelegate.data.count{
                if(appDelegate.data[i][appDelegate.name] == tyorui[indexPath.row]){
                    if(appDelegate.cardFlg[i] == "get"){
                        screenTransitionCardlist(i)
                        break
                    }
                }
            }
            
        case hatyuruiSection:
            for i in defaultNum ..< appDelegate.data.count{
                if(appDelegate.data[i][appDelegate.name] == hatyurui[indexPath.row]){
                    if(appDelegate.cardFlg[i] == "get"){
                        screenTransitionCardlist(i)
                        break
                    }
                }
            }
        
        case ryoseiruiSection:
            for i in defaultNum ..< appDelegate.data.count{
                if(appDelegate.data[i][appDelegate.name] == ryoseirui[indexPath.row]){
                    if(appDelegate.cardFlg[i] == "get"){
                        screenTransitionCardlist(i)
                        break
                    }
                }
            }
            
        case gyoruiSection:
            for i in defaultNum ..< appDelegate.data.count{
                if(appDelegate.data[i][appDelegate.name] == gyorui[indexPath.row]){
                    if(appDelegate.cardFlg[i] == "get"){
                        screenTransitionCardlist(i)
                        break
                    }
                }
            }
            
        default:
            break
        }
    }

    
    func screenTransitionCardlist(routeNumber:Int){
        //移動先でカードを表示するためにappDelegate.decideRouteに代入
        //appDelegate.listFlgをtrueにすることで、カード表示画面のボタン処理を変更
        appDelegate.route = routeNumber
        appDelegate.listFlg = true
        let cardViewController = self.storyboard!.instantiateViewControllerWithIdentifier("card")
        self.presentViewController(cardViewController, animated: true, completion: nil)
    }

}