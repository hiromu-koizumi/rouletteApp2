//
//  AppDelegate.swift
//  rouletteApp
//
//  Created by 小泉大夢 on 2018/11/07.
//  Copyright © 2018 小泉大夢. All rights reserved.
//

import UIKit
//import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//        return true
//    }
    
    
    //初回のみ呼び出すチュートリアル画面繊維の処理
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
       // FirebaseApp.configure()
        //FirebaseApp.configure()
       // FirebaseApp.configure()
                //        // テスト用のアプリID
//               GADMobileAds.configure(withApplicationID: "ca-app-pub-3940256099942544~1458002511")
        
        
//         GADMobileAds.configure(withApplicationID: "ca-app-pub-1378399291069038~3567091251")
        
        //使用するStoryBoardのインスタンス化
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // UserDefaultsにbool型のKey"launchedBefore"を用意
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if(launchedBefore == true) {
            //動作確認のために1回実行ごとに値をfalseに設定し直す
            //UserDefaults.standard.set(false, forKey: "launchedBefore")
            print("delegate初回じゃない")
            
            
        } else {
            //起動を判定するlaunchedBeforeという論理型のKeyをUserDefaultsに用意
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            //チュートリアル用のViewControllerのインスタンスを用意してwindowに渡す
            let tutorialVC = storyboard.instantiateViewController(withIdentifier: "TutorialViewController") as! TutorialViewController
            //with identifier 遷移したい画面のIidentiferの名前
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = tutorialVC
        print("delegate初回")
        }
        
       

        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
       
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    

}

