//
//  FinishViewController.swift
//  TennojiZooBeacon
//
//  Created by 仲西 渉 on 2016/03/23.
//  Copyright © 2016年 nwatabou. All rights reserved.
//

import Foundation
import UIKit

class FinishViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBAction func homeButton(_ sender: AnyObject) {
        let homeViewController = self.storyboard!.instantiateViewController(withIdentifier: "home")
        self.present(homeViewController, animated: true, completion: nil)
    }
    
    let appDelegate:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    let defaultNumber = 0
    
    let defaults = UserDefaults.standard


    
    //日付を扱う変数
    let now = Date()
    
    override func viewDidLoad() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年　MM月　dd日"
        let string = formatter.string(from: now)
        self.dateLabel.text = string
        
        
        //獲得カード数確認処理
        if((defaults.object(forKey: "cardGet")) != nil){
            appDelegate.cardFlg = (UserDefaults.standard.array(forKey: "cardGet") as? [String])!
        }
        
        var count = defaultNumber
        
        for i in defaultNumber ..< appDelegate.data.count {
            if(appDelegate.cardFlg[i] == "get"){
                count += 1
            }
        }
        
        self.countLabel.text = "\(count)"
        
        var img:UIImage
        
        
        //以下，獲得カード数に応じてメッセージ分岐処理
        switch count {
        case 0...11:
            titleLabel.isHidden = true
            img = UIImage(named: "finish2.png")!
            imageView.image = img
            
        case 12...17:
            img = UIImage(named: "finish1.png")!
            imageView.image = img
            
            self.titleLabel.isHidden = false
            self.titleLabel.text = "動物博士の見習い"
            
        case 18...25:
            img = UIImage(named: "finish1.png")!
            imageView.image = img
            
            self.titleLabel.isHidden = false
            self.titleLabel.text = "動物博士"
            
        case 26...30:
            img = UIImage(named: "finish1.png")!
            imageView.image = img
            
            self.titleLabel.isHidden = false
            self.titleLabel.text = "動物王"
            
        default:
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
