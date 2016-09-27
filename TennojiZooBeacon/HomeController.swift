//
//  ViewController.swift
//  TennojiZooBeacon
//
//  Created by 仲西 渉 on 2015/12/26.
//  Copyright © 2015年 nwatabou. All rights reserved.
//

import UIKit
import CoreLocation

class HomeController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!

    //図鑑表示
    @IBAction func dictionary(_ sender: AnyObject) {
        let url:URL = URL(string: "http://www.hz.kutc.kansai-u.ac.jp/city.osaka/tennoji_app/animal_list.html")!
        if UIApplication.shared.canOpenURL(url){
            UIApplication.shared.openURL(url)
        }
    }
    
    //beaconの値取得関係の変数
    var trackLocationManager : CLLocationManager!
    var beaconRegion : CLBeaconRegion!
    
    let appDelegate:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    //初期化用の変数
    let defaultNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //起動したらHome画面で位置情報の許可を得る
        // ロケーションマネージャを作成する
        self.trackLocationManager = CLLocationManager()
        
        // デリゲートを自身に設定
        self.trackLocationManager.delegate = self
        
        // セキュリティ認証のステータスを取得
        let status = CLLocationManager.authorizationStatus()
        
        // まだ認証が得られていない場合は、認証ダイアログを表示
        if(status == CLAuthorizationStatus.notDetermined) {
            self.trackLocationManager.requestAlwaysAuthorization();
        }
        
        let img = UIImage(named: "start.png")
        imageView!.image = img
        
        //Home画面に来たら初期化する
        appDelegate.listFlg = false
        
        appDelegate.route = defaultNumber
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

