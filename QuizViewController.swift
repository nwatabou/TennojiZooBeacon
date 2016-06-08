//
//  QuizViewController.swift
//  TennojiZooBeacon
//
//  Created by 仲西 渉 on 2015/12/28.
//  Copyright © 2015年 nwatabou. All rights reserved.
//

import Foundation
import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var animalLabel: UILabel!
    @IBOutlet weak var quizLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    
    @IBOutlet weak var imageVIew: UIImageView!
    //デバッグ用戻るボタン
    @IBAction func backButton(sender: AnyObject) {
        let walkingViewController = self.storyboard!.instantiateViewControllerWithIdentifier("walk")
        self.presentViewController(walkingViewController, animated: true, completion: nil)
    }
    
    
    //動物の番号を3(questionCount)で割った余りが正解の問題。
    @IBAction func answerButton1(sender: AnyObject) {
        if(appDelegate.route % questionCount == remainder0){
            trueAnswer()
        }else{
            falseAnswer()
        }
    }
    @IBAction func answerButton2(sender: AnyObject) {
        if(appDelegate.route % questionCount == remainder1){
            trueAnswer()
        }else{
            falseAnswer()
        }
    }
    @IBAction func answerButton3(sender: AnyObject) {
        if(appDelegate.route % questionCount == remainder2){
            trueAnswer()
        }else{
            falseAnswer()
        }
    }
    
    //最初に宣言しておく
    let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    
    //問題数を指定する変数
    let questionCount = 3
    
    //余りを定義
    let remainder0 = 0
    let remainder1 = 1
    let remainder2 = 2
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //appDelegate.decideRouteには最終的に選んだ動物のBeacon番号を格納
        self.messageLabel.text = appDelegate.data[appDelegate.route][appDelegate.message]
        self.animalLabel.text = appDelegate.data[appDelegate.route][appDelegate.name]
        
        self.quizLabel.text = appDelegate.data[appDelegate.route][appDelegate.question]
        answerButton1.setTitle(appDelegate.data[appDelegate.route][appDelegate.select1], forState: .Normal)
        answerButton2.setTitle(appDelegate.data[appDelegate.route][appDelegate.select2], forState: .Normal)
        answerButton3.setTitle(appDelegate.data[appDelegate.route][appDelegate.select3], forState: .Normal)
        
        let img = UIImage(named: "quiz.png")
        imageVIew.image = img
    }
    
    //正解時の処理
    func trueAnswer(){
        appDelegate.quizFlg = true
        let correctViewController = self.storyboard!.instantiateViewControllerWithIdentifier("correct")
        self.presentViewController(correctViewController, animated: true, completion: nil)
    }
    
    //不正解時の処理
    func falseAnswer(){
        appDelegate.quizFlg = false
        let falseViewController = self.storyboard!.instantiateViewControllerWithIdentifier("false")
        self.presentViewController(falseViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}