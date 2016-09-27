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
    
    @IBAction func backButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImage(named: "HowToPlay.png")
        imageView.image = img
        
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        imageView.frame = CGRect(x: 0, y: 0, width: img!.size.width, height: img!.size.height)
        
        scrollView.addSubview(imageView)
        
        scrollView.contentSize = CGSize(width: (img?.size.width)!, height: (img?.size.height)!)
        
        self.view.addSubview(scrollView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
