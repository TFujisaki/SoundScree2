//
//  ViewController.swift
//  SoundScreen2
//
//  Created by 藤崎 達也 on 2019/08/23.
//  Copyright © 2019年 藤崎 達也. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    // MotionManager
    let motionManager = CMMotionManager()
    
    var accelerometerX = 0.0
    var accXTemp = 0.0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       // while true {
        
            if motionManager.isAccelerometerAvailable {
                // intervalの設定 [sec]
                motionManager.accelerometerUpdateInterval = 0.2
            
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
        
         print(accXTemp)
        
        accXTemp = accelerometerX
        
       
    }
    
    // センサー取得を止める場合
    func stopAccelerometer(){
        if (motionManager.isAccelerometerActive) {
            motionManager.stopAccelerometerUpdates()
        }
    }


}

