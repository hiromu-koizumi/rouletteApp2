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
    var finishCount: Int = 0
    var timer: Timer! = Timer()
    var index: Int = 0
    var direct: Int = 0
    var doneNumber: Int = 0
    var counter = 0
    
    @IBAction func textL(_ sender: Any) {
    }
    @IBAction func textR(_ sender: Any) {
    }
    @IBOutlet weak var textLeft: UITextField!
    @IBOutlet weak var textRight: UITextField!
    @IBOutlet weak var textCenterLeft: UITextField!
    @IBOutlet weak var textCenterRight: UITextField!
    @IBOutlet weak var textUnderLeft: UITextField!
    @IBOutlet weak var textUnderRight: UITextField!
    @IBOutlet weak var plus: UIButton!
    @IBOutlet weak var minus: UIButton!
        
    //プラスを押すと枠が増える処理
    @IBAction func pulsButton(_ sender: UIButton) {
        
        if counter < 4{
        counter += 1
        }
        switch counter {
        case 1:
            textCenterLeft.isHidden = false
        case 2:
             textCenterRight.isHidden = false
        case 3:
            textUnderLeft.isHidden = false
        case 4:
            textUnderRight.isHidden = false
        default:
            print("dame")
        }
    }
    
    
    // マイナスを押すと枠が減る処理
    @IBAction func minusButton(_ sender: UIButton) {
        if counter > 0{
        counter -= 1
        }
        switch counter {
        case 0:
            textCenterLeft.isHidden = true
        case 1:
            textCenterRight.isHidden = true
        case 2:
            textUnderLeft.isHidden = true
        case 3:
            textUnderRight.isHidden = true
        default:
            print("dame")
        }
    }
    
    @IBOutlet weak var retryButton: UIButton!
    
    
    
    @IBAction func retryB(_ sender: Any) {
        finishCount = 0
        textList = []
        textLeft.text = ""
        textRight.text = ""
        textCenterLeft.text = ""
        textCenterRight.text = ""
        textUnderLeft.text = ""
        textUnderRight.text = ""
        index = 0
        sampleLabel.text = ""
        retryButton.isHidden = true
        self.shareButton.isHidden = true
        doneB.isHidden = false
        textLeft.isHidden = false
        textRight.isHidden = false
        plus.isHidden = false
        minus.isHidden = false
        sampleLabel.textColor = UIColor.black
    }
    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBAction func share(_ sender: Any) {
        let shareText = "ルーレットの結果"

        let activityItems = [shareText] as [Any]

        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)


        // 使用しないアクティビティタイプ
//        let excludedActivityTypes = [
//            UIActivity.ActivityType.postToFacebook,
//            UIActivity.ActivityType.postToTwitter,
              //UIActivity.ActivityType.message
//            UIActivity.ActivityType.saveToCameraRoll,
//            UIActivity.ActivityType.print
//        ]

