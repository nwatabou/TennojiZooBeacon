//
//  AppDelegate.swift
//  TennojiZooBeacon
//
//  Created by 仲西 渉 on 2015/12/26.
//  Copyright © 2015年 nwatabou. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var beaconNo = 0
    
    //RouteViewControllerで選択したルート格納用変数
    var route = 0
    
    //最終的に決定したbeacon.minorをwalkViewControllerで格納
    var decideRoute = 0
    
    //カードを獲得して表示されたのか、カードリストから表示されたのかを判別するFlg
    var listFlg = false

    //ここに動物の情報を格納
    //配列番号が同じものは、同じくくりで登録
    
    //let animals = ["gate1","ヴイクトリアコアラ","フサオネズミカンガルー","ホオアカトキ","シシオザル","タイゾウ","メガネグマ","ホッキョクグマ","シロフクロウ","コンサンケイ","カリフォルニアアシカ","チンパンジー","gate2","ヨウスコウワニ","コイ","シリケンイモリ","チリーフラミンゴ","ソデグロツル","ヒガシクロサイ","コビトマングース","アミメキリン","ライオン","セーカーハヤブサ","ツシマヤマネコ","ムフロン","アムールトラ","チュウゴクオオカミ","シセンレッサーパンダ","ニホンコウノトリ","フンボルトペンギン","ヒツジ","フタコブラクダ","
    let animals = ["error","","","","ライオン","タイゾウ","アミメキリン","アムールトラ","ヒガシクロサイ","ホッキョクグマ"]
    
//    let message = ["てんしば入口","森にたたずむおっとりや","ネズミだけどネズミじゃない！？","見た目は魔女","その先に王のたてがみ","鼻の長〜い動物","大きいメガネ","白き巨体","寒くてもへっちゃら","真っ赤なお顔","海のライオン","人間そっくり！？","通天閣入口","笑顔が得意技","ダンディーなヒゲ","可愛い顔して毒がある","美しい足","実は真っ白じゃない？",""クロ"だけど"黒"じゃない","小さくたって肉食系","首を長〜くして待ってます","たたずむは獣の王者","りりしい顔立ち","猫？いや、山猫です！","もふもふでゴツゴツ！？","大阪のおばちゃんも愛用？","日本ではここしか居ない！？","たぬき？くま？","大人になると鳴かなくなる鳥！？","意外とあたたかいところが好き","ふわふわお布団","砂漠の船"]
    let message = ["none","","","","百獣の王","鼻の長い動物","陸上で最も背の高い動物","大阪のおばちゃん愛用","鎧のような体","白き巨体"]
    
    let quiz = ["none","","","","狩りをするのは？","天王寺動物園で飼われているゾウの名前は？","キリンはどうやって寝るでしょう？","トラの肌は何色でしょう？","",""]
    
    //問題の答えは、配列番号を3で割った余りのanswer番号
    let answer1 = ["none","","","","オスの仕事","サニー花子","たったまま寝る","肌色","",]//余り0
    let answer2 = ["none","","","","メスの仕事","エレファント陽子","横になって寝る","黒色","",]//余り1
    let answer3 = ["none","","","","交代で行う","ラニー博子","そもそも寝ない","そりゃトラ模様でしょ","",]//余り2
    
    //それぞれの動物のカード画像名を格納しておく変数
    let image = ["none","","","","lion.png","elephant.png","giraffe.png","",""]
    
    var cardFlg = ["none","false","false","false","false","false","false","false","false","false","false"]

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
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

