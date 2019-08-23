//
//  ViewController.swift
//  SoundScreen2
//
//  Created by 藤崎 達也 on 2019/08/23.
//  Copyright © 2019年 藤崎 達也. All rights reserved.
//

import UIKit
import CoreMotion
import AudioToolbox

class ViewController: UIViewController {
    
    @IBOutlet weak var instructionImage: UIImageView!
    
    // MotionManager
    let motionManager = CMMotionManager()
    
    // Constant
    let updateInterval = 0.05
    let velocityXThreshold = 5.0
    
    // Image File name definition
    let imageFileName = "Artboard.jpg"
    
    
    var accelerometerX = 0.0
    var accXTemp = 0.0
    var velocityX = 0.0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       // while true {
        
            if motionManager.isAccelerometerAvailable {
                // intervalの設定 [sec]
                motionManager.accelerometerUpdateInterval = updateInterval
            
                // センサー値の取得開始
                motionManager.startAccelerometerUpdates(
                    to: OperationQueue.current!,
                    withHandler: {(accelData: CMAccelerometerData?, errorOC: Error?) in
                        self.outputAccelData(acceleration: accelData!.acceleration)
                })
            }
            
        // }
    }
    
    func outputAccelData(acceleration: CMAcceleration) {
        // 加速度センサー [G]
        accelerometerX = acceleration.x
        
        // accelerometerX = accXTemp
        
        accXTemp = accelerometerX - accXTemp
        
        // print("1: \(accXTemp)")
        
        accXTemp = accelerometerX
        
        // print("2: \(accXTemp)")
        
        // 速度の計算
        velocityX = accelerometerX * accelerometerX
         print("V: \(velocityX)")
        
        if velocityX > velocityXThreshold {
            print(" true ")
            
            
            
            // バンドルした画像ファイルを読み込み
            let image = UIImage(named: imageFileName)
            
            // Image Viewに画像を設定
            instructionImage.image = image
            
            
            
            var soundId:SystemSoundID = 0
            
            // システムサウンドへのパスを指定
            if let soundUrl:NSURL = NSURL(fileURLWithPath: "/System/Library/Audio/UISounds/alarm.caf") {
                
                // SystemsoundIDを作成して再生実行
                AudioServicesCreateSystemSoundID(soundUrl, &soundId)
                AudioServicesPlaySystemSound(soundId)
            }
            
        } else {
            print(" false ")
        }
        
        
       
    }
    
    // センサー取得を止める場合
    func stopAccelerometer(){
        if (motionManager.isAccelerometerActive) {
            motionManager.stopAccelerometerUpdates()
        }
    }


}