//        activityVC.excludedActivityTypes = excludedActivityTypes

        // UIActivityViewControllerを表示
        self.present(activityVC, animated: true, completion: nil)
       
    }
    
    @IBOutlet weak var backB: UIButton!
    @IBAction func backButton(_ sender: Any) {
        finishCount = 0
        textList = []
        textLeft.text = ""
        textRight.text = ""
        textCenterLeft.text = ""
        textCenterRight.text = ""
        textUnderLeft.text = ""
        textUnderRight.text = ""
        index = 0
        sampleLabel.text = ""
        retryButton.isHidden = true
        self.shareButton.isHidden = true
        doneB.isHidden = false
        textLeft.isHidden = false
        textRight.isHidden = false
        plus.isHidden = false
        minus.isHidden = false
        sampleLabel.textColor = UIColor.black
        timer.invalidate()
        backB.isHidden = true
        self.retryButton.isHidden = true
        self.shareButton.isHidden = true
    }
    
    
    @IBOutlet weak var maku: NSLayoutConstraint!
    @IBOutlet weak var doneB: UIButton!
    @IBAction func doneButton(_ sender: Any) {
        
        if textLeft.text != "" && textRight.text != ""{
            
            //演出と選ばれる文字をランダムにするための処理
            let doneRandam = Int(arc4random_uniform(6))
            print("donerandam is \(doneRandam)")
            switch doneRandam {
            case 0:
                doneNumber = 24
            case 1:
                doneNumber = 25
            case 2:
                doneNumber = 26
            case 3:
                doneNumber = 27
            case 4:
                doneNumber = 28
            case 5:
                doneNumber = 29
            default:
                print("dame")
                break
            }
            
            
            //演出をランダムにするための処理
            let directRandam = Int(arc4random_uniform(1))
            print("directrandam is \(directRandam)")
            switch directRandam {
            case 0:
                direct = 4
//            case 1:
//                direct = 2
//            case 2:
//                direct = 3
//            case 3:
//                direct = 4
            default:
                break
            }
            //labelの演出設定
            sampleLabel.morphingEffect = .scale
            
            //テキストが空ではないかつテキストフィールドにがtrueになっていれば代入する
            textList = [textLeft.text, textRight.text] as! [String]
            if textCenterLeft.text != "" && counter > 0{
                textList.append(textCenterLeft.text!)
            }
            if textCenterRight.text != "" && counter > 1{
                textList.append(textCenterRight.text!)
            }
            if textUnderLeft.text != "" && counter > 2{
                textList.append(textUnderLeft.text!)
            }
            if textUnderRight.text != "" && counter > 3{
                textList.append(textUnderRight.text!)
            }

            textLeft.isHidden = true
            textRight.isHidden = true
            textCenterLeft.isHidden = true
            textCenterRight.isHidden = true
            textUnderLeft.isHidden = true
            textUnderRight.isHidden = true
            doneB.isHidden = true
            plus.isHidden = true
            minus.isHidden = true
            backB.isHidden = false
            roulette(speed: 0.1)
            counter = 0
            
            
        }
        
    }
    
    
