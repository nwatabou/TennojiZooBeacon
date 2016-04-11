//
//  RouteViewController.swift
//  TennojiZooBeacon
//
//  Created by 仲西 渉 on 2015/12/28.
//  Copyright © 2015年 nwatabou. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class RouteViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var routeButton1: UIButton!
    @IBOutlet weak var routeButton2: UIButton!
    @IBOutlet weak var routeButton3: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    //押されたボタンによって選択されたルートを変化させて画面移動
    @IBAction func routeButton1(sender: AnyObject) {
        if(flg){
            appDelegate.route = beaconNo+add1
            //ルート選択時の現在地Beacon番号を格納
            appDelegate.nowBeaconNo = beaconNo
            let walkViewController = self.storyboard!.instantiateViewControllerWithIdentifier("walk")
            self.presentViewController(walkViewController, animated: true, completion: nil)
        }
    }
    @IBAction func routeButton2(sender: AnyObject) {
        if(flg){
            appDelegate.route = beaconNo+add2
            appDelegate.nowBeaconNo = beaconNo
        
            let walkViewController = self.storyboard!.instantiateViewControllerWithIdentifier("walk")
            self.presentViewController(walkViewController, animated: true, completion: nil)
        }
    }
    @IBAction func routeButton3(sender: AnyObject) {
        if(flg){
            appDelegate.route = beaconNo+add3
            appDelegate.nowBeaconNo = beaconNo
        
            let walkViewController = self.storyboard!.instantiateViewControllerWithIdentifier("walk")
            self.presentViewController(walkViewController, animated: true, completion: nil)
        }
    }
    
    var route1:String = "?　?　?"
    var route2:String = "?　?　?"
    var route3:String = "?　?　?"
    
    //beacon番号格納用変数
    var beaconNo = 0
    
    //初期化用の変数
    var defaultNumber = 0
    
    //beaconの近くにいるかどうかの判定のためのフラグ
    var flg = false
    
    let add1 = 1
    let add2 = 2
    let add3 = 3
    
    //beacon番号の最初と最後を定義
    let top = 0
    let last = 31
    
    //beaconの値取得関係の変数
    var trackLocationManager : CLLocationManager!
    var beaconRegion : CLBeaconRegion!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    //最初に宣言しておく
    let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        routeButton1.setTitle(route1, forState: .Normal)
        routeButton2.setTitle(route2, forState: .Normal)
        routeButton3.setTitle(route3, forState: .Normal)
        
        // ロケーションマネージャを作成する
        self.trackLocationManager = CLLocationManager();
        
        // デリゲートを自身に設定
        self.trackLocationManager.delegate = self;
        
        // BeaconのUUIDを設定
        let uuid:NSUUID? = NSUUID(UUIDString: "00000000-7DE6-1001-B000-001C4DF13E76")
        
        //Beacon領域を作成
        self.beaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: "net.noumenon-th")
        
        appDelegate.decideRoute = defaultNumber
        appDelegate.route = defaultNumber
        
        let img = UIImage(named: "select.png")
        imageView.image = img
    }
    
    
    //ここから下はbeacon観測処理
    
    
    //位置認証のステータスが変更された時に呼ばれる
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        // 認証のステータス
        let statusStr = "";
        print("CLAuthorizationStatus: \(statusStr)")
        
        
        print(" CLAuthorizationStatus: \(statusStr)")
        
        //観測を開始させる
        trackLocationManager.startMonitoringForRegion(self.beaconRegion)
        
    }
    
    
    
    
    //観測の開始に成功すると呼ばれる
    func locationManager(manager: CLLocationManager, didStartMonitoringForRegion region: CLRegion) {
        
        print("didStartMonitoringForRegion");
        
        //観測開始に成功したら、領域内にいるかどうかの判定をおこなう。→（didDetermineState）へ
        trackLocationManager.requestStateForRegion(self.beaconRegion);
    }
    
    
    
    
    //領域内にいるかどうかを判定する
    func locationManager(manager: CLLocationManager, didDetermineState state: CLRegionState, forRegion inRegion: CLRegion) {
        
        switch (state) {
            
        case .Inside: // すでに領域内にいる場合は（didEnterRegion）は呼ばれない
            
            trackLocationManager.startRangingBeaconsInRegion(beaconRegion);
            // →(didRangeBeacons)で測定をはじめる
            break;
            
        case .Outside:
            
            // 領域外→領域に入った場合はdidEnterRegionが呼ばれる
            break;
            
        case .Unknown:

            // 不明→領域に入った場合はdidEnterRegionが呼ばれる
            break;
        }
    }
    
    
    
    
    //領域に入った時
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        // →(didRangeBeacons)で測定をはじめる
        self.trackLocationManager.startRangingBeaconsInRegion(self.beaconRegion)
    }
    
    
    
    
    //領域から出た時
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        //測定を停止する
        self.trackLocationManager.stopRangingBeaconsInRegion(self.beaconRegion)
        flg = false
    }
    
    
    //領域内にいるので測定をする
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion){
        let beacon = beacons[0]

        //beacon.minorをint型に変換
        beaconNo = (beacon.minor).integerValue

        flg = true
        
        /*
        for文でappDelegate.cardFlgを回す
        獲得してなかったらルート表示　+　j++
        j=3になったら終了
        みたいな処理でルート表示
        */
        

        //以下、カードを取得したルートを表示しない処理
        
        var i = 0
        var j = 0
        let routeDefault = beaconNo + add1
        for(i = routeDefault;i < appDelegate.animals.count;i += 1){
            if((defaults.objectForKey("cardGet")) != nil){
                appDelegate.cardFlg = (NSUserDefaults.standardUserDefaults().arrayForKey("cardGet") as? [String])!
            }
            //今のbeaconNo + 1からカードを獲得していない近い動物を表示
            if(appDelegate.cardFlg[i] != "get"){
                j += 1
                if(j > 3){
                    break
                }else{
                    switch (j){
                    case 1:
                        route1 = appDelegate.message[i]
                        routeButton1.setTitle(route1, forState: .Normal)
                        break
                        
                    case 2:
                        route2 = appDelegate.message[i]
                        routeButton2.setTitle(route2, forState: .Normal)
                        break
                    
                    case 3:
                        route3 = appDelegate.message[i]
                        routeButton3.setTitle(route3, forState: .Normal)
                        break
                    
                    default:
                        break
                    }
                }
            }
        }

        
        /*
        route1 = appDelegate.message[beaconNo+add1]
        routeButton1.setTitle(route1, forState: .Normal)
        
        route2 = appDelegate.message[beaconNo+add2]
        routeButton2.setTitle(route2, forState: .Normal)
        
        route3 = appDelegate.message[beaconNo+add3]
        routeButton3.setTitle(route3, forState: .Normal)
*/
        }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}