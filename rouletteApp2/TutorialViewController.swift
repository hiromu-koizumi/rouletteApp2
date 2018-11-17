//
//  TutorialViewController.swift
//  rouletteApp2
//
//  Created by 小泉大夢 on 2018/11/11.
//  Copyright © 2018 小泉大夢. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController,UIGestureRecognizerDelegate{

    @IBAction func skipButton(_ sender: Any) {
        
    }
    
        var textList = [String]()
        var finishCount: Int = 0
        var timer: Timer! = Timer()
        var index: Int = 0
        var direct: Int = 0
        var doneNumber: Int = 0
        var counter = 0
        
    @IBOutlet weak var tutorial: UILabel!
    @IBOutlet weak var tutorial2: UILabel!
    @IBOutlet weak var yazirusi1: UILabel!
    @IBOutlet weak var yazirusi2: UILabel!
    

    @IBOutlet weak var tutorial3: UILabel!
    @IBOutlet weak var tutorial4: UILabel!
    @IBOutlet weak var yazirusi3: UILabel!
    @IBOutlet weak var yazirusi4: UILabel!
    
    @IBOutlet weak var tutorial5: UILabel!
    @IBOutlet weak var yazirusi5: UILabel!
    
    
    @IBOutlet weak var goButton: UIButton!
    
    @IBOutlet weak var tutorial1: UILabel!
    
    
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
    
        
        
    
    
            
    
    
        @IBOutlet weak var doneB: UIButton!
        @IBAction func doneButton(_ sender: Any) {
            
           
                
            
    }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            print("viewDidLoad")
            let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(
                target: self,
                action: #selector(TutorialViewController.tapped(_:)))
            
            // デリゲートをセット
            tapGesture.delegate = self
            
            self.view.addGestureRecognizer(tapGesture)
            
            
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
            //sampleLabel.delegate = self
        }
        var tapp: Int = 0
    @objc func tapped(_ sender: UITapGestureRecognizer){
        if sender.state == .ended {
            print("タップ")
            tapp += 1
            switch tapp {
            case 1:
                tutorial.isHidden = true
                tutorial1.isHidden = true
                tutorial2.isHidden = false
                yazirusi1.isHidden = false
                yazirusi2.isHidden = false
                textLeft.isHidden = false
                textRight.isHidden = false
            case 2:
                tutorial2.isHidden = true
                yazirusi1.isHidden = true
                yazirusi2.isHidden = true
                
                tutorial3.isHidden = false
                tutorial4.isHidden = false
                yazirusi3.isHidden = false
                yazirusi4.isHidden = false
                minus.isHidden = false
                plus.isHidden = false
                
            case 3:
                tutorial3.isHidden = true
                tutorial4.isHidden = true
                yazirusi3.isHidden = true
                yazirusi4.isHidden = true
                
                tutorial5.isHidden = false
                yazirusi5.isHidden = false
                doneB.isHidden = false

            case 4:
                tutorial5.isHidden = true
                yazirusi5.isHidden = true
                doneB.isHidden = true
                minus.isHidden = true
                plus.isHidden = true
                textLeft.isHidden = true
                textRight.isHidden = true
                textCenterLeft.isHidden = true
                textCenterRight.isHidden = true
                textUnderLeft.isHidden = true
                textUnderRight.isHidden = true 
                
                goButton.isHidden = false
            default:
                print("dame")
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
            

}

