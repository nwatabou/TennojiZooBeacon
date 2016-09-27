//
//  ComentViewController.swift
//  TennojiZooBeacon
//
//  Created by 仲西 渉 on 2016/03/09.
//  Copyright © 2016年 nwatabou. All rights reserved.
//

import Foundation
import UIKit

class ComentViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var dictionaryButton: UIButton!
    @IBAction func dictionaryButton(_ sender: AnyObject) {
        let URLString = base + add
        let url:URL = URL(string: URLString)!
        if UIApplication.shared.canOpenURL(url){
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func nextButton(_ sender: AnyObject) {
        if(appDelegate.quizFlg){
            let cardViewController = self.storyboard!.instantiateViewController(withIdentifier: "card")
            self.present(cardViewController, animated: true, completion: nil)
            
        }else{
            appDelegate.route = defaultNum
            
            let routeViewController = self.storyboard!.instantiateViewController(withIdentifier: "route")
            self.present(routeViewController, animated: true, completion: nil)
        }
    }
    
    let appDelegate:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    let defaultNum = 0
    
    let base:String = "http://www.hz.kutc.kansai-u.ac.jp/city.osaka/tennoji_app/animal_reference.html?animal_id=z"
    var add:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        add = appDelegate.data[appDelegate.route][appDelegate.dictionaryID]
        
        let animalImg = appDelegate.data[appDelegate.route][appDelegate.image]
        let head = "#"
        
        let comentImg = head + animalImg
        
        let img = UIImage(named: comentImg)
        imageView.image = img
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
