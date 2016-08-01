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
    
    //beacon番号格納用変数
    var beaconNo:Int = 0
    
    //初期化用の変数
    let defaultNumber:Int = 0
    
    let routeNumber:Int = 3
    
    //beaconの近くにいるかどうかの判定のためのフラグ
    var flg = false
    
    let add1:Int = 1
    let add2:Int = 2
    let add3:Int = 3
    
    //beacon番号の最初と最後を定義
    let top:Int = 0
    let last:Int = 31
    
    //beaconの値取得関係の変数
    var trackLocationManager : CLLocationManager!
    var beaconRegion : CLBeaconRegion!
    
    var route = (NSUserDefaults.standardUserDefaults().integerForKey("route"))
    
    
    
    
    let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        routeButton1.hidden = true
        routeButton2.hidden = true
        routeButton3.hidden = true
        
        // ロケーションマネージャを作成する
        self.trackLocationManager = CLLocationManager();
        
        // デリゲートを自身に設定
        self.trackLocationManager.delegate = self;
        
        // BeaconのUUIDを設定
        let uuid:NSUUID? = NSUUID(UUIDString: "00000000-7DE6-1001-B000-001C4DF13E76")
        
        //Beacon領域を作成
        self.beaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: "net.noumenon-th")
        
        appDelegate.route = defaultNumber
        
        let img = UIImage(named: "select.png")
        imageView.image = img
        
        //以前にアプリ終了等で異常終了した際に，記録されたビーコン番号を確認
        if(route != 0){
            beaconNo = NSUserDefaults.standardUserDefaults().integerForKey("route")
        }
        
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
        

        //以下、カードを取得したルートを表示しない処理
        let routeDefault = beaconNo + add1
        
        NSUserDefaults.standardUserDefaults().setInteger(beaconNo, forKey: "route")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        var j = 0
        
        for_i:for i in routeDefault ..< appDelegate.data.count {
            if(appDelegate.cardFlg[i] != "get"){
                j += 1
                
                switch j {
                case 1:
                    routeButton1.hidden = false
                    routeButton1.setTitle(appDelegate.data[i][3], forState: .Normal)
                    
                case 2:
                    routeButton2.hidden = false
                    routeButton2.setTitle(appDelegate.data[i][3], forState: .Normal)
                    
                    
                case 3:
                    routeButton3.hidden = false
                    routeButton3.setTitle(appDelegate.data[i][3], forState: .Normal)
                    
                default:
                    break for_i
                    
                }
            }
        }
    }
    
    
    //segueで値渡し
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "select1"){
            let walkingViewController = segue.destinationViewController as! WalkingViewController
            walkingViewController.firstBeacon = beaconNo
            walkingViewController.selectRoute = beaconNo + add1
            
        }else if(segue.identifier == "select2"){
            let walkingViewController = segue.destinationViewController as! WalkingViewController
            walkingViewController.firstBeacon = beaconNo
            walkingViewController.selectRoute = beaconNo + add2
            
        }else if(segue.identifier == "select3"){
            let walkingViewController = segue.destinationViewController as! WalkingViewController
            walkingViewController.firstBeacon = beaconNo
            walkingViewController.selectRoute = beaconNo + add3
        }
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}