//
//  HowToPlayViewController.swift
//  TennojiZooBeacon
//
//  Created by 仲西 渉 on 2016/02/24.
//  Copyright © 2016年 nwatabou. All rights reserved.
//

import Foundation
import UIKit

class HowToPlayViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImage(named: "HowToPlay.png")
        imageView.image = img
        
        scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        
        imageView.frame = CGRectMake(0, 0, img!.size.width, img!.size.height)
        
        scrollView.addSubview(imageView)
        
        scrollView.contentSize = CGSizeMake((img?.size.width)!, (img?.size.height)!)
        
        self.view.addSubview(scrollView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}