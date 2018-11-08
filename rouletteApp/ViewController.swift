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
        textLeft.text = ""
        textRight.text = ""
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
    
    @IBOutlet weak var doneB: UIButton!
    
    var huriwake: Int = 0
    @IBAction func doneButton(_ sender: Any) {
        sampleLabel.adjustsFontSizeToFitWidth = true
        finishCount = 0
        if textLeft.text != "" && textRight.text != ""{
            let randam = Int(arc4random_uniform(3)) // %2にしてhuriwakeをかならず1にする(テスト用)
            print("randam is \(randam)")
            switch randam {
            case 0:
                huriwake = 1
            case 1:
                huriwake = 2
            case 2:
                huriwake = 3
            case 3:
                huriwake = 4
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
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        sampleLabel.adjustsFontSizeToFitWidth = true
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
        sampleLabel.delegate = self
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
        print("didあぴあ")
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
    
    
    
    @objc func updateLabel(timer: Timer) {
        switch huriwake {
        case 1:
            effect1()
        case 2:
            effect2()
        case 3:
            effect3()
        case 4:
            effect4()
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
    
    func textDisplay(){
        sampleLabel.text = textList[index]
        finishCount += 1
        index += 1
        bgm(music: "piko5")
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
    
    func effect1() {
        
        if finishCount < 11{
            
            textDisplay()
            
            
        }else if finishCount == 11 {
            
            
            stopTimer(speedNumber: 1)
            
            
        }else if finishCount > 11 && finishCount < 15 {
            textDisplay()
            
            
            
        }else if finishCount == 15 {
            stopTimer(speedNumber: 2)
        }else if finishCount > 15 && finishCount < 18 {
            
            if finishCount == 17{
                sampleLabel.morphingEffect = .fall
            }
            textDisplay()
            
        }else if finishCount == 18 {
            stopTimer(speedNumber: 0.05)
            
        }else if finishCount > 18 && finishCount < 24{
        textDisplay()
        }
        
        else{
            effectFinish(sound: "finsish1")
        }
    }
    
    
    func effect2 (){
        
       
            textDisplay()
        
            effectFinish(sound: "finsish1")
        print("aa")
        
    }
    func effect3 (){
        
        if finishCount < 2{
            textDisplay()
            
        }else{
            effectFinish(sound: "finsish1")
        }
    }
    
    
    func effect4 (){
        
        if finishCount < 14{
            textDisplay()
            
        }else{
            effectFinish(sound: "finsish1")
        }
    }
    
    
    @IBOutlet weak var sampleLabel: LTMorphingLabel!
}



extension ViewController: LTMorphingLabelDelegate {
    
    func morphingDidStart(_ label: LTMorphingLabel) {
        print("morphingDidStart")
    }
    
    func morphingDidComplete(_ label: LTMorphingLabel) {
        print("morphingDidComplete")
    }
    
    func morphingOnProgress(_ label: LTMorphingLabel, progress: Float) {
        print("morphingOnProgress", progress)
    }
}




