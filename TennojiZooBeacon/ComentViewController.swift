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
    @IBAction func dictionaryButton(sender: AnyObject) {
        let URLString = base + add
        let url:NSURL = NSURL(string: URLString)!
        if UIApplication.sharedApplication().canOpenURL(url){
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func nextButton(sender: AnyObject) {
        if(appDelegate.quizFlg){
            let cardViewController = self.storyboard!.instantiateViewControllerWithIdentifier("card")
            self.presentViewController(cardViewController, animated: true, completion: nil)
            
        }else{
            appDelegate.route = defaultNum
            
            let routeViewController = self.storyboard!.instantiateViewControllerWithIdentifier("route")
            self.presentViewController(routeViewController, animated: true, completion: nil)
        }
    }
    
    let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
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