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
    
    
    
    //動物の番号を3(questionCount)で割った余りが正解の問題。
    @IBAction func answerButton1(_ sender: AnyObject) {
        if(appDelegate.route % questionCount == remainder0){
            trueAnswer()
        }else{
            falseAnswer()
        }
    }
    @IBAction func answerButton2(_ sender: AnyObject) {
        if(appDelegate.route % questionCount == remainder1){
            trueAnswer()
        }else{
            falseAnswer()
        }
    }
    @IBAction func answerButton3(_ sender: AnyObject) {
        if(appDelegate.route % questionCount == remainder2){
            trueAnswer()
        }else{
            falseAnswer()
        }
    }
    
    //最初に宣言しておく
    let appDelegate:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    
    //問題数を指定する変数
    let questionCount = 3
    
    //余りを定義
    let remainder0:Int = 0
    let remainder1:Int = 1
    let remainder2:Int = 2
    
    
    var beaconNo:Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //appDelegate.decideRouteには最終的に選んだ動物のBeacon番号を格納
        self.messageLabel.text = appDelegate.data[appDelegate.route][appDelegate.message]
        self.animalLabel.text = appDelegate.data[appDelegate.route][appDelegate.name]
        
        self.quizLabel.text = appDelegate.data[appDelegate.route][appDelegate.question]
        answerButton1.setTitle(appDelegate.data[appDelegate.route][appDelegate.select1], for: UIControlState())
        answerButton2.setTitle(appDelegate.data[appDelegate.route][appDelegate.select2], for: UIControlState())
        answerButton3.setTitle(appDelegate.data[appDelegate.route][appDelegate.select3], for: UIControlState())
        
        let img = UIImage(named: "quiz.png")
        imageVIew.image = img
    }
    
    //正解時の処理
    func trueAnswer(){
        appDelegate.quizFlg = true
        let correctViewController = self.storyboard!.instantiateViewController(withIdentifier: "correct")
        self.present(correctViewController, animated: true, completion: nil)
    }
    
    //不正解時の処理
    func falseAnswer(){
        appDelegate.quizFlg = false
        let falseViewController = self.storyboard!.instantiateViewController(withIdentifier: "false")
        self.present(falseViewController, animated: true, completion: nil)
    }
    

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}
