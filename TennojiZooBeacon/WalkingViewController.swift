//
//  WalkingViewController.swift
//  TennojiZooBeacon
//
//  Created by 仲西 渉 on 2015/12/31.
//  Copyright © 2015年 nwatabou. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class WalkingViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var checkLable: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!

    @IBAction func routeSearchButton(sender: AnyObject) {
        let URL = baseURL + addURL
        let url:NSURL = NSURL(string:URL)!
        if UIApplication.sharedApplication().canOpenURL(url){
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func nextButton(sender: AnyObject) {
        //flg = trueの時は、近くにBeaconがある時
        if(flg){
        //画面移動する前に値を渡しておく
        appDelegate.decideRoute = beaconNo
        
        let quizViewController = self.storyboard!.instantiateViewControllerWithIdentifier("quiz")
        self.presentViewController(quizViewController, animated: true, completion: nil)
        }else{
            /*
            //falseの時は近くにBeaconがなくてルート表示したい時
            let URL = baseURL + addURL
            let url:NSURL = NSURL(string:URL)!
            if UIApplication.sharedApplication().canOpenURL(url){
                UIApplication.sharedApplication().openURL(url)
            }
            */
        }
    }
    
    //beaconの値取得関係の変数
    var trackLocationManager : CLLocationManager!
    var beaconRegion : CLBeaconRegion!
    
    
    var beaconNo = 0
    
    //道案内するか、クイズ画面に移動するのかの判定フラグ
    //falseなら案内、trueならクイズ画面へ
    var flg = false
    
    //最初に宣言しておく
    let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    var baseURL = "http://158.217.45.5/zoo/map3d_gps15.html?id="
    var addURL = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // ロケーションマネージャを作成する
        self.trackLocationManager = CLLocationManager();
        
        // デリゲートを自身に設定
        self.trackLocationManager.delegate = self;
        
        // BeaconのUUIDを設定
        let uuid:NSUUID? = NSUUID(UUIDString: "00000000-7DE6-1001-B000-001C4DF13E76")
        
        //Beacon領域を作成
        self.beaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: "net.noumenon-th")
        
        let img = UIImage(named: "walking.png")
        imageView!.image = img
        
        addURL = appDelegate.animalURL[appDelegate.route]
        
    }
    
    
    
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
    }
    
    
    
    
    //領域内にいるので測定をする
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion){
        let beacon = beacons[0]
        
        //beacon.minorをint型に変換
        beaconNo = (beacon.minor).integerValue
        
        flg = true

        /*
        //近くに他のBeaconがあるなら確認ボタン。そうでないならルート表示ボタンにする
        if(beacon.proximity != CLProximity.Unknown && beacon.minor != beaconNo){
            self.checkLable.text = "この動物でいいかな？"
            flg = true
        }else{
            self.checkLable.text = "選んだ動物までのルートを表示しますか？"
            flg = false
        }
    */

            
/*
            //実地試験用
            //常にこの場所でいいかの確認+Beacon番号、動物名の確認
            beaconNo = (beacon.minor).integerValue
            self.beaconNoLabel.text = "\(beacon.minor)"
            self.animalNameLabel.text = appDelegate.animals[beaconNo]
            
            if(appDelegate.beaconNo != beacon.minor){
                self.checkLable.hidden = false
                self.nextButton.hidden = false
            }else{
                self.checkLable.hidden = true
                self.nextButton.hidden = true
            }

        }
*/

    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}