//幕が閉じるアニメーション
    func makuAnime(){
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
            self.maku.constant += self.view.bounds.height
            self.view.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            
            UIView.animate(withDuration: 0.2, delay: 2, options: .curveEaseOut, animations: {
                self.maku.constant -= self.view.bounds.height
                self.view.layoutIfNeeded()
            }, completion: nil)
        })
    }
    

    //揺れるアニメーション
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
    
    
    //拡大アニメーション
    func animate(){
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 0.2
        animationGroup.fillMode = CAMediaTimingFillMode.forwards
        animationGroup.isRemovedOnCompletion = false
        
        let animation1 = CABasicAnimation(keyPath: "transform.scale")
        animation1.fromValue = 10
        animation1.toValue = 1.0
        animationGroup.animations = [animation1]
        sampleLabel.layer.add(animationGroup, forKey: nil)
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
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //改行ボタンを完了ボタンに変更
        textLeft.returnKeyType = .done
        textRight.returnKeyType = .done
        textCenterLeft.returnKeyType = .done
        textCenterRight.returnKeyType = .done
        textUnderLeft.returnKeyType = .done
        textUnderRight.returnKeyType = .done
        //textFieldに入力している文字を全消しするclearボタン(×)を設定(書いている時のみの設定)
        textLeft.clearButtonMode = .whileEditing
        textRight.clearButtonMode = .whileEditing
        textCenterLeft.clearButtonMode = .whileEditing
        textCenterRight.clearButtonMode = .whileEditing
        textUnderLeft.clearButtonMode = .whileEditing
        textUnderRight.clearButtonMode = .whileEditing
        
        //bottun
        doneB.layer.cornerRadius = 30.0
        // エフェクトの定義
        sampleLabel.morphingEffect = .scale
        //sampleLabel.delegate = self
    }
    
    //UItextField以外の部分をタッチした場合にキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (textRight.isFirstResponder) {
            textRight.resignFirstResponder()
        }
        if (textLeft.isFirstResponder) {
            textLeft.resignFirstResponder()
        }
        if (textCenterRight.isFirstResponder) {
            textCenterRight.resignFirstResponder()
        }
        if (textCenterLeft.isFirstResponder) {
            textCenterLeft.resignFirstResponder()
        }
        if (textUnderRight.isFirstResponder) {
            textUnderRight.resignFirstResponder()
        }
        if (textUnderLeft.isFirstResponder) {
            textUnderLeft.resignFirstResponder()
        }
    }
    

   //timer起動、繰り返し処理。(speed:Double)でルーレットの速さを調整
    func roulette(speed:Double) {
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(speed),
                                     target: self,
                                     selector: #selector(updateLabel(timer:)),
                                     userInfo: nil,
                                     repeats: true)
        print("ルーレット")
        timer?.fire()
    }
    
    //rouletteの中で呼び出される。effectを呼び出しルーレットが始まる。
    @objc func updateLabel(timer: Timer) {
        
        effect(ansuwerNumber: doneNumber)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.invalidate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //幕を外に出す
        maku.constant -= view.bounds.height
        
    }
    
    
    
    //ルーレットのスピードを変更したいときに使う。timerを一度止め、新しくスピードの違うタイマーを呼び出す。finishCountを1増やす
    func stopTimer(speedNumber:Double){
        
       sampleLabel.text = textList[index]
        finishCount += 1
        timer.invalidate()
        roulette(speed: speedNumber)
        if index >= textList.count {
            index = 0
        }
    }
    
    
    //文字を交互に出力する。ルーレットを回す。
    //finishCountを1増やす。indexを1増やす
    func textDisplay(oto:String){
        sampleLabel.text = textList[index]
        finishCount += 1
        index += 1
        bgm(music: oto)
        print("finishCount = \(finishCount)")
        if index >= textList.count {
            index = 0
        }
    }
    
    //retryとシェアボタンを表示させる。戻るボタンを消す。
    func retryShare(){
        self.retryButton.isHidden = false
        self.shareButton.isHidden = false
        backB.isHidden = true
    }
    
    func effect(ansuwerNumber:Int){
        switch finishCount {
        case 0..<11:
            textDisplay(oto: "piko5")
        case 11:
            stopTimer(speedNumber: 1)
        case 12..<15:
            textDisplay(oto: "piko5")
        case 15:
            stopTimer(speedNumber: 2)
        case 16..<18:
            if finishCount == 17{
                //Labelのよ表示演出を変える
                sampleLabel.morphingEffect = .fall
            }
            textDisplay(oto: "piko5")
        case 18:
            stopTimer(speedNumber: 0.05)
        case 19..<ansuwerNumber:
            //answerNumberで最後に表示する文字を変えてる
            
            textDisplay(oto: "piko5")
        case ansuwerNumber:
            sampleLabel.textColor = UIColor.red
            
            //timerを止める
            timer?.invalidate()
            bgm(music: "finish1")
            // ↑↑↑以上共通処理
            
            //演出が枝分かれする
            switch direct {
            case 1:
                retryShare()
            case 2:
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    
                    
                    self.animate()
                    self.textDisplay(oto: "finish2")
                    self.sampleLabel.textColor = UIColor.blue
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self.retryShare()
                }
            case 3:
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    
                    
                    self.animate()
                    self.textDisplay(oto: "finish2")
                    self.sampleLabel.textColor = UIColor.blue
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self.bgm(music: "terere")
                    self.vibrate(amount: 20)
                    
                }
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.2) {

                    self.textDisplay(oto: "finish3")
                    self.sampleLabel.textColor = UIColor.green
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                    self.retryShare()
                    
                }
                

            case 4:
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    
                    
                    self.animate()
                    self.textDisplay(oto: "finish2")
                    self.sampleLabel.textColor = UIColor.blue
                    
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self.bgm(music: "terere")
                    self.vibrate(amount: 20)
                    
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.2) {
                    self.textDisplay(oto: "finish3")
                    self.sampleLabel.textColor = UIColor.green
                    
                    
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                    self.makuAnime()
                    self.bgm(music: "doramu")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
                    self.sampleLabel.isHidden = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 11) {
                    self.animate()
                    self.sampleLabel.isHidden = false
                    self.textDisplay(oto: "ban")
                    self.sampleLabel.textColor = UIColor.orange
                    self.retryShare()
                }
            default:
                break
            }
        default:
            break
        }
    
    }
    
    @IBOutlet weak var sampleLabel: LTMorphingLabel!
}



