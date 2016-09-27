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
    //var decideRoute = 0
    
    //カードを獲得して表示されたのか、カードリストから表示されたのかを判別するFlg
    var listFlg = false
    
    var locationManager: CLLocationManager!
    
    var quizFlg = true
    
    //csvファイルのデータを格納する変数
    var data: [[String]] = []
    
    //多次元配列の格納番号
    let number = 0
    let name = 1
    let dictionaryID = 2
    let message = 3
    let question = 4
    let select1 = 5
    let select2 = 6
    let select3 = 7
    let image = 8
    let routeID = 9
    
    //Number,Name,DictionaryID,Message,Question,Select1,Select2,Select3,Image,CardFlg
  
    
    var cardFlg = ["none","false","false","false","false","false","false","false","false","false","false","false","false","false","false","false","false","false","false","false","false","false","false","gate","false","false","false","false","false","false","false","false","last"]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //以下csvファイル参照処理
        
        //読み込むファイル指定
        if let csvPath = Bundle.main.path(forResource: "TennojiDataFile", ofType: "csv") {
            var csvString=""
            do{
                csvString = try NSString(contentsOfFile: csvPath, encoding: String.Encoding.utf8.rawValue) as String
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            csvString.enumerateLines {
                (line, stop) -> () in
                self.data.append(line.components(separatedBy: ","))
            }
        }
        
        
        //以下通知処理
        
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
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            let uuid: UUID! = UUID(uuidString:"00000000-7DE6-1001-B000-001C4DF13E76")
            
            let message = "Beaconが近くにあります"
            
            // ビーコン領域をトリガーとした通知を作成(後述)
            let notification = createRegionNotification(uuid, message: message)
            // 通知を登録する
            UIApplication.shared.scheduleLocalNotification(notification)
        }
    }
    
    fileprivate func createRegionNotification(_ uuid: UUID, message: String) -> UILocalNotification {
        
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
    fileprivate func createInteractiveNotificationSettings() -> UIUserNotificationSettings {
        // アクションを登録したカテゴリで通知設定を生成する
        let notificationSettings =  UIUserNotificationSettings(types: [.alert, .badge, .sound,], categories: nil)
        
        // この通知設定を登録する
        return notificationSettings
    }
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

