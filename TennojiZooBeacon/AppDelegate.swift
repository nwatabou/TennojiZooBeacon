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

    //ここに動物の情報を格納
    //配列番号が同じものは、同じくくりで登録
    let animals = ["error","","","","ライオン","タイゾウ","アミメキリン","アムールトラ","ヒガシクロサイ","ホッキョクグマ"]
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

