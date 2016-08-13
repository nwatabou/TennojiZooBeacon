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
    @IBOutlet weak var animalLabel: UILabel!
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
        appDelegate.route = beaconNo
            
            if(appDelegate.route == 23){
                let middleViewController = self.storyboard!.instantiateViewControllerWithIdentifier("middle")
                self.presentViewController(middleViewController, animated: true, completion: nil)
                
            }else if(appDelegate.route == 32 || appDelegate.route == 0){
                let finishViewController = self.storyboard!.instantiateViewControllerWithIdentifier("finish")
                self.presentViewController(finishViewController, animated: true, completion: nil)
                
            }else{
                let quizViewController = self.storyboard!.instantiateViewControllerWithIdentifier("quiz")
                self.presentViewController(quizViewController, animated: true, completion: nil)
            }
        }else{
            //falseの時は近くにBeaconがなくてルート表示したい時
            let URL = baseURL + addURL
            let url:NSURL = NSURL(string:URL)!
            if UIApplication.sharedApplication().canOpenURL(url){
                UIApplication.sharedApplication().openURL(url)
            }
        }
    }
    
    //beaconの値取得関係の変数
    var trackLocationManager : CLLocationManager!
    var beaconRegion : CLBeaconRegion!
    
    
    var beaconNo:Int = 0
    
    var firstBeacon:Int!
    var selectRoute:Int!
    
    //道案内するか、クイズ画面に移動するのかの判定フラグ
    //falseなら案内、trueならクイズ画面へ
    var flg:Bool = false
    

    let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    var baseURL = "http://158.217.45.5/zoo/map3d_gps16_ogi.html?id="
    var addURL = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // ロケーションマネージャを作成する
        self.trackLocationManager = CLLocationManager()
        
        // デリゲートを自身に設定
        self.trackLocationManager.delegate = self
        
        // BeaconのUUIDを設定
        let uuid:NSUUID? = NSUUID(UUIDString: "00000000-7DE6-1001-B000-001C4DF13E76")
        
        //Beacon領域を作成
        self.beaconRegion = CLBeaconRegion(proximityUUID: uuid!, identifier: "net.noumenon-th")
        
        let img = UIImage(named: "walking.png")
        imageView!.image = img
        
        addURL = appDelegate.data[selectRoute!][appDelegate.routeID]

        
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
        
        print("didStartMonitoringForRegion")
        
        //観測開始に成功したら、領域内にいるかどうかの判定をおこなう。→（didDetermineState）へ
        trackLocationManager.requestStateForRegion(self.beaconRegion)
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
        
        if(beacons.count > 0){
            let beacon = beacons[0]
        
            //beacon.minorをint型に変換(appDelegate.decideRouteに渡す為に必要)
            beaconNo = (beacon.minor).integerValue
        
            self.animalLabel.text = ("ここは " + appDelegate.data[beaconNo][appDelegate.name] + " の近くだよ")
            if(beaconNo == selectRoute){
                appDelegate.route = beaconNo
            
                if(appDelegate.route == 23){
                    let middleViewController = self.storyboard!.instantiateViewControllerWithIdentifier("middle")
                    self.presentViewController(middleViewController, animated: true, completion: nil)
                
                }else if(appDelegate.route == 32 || appDelegate.route == 0){
                    let finishViewController = self.storyboard!.instantiateViewControllerWithIdentifier("finish")
                    self.presentViewController(finishViewController, animated: true, completion: nil)
                
                }else{
                    let quizViewController = self.storyboard!.instantiateViewControllerWithIdentifier("quiz")
                    self.presentViewController(quizViewController, animated: true, completion: nil)
                }
        
            }else if(beacon.minor != firstBeacon){
                self.checkLable.text = "この場所で良いかな?"
                flg = true
            }else if(beacon.minor == firstBeacon){
                self.checkLable.text = "選んだ場所までのルートを表示しますか?"
                flg = false
                addURL = appDelegate.data[selectRoute!][appDelegate.routeID]
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}