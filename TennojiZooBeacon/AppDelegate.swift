//
//  AppDelegate.swift
//  TennojiZooBeacon
//
//  Created by 仲西 渉 on 2015/12/26.
//  Copyright © 2015年 nwatabou. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    
    var nowBeaconNo = 0
    
    //RouteViewControllerで選択したルート格納用変数
    var route = 0
    
    //最終的に決定したbeacon.minorをwalkViewControllerで格納
    var decideRoute = 0
    
    //カードを獲得して表示されたのか、カードリストから表示されたのかを判別するFlg
    var listFlg = false
    
    var locationManager: CLLocationManager!

    //ここに動物の情報を格納
    //配列番号が同じものは、同じくくりで登録
    
    let animals = ["gate1","ヴィクトリアコアラ","フサオネズミカンガルー","ホオアカトキ","シシオザル","タイゾウ","メガネグマ","ホッキョクグマ","シロフクロウ","コサンケイ","カリフォルニアアシカ","チンパンジー","gate2","ヨウスコウワニ","コイ","シリケンイモリ","チリーフラミンゴ","ソデグロヅル","ヒガシクロサイ","コビトマングース","アミメキリン","ライオン","セーカーハヤブサ","スナドリネコ","ムフロン","アムールトラ","チュウゴクオオカミ","シセンレッサーパンダ","ニホンコウノトリ","フンボルトペンギン","ヒツジ","フタコブラクダ"]
//    let animals = ["error","","","","ライオン","タイゾウ","アミメキリン","アムールトラ","ヒガシクロサイ","ホッキョクグマ"]
    
    let message = ["てんしば入口","森にたたずむおっとりや","ネズミだけどネズミじゃない！？","見た目は魔女","その先に王のたてがみ","鼻の長〜い動物","大きいメガネ","白き巨体","寒くてもへっちゃら","真っ赤なお顔","海のライオン","人間そっくり！？","通天閣入口","笑顔が得意技","ダンディーなヒゲ","可愛い顔して毒がある","美しい足","実は真っ白じゃない？","「クロ」だけど「黒」じゃない","小さくたって肉食系","首を長〜くして待ってます","たたずむは獣の王者","りりしい顔立ち","魚が好物","もふもふでゴツゴツ！？","大阪のおばちゃんも愛用？","日本ではここしか居ない！？","たぬき？くま？","大人になると鳴かなくなる鳥！？","意外とあたたかいところが好き","ふわふわお布団","砂漠の船"]
//    let message = ["none","","","","百獣の王","鼻の長い動物","陸上で最も背の高い動物","大阪のおばちゃん愛用","鎧のような体","白き巨体"]
    
    let quiz = ["gate1","エサとして食べないのは？","　要再考　","恋人がなくなるとどうする？","顔にたてがみがあるのはオス？メス？","寿命はどれぐらい？","上手な運動は？","実はある部分に毒を持っています。どこでしょう？","翼を広げると何cm？","オスの羽の色は？","指は何本でしょう？","チンパンジーの歩き方は？","gate2","主な食べ物は？","コイにないものは？","どこに毒があるでしょう？","エサの食べ方は？","黒い部分はどこでしょう？","ツノは何でできているかな？","コビトマングースの習性として正しいものは？","アミメキリンの子どもの大きさはどれぐらい？","群のことをなんというかな？","鼻の色は何色？","漢字ではどう書くかな？","ツノはオスとメスどっちの方が大きい？","別名は？","狼の中ではどれくらいの大きさかな？","お腹が黒い理由は？","くちばしを使って仲間に合図を送ることをなんという？","胸にある黒い帯は何本？","羊のツメは何個にわかれている？","コブはなにでできている？"]
//    let quiz = ["none","","","","狩りをするのは？","天王寺動物園で飼われているゾウの名前は？","キリンはどうやって寝るでしょう？","トラの肌は何色でしょう？","",""]
    
    
    let answer1 = ["gate1","クスノキ","　要再考　","悲しむ","オス","10〜20年","木登り","口の中","30cmぐらい","青色","6本","足で歩く","gate2","人間","うろこ","皮膚の表面","泥ごと口に含む","首","毛","100匹以上の群で行動する","1m〜1.2m","プライド","赤色","砂取り猫","オスの方が大きい","ベンガルトラ","大きい","敵に見つけられにくいように","クライミング","2本","2個","骨"]
    //問題の答えは、配列番号を3で割った余りのanswer番号
