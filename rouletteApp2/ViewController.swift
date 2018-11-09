//
//  ViewController.swift
//  rouletteApp
//
//  Created by 小泉大夢 on 2018/11/07.
//  Copyright © 2018 小泉大夢. All rights reserved.
//

import UIKit
import LTMorphingLabel
import AVFoundation


class ViewController: UIViewController {
    var textList = [String]()
    
    var player:AVAudioPlayer?
    
   
    @IBAction func textL(_ sender: Any) {
    }
    @IBAction func textR(_ sender: Any) {
    }
    @IBOutlet weak var textLeft: UITextField!
    @IBOutlet weak var textRight: UITextField!
    @IBOutlet weak var retryButton: UIButton!
    @IBAction func retryB(_ sender: Any) {
        finishCount = 0
        textList = []
        textLeft.text = "こんにちは"
        textRight.text = "ごはん"
        index = 0
        sampleLabel.text = ""
        retryButton.isHidden = true
        doneB.isHidden = false
        textLeft.isHidden = false
        textRight.isHidden = false
        sampleLabel.textColor = UIColor.black
        
    }
    
//    @IBAction func textL(_ sender: Any) {
//    }
//
//
//
//    @IBAction func textR(_ sender: Any) {
//    }
//    func efect13(){
//    print("iine")
//    self.makuAnime()
//    self.bgm(music: "doramu")
//    sampleLabel.isHidden = true
//    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//    // your code here
//    self.animate()
//    self.sampleLabel.isHidden = false
//    self.textDisplay(oto: "ban")
//    self.sampleLabel.textColor = UIColor.purple
//    self.retryButton.isHidden = false
//    self.timer?.invalidate()
//    }
//
//    }
    
    
    
    
  
