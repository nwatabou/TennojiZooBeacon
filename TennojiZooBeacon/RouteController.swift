//
//  QuizViewController.swift
//  TennojiZooBeacon
//
//  Created by 仲西 渉 on 2015/12/26.
//  Copyright © 2015年 nwatabou. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class RouteViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var routeButton1: UIButton!
    @IBOutlet weak var routeButton2: UIButton!
    @IBOutlet weak var routeButton3: UIButton!
    
    @IBAction func routeButton1(sender: AnyObject) {
        let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        appDelegate.route = beaconNo+1
    }
    @IBAction func routeButton2(sender: AnyObject) {
        let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        appDelegate.route = beaconNo+2
    }
    @IBAction func routeButton3(sender: AnyObject) {
        let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        appDelegate.route = beaconNo+3
    }

    var route1:String = "???"
    var route2:String = "???"
    var route3:String = "???"
    
    var beaconNo = 0
    
    //beaconの値取得関係の変数
    var trackLocationManager : CLLocationManager!
    var beaconRegion : CLBeaconRegion!
    
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
            
        default:
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
        
        beaconNo = (beacon.minor).integerValue
        
        let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        route1 = appDelegate.message[beaconNo+1]
        routeButton1.setTitle(route1, forState: .Normal)

        route2 = appDelegate.message[beaconNo+2]
        routeButton2.setTitle(route2, forState: .Normal)
        
        route3 = appDelegate.message[beaconNo+3]
        routeButton3.setTitle(route3, forState: .Normal)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}