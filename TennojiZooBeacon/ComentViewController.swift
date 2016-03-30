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
        
    }
    
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func nextButton(sender: AnyObject) {
        if(appDelegate.quizFlg){
            let cardViewController = self.storyboard!.instantiateViewControllerWithIdentifier("card")
            self.presentViewController(cardViewController, animated: true, completion: nil)
        }else{
            appDelegate.decideRoute = defaultNum
            appDelegate.route = defaultNum
            
            let routeViewController = self.storyboard!.instantiateViewControllerWithIdentifier("route")
            self.presentViewController(routeViewController, animated: true, completion: nil)
        }
    }
    //最初に宣言しておく
    let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    let defaultNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animalImg = appDelegate.image[appDelegate.decideRoute]
        let head = "#"
        
        let comentImg = head + animalImg
        
        let img = UIImage(named: comentImg)
        imageView.image = img
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}