    @IBOutlet weak var maku: NSLayoutConstraint!
    
    
    
    
    @IBOutlet weak var doneB: UIButton!
    var huriwake: Int = 0
    @IBAction func doneButton(_ sender: Any) {
       
        finishCount = 0
        if textLeft.text != "" && textRight.text != ""{
            let randam = Int(arc4random_uniform(1)) // %2にしてhuriwakeをかならず1にする(テスト用)
            print("randam is \(randam)")
            switch randam {
//            case 0:
//                huriwake = 1
//            case 1:
//                huriwake = 1_5
            case 0...1:
                huriwake = 1
//            case 4...5:
//                huriwake = 2_5
//            case 0...1:
//                huriwake = 3
//            case 9...11:
//                huriwake = 3_5
//            case 12...13:
//                huriwake = 4
//            case 14...15:
//                huriwake = 4_5
            default:
                print("dame")
                break
            }
            sampleLabel.morphingEffect = .scale
            textList = [textLeft.text, textRight.text] as! [String]
            textLeft.isHidden = true
            textRight.isHidden = true
            doneB.isHidden = true
            roulette(speed: 0.1)
            
        }
        
    }
    
    
    
//maku
    func makuAnime(){
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
            self.maku.constant += self.view.bounds.height
            self.view.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            
            UIView.animate(withDuration: 0.2, delay: 0.5, options: .curveEaseOut, animations: {
            //アニメーション２：アニメーション１が終わったら実行される
                self.maku.constant -= self.view.bounds.height
                self.view.layoutIfNeeded()
            }, completion: nil)
        })
    }
    
    
    
    
    
    //yure
    func vibrate(amount: Float) {
        if amount > 0 {
            var animation: CABasicAnimation
            animation = CABasicAnimation(keyPath: "transform.rotation")
            animation.duration = 0.05
            animation.fromValue = amount * Float(M_PI) / 180.0
            animation.toValue = 0 - (animation.fromValue as! Float)
            animation.repeatCount = 6.0
            animation.autoreverses = true
            sampleLabel.layer .add(animation, forKey: "VibrateAnimationKey")
        }
        else {
            sampleLabel.layer.removeAnimation(forKey: "VibrateAnimationKey")
        }
    }
    
    
    
    //音楽鳴らす関数
    func bgm(music :String){
        let soundURL = Bundle.main.url(forResource:  music
            , withExtension: "mp3")
        do {
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player?.numberOfLoops = 0  // ループ再生する
            player?.prepareToPlay()      // 即時再生させる
            player?.play()               // BGMを鳴らす
        } catch {
            print("error...")
        }
    }
    
    
    
    
    
    
    
    var finishCount: Int = 0
    var timer: Timer! = Timer()
    var index: Int = 0
    
    //kakudai
    func animate(){
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 0.2
        animationGroup.fillMode = CAMediaTimingFillMode.forwards
        animationGroup.isRemovedOnCompletion = false
        
        let animation1 = CABasicAnimation(keyPath: "transform.scale")
        animation1.fromValue = 10
        animation1.toValue = 1.0
        
//        let animation2 = CABasicAnimation(keyPath: "cornerRadius")
//        animation2.fromValue = 0.0
//        animation2.toValue = 20.0
        
//        let animation3 = CABasicAnimation(keyPath: "transform.rotation")
//        animation3.fromValue = 0.0
//        animation3.toValue = M_PI * 2.0
//        animation3.speed = 2.0
        
        animationGroup.animations = [animation1]//<-kononakani anime2.3irerutomawaru
        sampleLabel.layer.add(animationGroup, forKey: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//sampleLabel.adjustsFontSizeToFitWidth = true
//
//        let label = UILabel.init()
//        label.adjustsFontSizeToFitWidth = true
//        label.minimumScaleFactor = 0.01  //最小でも80%までしか縮小しない場合
        
        //改行ボタンを完了ボタンに変更
        textLeft.returnKeyType = .done
        textRight.returnKeyType = .done
        //textFieldに入力している文字を全消しするclearボタン(×)を設定(書いている時のみの設定)
        textLeft.clearButtonMode = .whileEditing
        textRight.clearButtonMode = .whileEditing
        
        //bottun
        doneB.layer.cornerRadius = 30.0
        // エフェクトの定義
        sampleLabel.morphingEffect = .scale
        //sampleLabel.delegate = self
    }
    
    //改行ボタンを押したときにキーボードを閉じる
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
    
    //UItextField以外の部分をタッチした場合にキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (textRight.isFirstResponder) {
            textRight.resignFirstResponder()
        }
        if (textLeft.isFirstResponder) {
            textLeft.resignFirstResponder()
        }
    }
    
    func roulette(speed:Double) {
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(speed),
                                     target: self,
                                     selector: #selector(updateLabel(timer:)),
                                     userInfo: nil,
                                     repeats: true)
        print("ルーレット")
        timer?.fire()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //それぞれ画面から出す
       
        maku.constant -= view.bounds.height
        
    }
    
    
    
    @objc func updateLabel(timer: Timer) {
        switch huriwake {
        case 1:
            effect5()
        case 1_5:
            effect1_5()
        case 2:
            effect2()
        case 2_5:
            effect2_5()
        case 3:
            effect3()
        case 3_5:
            effect3_5()
        case 4:
            effect4()
        case 4_5:
            effect4_5()
        default:
            print("dame")
        }
    }
    
    func stopTimer(speedNumber:Double){
        
        sampleLabel.text = textList[index]
        finishCount += 1
        timer.invalidate()
        roulette(speed: speedNumber)
        if index >= textList.count {
            index = 0
        }
    }
    
    func textDisplay(oto:String){
        sampleLabel.text = textList[index]
        finishCount += 1
        index += 1
        bgm(music: oto)
        if index >= textList.count {
            index = 0
        }
    }
    
    
    
    func effectFinish(sound:String){
        retryButton.isHidden = false
        sampleLabel.textColor = UIColor.red
        timer?.invalidate()
        bgm(music: sound)
    }
    
    
    
    func effect3() {
        
        if finishCount < 11{
            
            textDisplay(oto: "piko5")
            
            
        }else if finishCount == 11 {
            
            
            stopTimer(speedNumber: 1)
            
            
        }else if finishCount > 11 && finishCount < 15 {
            textDisplay(oto: "piko5")
            
            
            
        }else if finishCount == 15 {
            stopTimer(speedNumber: 2)
        }else if finishCount > 15 && finishCount < 18 {
            
            if finishCount == 17{
                sampleLabel.morphingEffect = .fall
            }
            textDisplay(oto: "piko5")
            
        }else if finishCount == 18 {
            stopTimer(speedNumber: 0.05)
            
        }else if finishCount > 18 && finishCount < 24{
        textDisplay(oto: "piko5")
        }else{
           effectFinish(sound: "finsish1")
            retryButton.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                
                
                self.animate()
                self.textDisplay(oto: "finish2")
                self.sampleLabel.textColor = UIColor.blue
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                // your code here
                self.bgm(music: "terere")
                self.vibrate(amount: 20)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.2) {
                // your code here
                
                self.textDisplay(oto: "finish3")
                self.retryButton.isHidden = false
                self.sampleLabel.textColor = UIColor.green
                self.timer?.invalidate()
            }
            
        }
            
