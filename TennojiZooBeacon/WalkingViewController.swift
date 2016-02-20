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
    
    //デバッグ確認用ラベル
    @IBOutlet weak var beaconNoLabel: UILabel!
    @IBOutlet weak var animalNameLabel: UILabel!
    

    @IBAction func nextButton(sender: AnyObject) {
        //画面移動する前に値を渡しておく
        appDelegate.decideRoute = beaconNo
        
        let quizViewController = self.storyboard!.instantiateViewControllerWithIdentifier("quiz")
        self.presentViewController(quizViewController, animated: true, completion: nil)
    }
    
    //beaconの値取得関係の変数
    var trackLocationManager : CLLocationManager!
    var beaconRegion : CLBeaconRegion!
    
    
    var beaconNo = 0
    
    //最初に宣言しておく
    let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nextButton.hidden = true
        self.checkLable.hidden = true
        
        
        // ロケーションマネージャを作成する
        self.trackLocationManager = CLLocationManager();
        
        // デリゲートを自身に設定
        self.trackLocationManager.delegate = self;
        
        // BeaconのUUIDを設定
        let uuid:NSUUID? = NSUUID(UUIDString: "00000000-7DE6-1001-B000-001C4DF13E76")
        
        //Beacon領域を作成
        self.beaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: "net.noumenon-th")
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
        //開発用

        //開発用にimmediateのみ観測の条件式追加
        //if(beacon.proximity == CLProximity.Immediate){
        //beacon.minorをint型に変換してappDelegate.decideRouteに格納
        beaconNo = (beacon.minor).integerValue
        
        //前の画面(RouteViewController)で選択した番号(appDelegate.route)と、今観測できるbeacon.minorが一緒なら画面移動
        //違うなら確認ボタンを設置
            /*
        if(appDelegate.route == beacon.minor && beacon.proximity == CLProximity.Immediate){
            appDelegate.decideRoute = beaconNo
            
            let quizViewController = self.storyboard!.instantiateViewControllerWithIdentifier("quiz")
            self.presentViewController(quizViewController, animated: true, completion: nil)

        //すぐにボタンが出ないように、appDelegate.beaconNoとbeacon.minorが同じではない時に表示
        }else if(appDelegate.beaconNo != beacon.minor && beacon.proximity == CLProximity.Immediate){
            self.checkLable.hidden = false
            self.nextButton.hidden = false
        }else{
            self.checkLable.hidden = true
            self.nextButton.hidden = true
            }
*/
            
            
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

//    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}