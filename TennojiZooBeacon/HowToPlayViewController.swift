//
//  HowToPlayViewController.swift
//  TennojiZooBeacon
//
//  Created by 仲西 渉 on 2016/02/19.
//  Copyright © 2016年 nwatabou. All rights reserved.
//

import Foundation
import UIKit

class HowToPlayViewController: UIViewController{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scroll: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(1)
        
        let img = UIImage(named: "HowToPlay.png")
        
        print(2)
        self.imageView = UIImageView(image: img)
        
        print(3)
        self.imageView?.contentMode = UIViewContentMode.TopLeft
        
        print(4)
        self.scroll.addSubview(imageView)
        print(5)
    }
    
    override func viewDidAppear(animated: Bool) {
        scroll.flashScrollIndicators()
    }
    
    override func viewDidLayoutSubviews() {
        self.scroll.contentSize = self.imageView.frame.size
        
        self.scroll.contentOffset = CGPointMake(0, self.scroll.frame.height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}