//        }else if finishCount > 25 && finishCount < 27{
//            textDisplay(oto: "piko5")
//        }
//
//
//
//        else{
//
//            effectFinish(sound: "finsish1")
//        }
    }
    
    func effect3_5 (){
        
        if finishCount < 11{
            
            textDisplay(oto: "piko5")
            
            
        }else if finishCount == 11 {
            
            
            stopTimer(speedNumber: 1)
            
            
        }else if finishCount > 11 && finishCount < 15 {
            textDisplay(oto: "piko5")
            
            
            
        }else if finishCount == 15 {
            stopTimer(speedNumber: 2)
        }else if finishCount > 15 && finishCount < 19 {
            
            if finishCount == 18{
                sampleLabel.morphingEffect = .fall
            }
            textDisplay(oto: "piko5")
            
        }else if finishCount == 19 {
            stopTimer(speedNumber: 0.05)
            
        }else if finishCount > 19 && finishCount < 25{
            textDisplay(oto: "piko5")
        }else{
            effectFinish(sound: "finsish1")
            retryButton.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                
                
                self.animate()
                self.textDisplay(oto: "finish2")
                self.sampleLabel.textColor = UIColor.blue
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                // your code here
                self.bgm(music: "terere")
                self.vibrate(amount: 20)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.2) {
                // your code here
                
                self.textDisplay(oto: "finish3")
                self.retryButton.isHidden = false
                self.sampleLabel.textColor = UIColor.green
                self.timer?.invalidate()
            }
            
        }
        
    }
    
    
    
    
    
    func effect1 (){
        
       
            textDisplay(oto: "piko5")
             animate()
            effectFinish(sound: "finsish1")
        print("aa")
        
    }
    func effect1_5 (){
        
        if finishCount < 2{
            textDisplay(oto: "piko5")
            
        }else{
            effectFinish(sound: "finsish1")
        }
    }
    
    
    func effect2 (){
        
        if finishCount < 11{
            
            textDisplay(oto: "piko5")
            
            
        }else if finishCount == 11 {
            
            
            stopTimer(speedNumber: 1)
            
            
        }else if finishCount > 11 && finishCount < 15 {
            textDisplay(oto: "piko5")
            
            
            
        }else if finishCount == 15 {
            stopTimer(speedNumber: 2)
        }else if finishCount > 15 && finishCount < 18 {
            
            if finishCount == 17{
                sampleLabel.morphingEffect = .fall
            }
            textDisplay(oto: "piko5")
            
        }else if finishCount == 18 {
            stopTimer(speedNumber: 0.05)
            
        }else if finishCount > 18 && finishCount < 24{
            textDisplay(oto: "piko5")
        }else{
            effectFinish(sound: "finsish1")
            retryButton.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                
                
                self.animate()
                self.textDisplay(oto: "finish2")
                self.sampleLabel.textColor = UIColor.blue
                self.retryButton.isHidden = false
                self.timer?.invalidate()
            }
        }
            
    }
        
    
    func effect2_5 (){
        
        if finishCount < 11{
            
            textDisplay(oto: "piko5")
            
            
        }else if finishCount == 11 {
            
            
            stopTimer(speedNumber: 1)
            
            
        }else if finishCount > 11 && finishCount < 15 {
            textDisplay(oto: "piko5")
            
            
            
        }else if finishCount == 15 {
            stopTimer(speedNumber: 2)
        }else if finishCount > 15 && finishCount < 18 {
            
            if finishCount == 17{
                sampleLabel.morphingEffect = .fall
            }
            textDisplay(oto: "piko5")
            
        }else if finishCount == 18 {
            stopTimer(speedNumber: 0.05)
            
        }else if finishCount > 18 && finishCount < 25{
            textDisplay(oto: "piko5")
        }else{
            effectFinish(sound: "finsish1")
            retryButton.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                
                
                self.animate()
                self.textDisplay(oto: "finish2")
                self.sampleLabel.textColor = UIColor.blue
                self.retryButton.isHidden = false
                self.timer?.invalidate()
            }
        }
        
    }
    
    //通常のやつ
    
    func effect4 (){

        if finishCount < 11{
            textDisplay(oto: "piko5")

        }else if finishCount == 11 {


            stopTimer(speedNumber: 1)


        }else if finishCount > 11 && finishCount < 15 {
            textDisplay(oto: "piko5")



        }else if finishCount == 15 {
            stopTimer(speedNumber: 2)
        }else if finishCount > 15 && finishCount < 18 {

            textDisplay(oto: "piko5")

        }else{
            effectFinish(sound: "finsish1")
        }
    }