//    let answer1 = ["none","","","","オスの仕事","サニー花子","たったまま寝る","肌色","",]//余り0　黄
    
    let answer2 = ["gate1","ユーカリ","　要再考　","喜ぶ","オスとメス両方","40〜50年","ダンス","肝臓","100cmぐらい","茶色","5本","手のひらで歩く","gate2","貝類","歯","内蔵","木をつつく","くちばし","筋肉","卵を見つけると、岩にぶつけて割る","1.3m〜1.5m","パック","青色","巣な取り猫","メスの方が大きい","シベリアトラ","小さい","お腹を地面にすりながら歩くから","クラッタリング","3本","5個","脂肪"]
//    let answer2 = ["none","","","","メスの仕事","エレファント陽子","横になって寝る","黒色","",]//余り1　青
    
    let answer3 = ["gate1","タンポポ","　要再考　","怒る","メスだけ","70〜80年","ジャンプ","胃","140cmよりも長い","灰色","4本","手の甲をついて歩く","gate2","干し草","胃","舌","食べない","羽の先端","骨","ヘビを襲って食べてしまう","1.6m〜1.8mぐらい","タワー","黄色","漁り猫","オスもメスも同じくらい","スマトラトラ","中くらい","お腹を洗わないから","クローリング","いやいや、1本でしょ","3個","筋肉"]
//    let answer3 = ["none","","","","交代で行う","ラニー博子","そもそも寝ない","そりゃトラ模様でしょ","",]//余り2　赤
    
    //それぞれの動物のカード画像名を格納しておく変数
    let image = ["none","vikutoriakoara.png","husaonezumikangaru.png","hooakatoki.png","shishiozaru.png","taizou.png","meganeguma.png","hokkyokuguma.png","sirohukurou.png","kosankei.png","asika.png","tinpanji.png","gate2","yousukouwani.png","koi.png","sirikennimori.png","tirihuramingo.png","sodeguroduru.png","higasikurosai.png","kobito-mangusu.png","aminekirin.png","raion.png","se-ka-hayabusa.png","sunadorineko.png","muhuron.png","amurutora.png","tyugokuookami.png","ressa-panda.png","nihonkounotori.png","hunborutopengin.png","hituji.png","hutakoburakuda.png"]
    
    var cardFlg = ["none","false","false","false","false","false","false","false","false","false","false","false","gate2","false","false","false","false","false","false","false","false","false","false","false","false","false","false","false","false","false","false","false","false"]
    
    let url = ["gate1","2634","2636","2755","2642","2662","2650","2652","2782","2738","2661","2647","gate2","2790","2843","2830","2718","2745","2693","2654","2668","2660","2769","2655","2671","2657","2649","2685","2714","2709","2698","2666"]
    
    let routeURL = ["gate1","53"," フサオネズミカンガルー ","23","シシオザル","250","312","312","312","333","128","353","47","47","47","88","180","152","コビトマングース","16","140","3","1","128","6","16","20","23","29","202","194"]

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //　ボタン付きの通知の通知設定を作成する
        let settings = createInteractiveNotificationSettings()
        // アプリケーションに通知設定を登録
        application.registerUserNotificationSettings(settings)
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        // 位置情報使用許可を求める
        self.locationManager.requestAlwaysAuthorization()
        return true
    }
    
    
    // 位置情報使用許可の認証状態が変わったタイミングで呼ばれるデリゲートメソッド
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways {
            let uuid: NSUUID! = NSUUID(UUIDString:"00000000-7DE6-1001-B000-001C4DF13E76")
            
            let message = "Beaconが近くにあります"
            
            // ビーコン領域をトリガーとした通知を作成(後述)
            let notification = createRegionNotification(uuid, message: message)
            // 通知を登録する
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
    }
    
    private func createRegionNotification(uuid: NSUUID, message: String) -> UILocalNotification {
        
        // ## ビーコン領域を作成 ##
        let beaconRegion :CLBeaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: "RegionId")
        beaconRegion.notifyEntryStateOnDisplay = false
        beaconRegion.notifyOnEntry = true
        // 領域に入ったときにも出たときにも通知される
        // 今回は領域から出たときの通知はRegion側でOFFにしておく
        beaconRegion.notifyOnExit = false

        // ## 通知を作成し、領域を設定 ##
        let notification = UILocalNotification()
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.alertBody = message
        
        // 通知の対象となる領域 *今回のポイント
        notification.region = beaconRegion
        // 一度だけの通知かどうか
        notification.regionTriggersOnce = false
        
        return notification
    }
    
    
    // ボタン付きの通知設定を作成する
    private func createInteractiveNotificationSettings() -> UIUserNotificationSettings {
        // アクションを登録したカテゴリで通知設定を生成する
        let notificationSettings =  UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound,], categories: nil)
        
        // この通知設定を登録する
        return notificationSettings
    }
    
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

