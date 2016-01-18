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
    
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    
    
    //動物の番号を3で割った余りが正解の問題。
    @IBAction func answerButton1(sender: AnyObject) {
        if(trueNo == 0){
            let correctViewController = self.storyboard!.instantiateViewControllerWithIdentifier("correct")
            self.presentViewController(correctViewController, animated: true, completion: nil)
        }else{
            let falseViewController = self.storyboard!.instantiateViewControllerWithIdentifier("false")
            self.presentViewController(falseViewController, animated: true, completion: nil)
        }
    }
    @IBAction func answerButton2(sender: AnyObject) {
        if(trueNo == 1){
            let correctViewController = self.storyboard!.instantiateViewControllerWithIdentifier("correct")
            self.presentViewController(correctViewController, animated: true, completion: nil)
        }else{
            let falseViewController = self.storyboard!.instantiateViewControllerWithIdentifier("false")
            self.presentViewController(falseViewController, animated: true, completion: nil)
        }
    }
    @IBAction func answerButton3(sender: AnyObject) {
        if(trueNo == 2){
            let correctViewController = self.storyboard!.instantiateViewControllerWithIdentifier("correct")
            self.presentViewController(correctViewController, animated: true, completion: nil)
        }else{
            let falseViewController = self.storyboard!.instantiateViewControllerWithIdentifier("false")
            self.presentViewController(falseViewController, animated: true, completion: nil)
        }
    }
    
    //最初に宣言しておく
    let appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    //選択したルートを問題番号として、この変数に格納
    var quizNo = 0
    
    //どのanswerボタンが正解なのかを判定する変数      
    //配列番号を3で割った余りを格納する変数
    var trueNo = 0
    
    //未実装(書いただけ)
    //選択したルートと、今一番近いbeacon番号が一緒だったら〜みたいな処理をしたい
    var flg = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //RouteViewControllerで選択したルートを変数に格納
        quizNo = appDelegate.decideRoute
        
        self.animalLabel.text = appDelegate.animals[quizNo]
        
        //正解のanswerボタンは3で割った余り
        trueNo = (quizNo % 3)
        
        self.quizLabel.text = appDelegate.quiz[quizNo]
        answerButton1.setTitle(appDelegate.answer1[quizNo], forState: .Normal)
        answerButton2.setTitle(appDelegate.answer2[quizNo], forState: .Normal)
        answerButton3.setTitle(appDelegate.answer3[quizNo], forState: .Normal)
        
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}