//
//    func effect4_5 (){
//
//        if finishCount < 11{
//            textDisplay(oto: "piko5")
//
//        }else if finishCount == 11 {
//
//
//            stopTimer(speedNumber: 1)
//
//
//        }else if finishCount > 11 && finishCount < 15 {
//            textDisplay(oto: "piko5")
//
//
//
//        }else if finishCount == 15 {
//            stopTimer(speedNumber: 2)
//        }else if finishCount > 15 && finishCount < 19 {
//            textDisplay(oto: "piko5")
//
//        }else{
//            effectFinish(sound: "finsish1")
//        }
//    }
//
    
    func effect4_5 (){
    if finishCount < 11{
    
    textDisplay(oto: "piko5")
    
    
    }else if finishCount == 11 {
    
    
    stopTimer(speedNumber: 1)
    
    
    }else if finishCount > 11 && finishCount < 15 {
    textDisplay(oto: "piko5")
    
    
    
    }else if finishCount == 15 {
    stopTimer(speedNumber: 2)
    }else if finishCount > 15 && finishCount < 18 {
    
    if finishCount == 17{
    sampleLabel.morphingEffect = .fall
    }
    textDisplay(oto: "piko5")
    
    }else if finishCount == 18 {
    stopTimer(speedNumber: 0.05)
    
    }else if finishCount > 18 && finishCount < 24{
    textDisplay(oto: "piko5")
    }else{
        effectFinish(sound: "finsish1")
        }
    }
    
    
    
    func effect5() {
        
        if finishCount < 11{
            
            textDisplay(oto: "piko5")
            
            
        }else if finishCount == 11 {
            
            
            stopTimer(speedNumber: 1)
            
            
        }else if finishCount > 11 && finishCount < 15 {
            textDisplay(oto: "piko5")
            
            
            
        }else if finishCount == 15 {
            stopTimer(speedNumber: 2)
        }else if finishCount > 15 && finishCount < 18 {
            
            if finishCount == 17{
                sampleLabel.morphingEffect = .fall
            }
            textDisplay(oto: "piko5")
            
        }else if finishCount == 18 {
            stopTimer(speedNumber: 0.05)
            
        }else if finishCount > 18 && finishCount < 24{
            textDisplay(oto: "piko5")
        }else if finishCount == 24 {
            effectFinish(sound: "finsish1")
            retryButton.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                
                
                self.animate()
                self.textDisplay(oto: "finish2")
                self.sampleLabel.textColor = UIColor.blue
                print("2:\(self.finishCount)")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                // your code here
                self.bgm(music: "terere")
                self.vibrate(amount: 20)
                print("4:\(self.finishCount)")

            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.2) {
                // your code here
                
                self.textDisplay(oto: "finish3")
                self.sampleLabel.textColor = UIColor.green
                print("\(self.finishCount)")
                print("5.2:\(self.finishCount)")

            }
            
        }else if finishCount > 24  {
        print("iine")
//            makuAnime()
//            bgm(music: "doramu")
//            sampleLabel.isHidden = true
//            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//                // your code here
//                self.animate()
//                self.sampleLabel.isHidden = false
//                self.textDisplay(oto: "ban")
//                self.sampleLabel.textColor = UIColor.purple
//                self.retryButton.isHidden = false
//                self.timer?.invalidate()
//            }
            
        }
        
       
    }
    
    
    
    
    @IBOutlet weak var sampleLabel: LTMorphingLabel!
}



//extension ViewController: LTMorphingLabelDelegate {
//
//    func morphingDidStart(_ label: LTMorphingLabel) {
//        print("morphingDidStart")
//    }
//
//    func morphingDidComplete(_ label: LTMorphingLabel) {
//        print("morphingDidComplete")
//    }
//
//    func morphingOnProgress(_ label: LTMorphingLabel, progress: Float) {
//        print("morphingOnProgress", progress)
//    }
//}




