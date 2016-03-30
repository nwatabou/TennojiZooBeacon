//
//  CorrectViewController.swift
//  TennojiZooBeacon
//
//  Created by 仲西 渉 on 2015/12/28.
//  Copyright © 2015年 nwatabou. All rights reserved.
//

import Foundation
import UIKit

class CorrectViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImage(named: "true.png")
        imageView.image = img
    }
    
    override func viewDidAppear(animated: Bool) {
        
        //画面表示から2秒後に func transition()を呼び、画面推移
        NSTimer.scheduledTimerWithTimeInterval(3.0,target:self,selector:Selector("transition"), userInfo: nil, repeats: false)
    }
    
    //2秒たったら呼ばれる
    func transition(){
        let comentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("coment")
        self.presentViewController(comentViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}