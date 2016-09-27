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
    @IBAction func backButton(_ sender: AnyObject) {
        //カード表示された状況によって挙動の修正
        //flgがtrueならHome画面へ
        if(appDelegate.listFlg){
            appDelegate.route = defaultNum
            self.dismiss(animated: true, completion: nil)
            //let homeViewController = self.storyboard!.instantiateViewControllerWithIdentifier("home")
            //self.presentViewController(homeViewController, animated: true, completion: nil)
        //falseなら前の画面へ
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    //セクション別に動物を定義
    //この辺のカード獲得保存処理スマートにしたいなー
    var honyurui:Array = ["アミメキリン","アムールトラ","ヴィクトリアコアラ","カバ","カリフォルニアアシカ","コビトマングース","シシオザル","スナドリネコ","タイゾウ","チュウゴクオオカミ","チンパンジー","ヒガシクロサイ","ヒツジ","ピューマ","フサオネズミカンガルー","ホッキョクグマ","ムフロン","メガネグマ","ヤギ","ライオン"]
    var tyorui:Array = ["コサンケイ","シロフクロウ","セーカーハヤブサ","チリーフラミンゴ","フンボルトペンギン","ホオアカトキ"]
    var hatyurui:Array = ["ミシシッピワニ"]
    var ryoseirui:Array = ["ホソオオトカゲ"]
    var gyorui:Array = ["コイ"]

    let honyuruiSection:Int = 0
    let tyoruiSection:Int = 1
    let hatyuruiSection:Int = 2
    let ryoseiruiSection:Int = 3
    let gyoruiSection:Int = 4

    let defaultNum:Int = 0
    
    //この配列に画像名を格納
    let sections:Array = ["ho.png","tyou.png","hatyu.png","ryou.png","gyo.png"]
    
    var displayWidth: CGFloat = 0.0
    
    let defaults = UserDefaults.standard

    let appDelegate:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayWidth = UIApplication.shared.statusBarFrame.size.width
        
        // Cell名の登録をおこなう.
        cardList.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        // DataSourceの設定をする.
        cardList.dataSource = self
        
        // Delegateを設定する.
        cardList.delegate = self
        
        if(appDelegate.listFlg){
            backButton.setTitle("Home　　", for: UIControlState())
        }else{
            backButton.setTitle("＜戻る　　", for: UIControlState())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    //sectionの数を返す
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    
    
    
    //cellの数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //ここの条件分岐でカードを獲得したのかしていないのか判定する
        if((defaults.object(forKey: "cardGet")) != nil){
            appDelegate.cardFlg = (UserDefaults.standard.array(forKey: "cardGet") as? [String])!
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
 

    

    
    //sectionの記述処理
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section] as String
    }
    
    
    
    
    //セクション記述処理
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView()
        let sectionImage = UIImage(named: sections[section])
        let sectionImageView = UIImageView(image: sectionImage)
        sectionImageView.frame = CGRect(x: 0, y: 0, width: displayWidth, height: 50)
        sectionView.addSubview(sectionImageView)
        
        return sectionView
    }
    
    
    

    //cellの記述処理
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        // Cellに値を設定する.
        //セクションごとにセルの記述処理をする
        switch (indexPath as NSIndexPath).section {
        case honyuruiSection:
            cell.textLabel!.text = "\(honyurui[(indexPath as NSIndexPath).row])"
            
        case tyoruiSection:
            cell.textLabel!.text = "\(tyorui[(indexPath as NSIndexPath).row])"
            
        case hatyuruiSection:
            cell.textLabel!.text = "\(hatyurui[(indexPath as NSIndexPath).row])"
            
        case ryoseiruiSection:
            cell.textLabel!.text = "\(ryoseirui[(indexPath as NSIndexPath).row])"
            
        case gyoruiSection:
            cell.textLabel!.text = "\(gyorui[(indexPath as NSIndexPath).row])"
            
        default:
            break
        }
        return cell
    }
    
    

    //選択されたcellを判断する処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //選択されたセル番号をセクションごとに判定
        //哺乳類セクション
        
        //軽量化コード
        //func()を使って処理をひとまとめにするといいかも？
        switch ((indexPath as NSIndexPath).section){
        case honyuruiSection:
            for i in 0 ..< appDelegate.data.count{
                //選択されたセル番号の動物名と、AppDelegateで定義した動物リストと比較
                if(appDelegate.data[i][appDelegate.name] == honyurui[(indexPath as NSIndexPath).row]){
                    //比較した動物名が同じで、その動物のカードを獲得していたら画面遷移
                    if(appDelegate.cardFlg[i] == "get"){
                        screenTransitionCardlist(i)
                        break
                    }
                }
            }
            
        case tyoruiSection:
            for i in defaultNum ..< appDelegate.data.count{
                if(appDelegate.data[i][appDelegate.name] == tyorui[(indexPath as NSIndexPath).row]){
                    if(appDelegate.cardFlg[i] == "get"){
                        screenTransitionCardlist(i)
                        break
                    }
                }
            }
            
        case hatyuruiSection:
            for i in defaultNum ..< appDelegate.data.count{
                if(appDelegate.data[i][appDelegate.name] == hatyurui[(indexPath as NSIndexPath).row]){
                    if(appDelegate.cardFlg[i] == "get"){
                        screenTransitionCardlist(i)
                        break
                    }
                }
            }
        
        case ryoseiruiSection:
            for i in defaultNum ..< appDelegate.data.count{
                if(appDelegate.data[i][appDelegate.name] == ryoseirui[(indexPath as NSIndexPath).row]){
                    if(appDelegate.cardFlg[i] == "get"){
                        screenTransitionCardlist(i)
                        break
                    }
                }
            }
            
        case gyoruiSection:
            for i in defaultNum ..< appDelegate.data.count{
                if(appDelegate.data[i][appDelegate.name] == gyorui[(indexPath as NSIndexPath).row]){
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

    
    func screenTransitionCardlist(_ routeNumber:Int){
        //移動先でカードを表示するためにappDelegate.decideRouteに代入
        //appDelegate.listFlgをtrueにすることで、カード表示画面のボタン処理を変更
        appDelegate.route = routeNumber
        appDelegate.listFlg = true
        let cardViewController = self.storyboard!.instantiateViewController(withIdentifier: "card")
        self.present(cardViewController, animated: true, completion: nil)
    }

}
