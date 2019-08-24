//
//  ViewController.swift
//  SoundScreen2
//
//  Created by 藤崎 達也 on 2019/08/23.
//  Copyright © 2019年 藤崎 達也. All rights reserved.
//

import UIKit
import CoreMotion
// import AudioToolbox
import AVFoundation
//import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var instructionImage: UIImageView!
    
    // MotionManager
    let motionManager = CMMotionManager()
    var audioPlayer: AVAudioPlayer!

    // Constant
    let updateInterval = 0.01
    let velocityXThreshold = 5.0
    let volumeSetting: Float = 1.0
    let startSound = 1
    let stopSound = 2
    
    // Image File name definition
    let imageFileName = "Artboard.jpg"
    
    // Sound File name definition
    let soundFileName = "take2"
    let fileExtension = "m4a"
    
    var accelerometerX = 0.0
    var accXTemp = 0.0
    var velocityX = 0.0
    
    // Flags
    var onoffFlag:Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
    }
    
    func outputAccelData(acceleration: CMAcceleration) {
        // 加速度センサー [G]
        accelerometerX = acceleration.x
        // 速度の計算
        velocityX = accelerometerX * accelerometerX
        
        if velocityX > velocityXThreshold {
            onoffFlag += 1
            
            print("flag : \(onoffFlag)")
            
            switch onoffFlag {
            case startSound :
                print(" true ")
            
                let url = Bundle.main.url(forResource: soundFileName, withExtension: fileExtension)
            
                do {
                    try audioPlayer = AVAudioPlayer(contentsOf: url!)
                
                    //サウンドをバッファに読み込んでおく
                    audioPlayer.prepareToPlay()
                } catch {
                    print("url   ", url!)
                    print(error)
                }
            
                audioPlayer.volume = volumeSetting
                audioPlayer.play()
                break
                
            case stopSound:
                audioPlayer.stop()
                break
            
            default:
                onoffFlag = 0
                break
            }
           
        } else {
            print(" false ")
        }
        
    }
    
    // センサー取得を止める場合
    func stopAccelerometer() {
        if (motionManager.isAccelerometerActive) {
            motionManager.stopAccelerometerUpdates()
        }
    }
    
    func dummy() {
        // バンドルした画像ファイルを読み込み
        // let image = UIImage(named: imageFileName)
        // Image Viewに画像を設定
        // instructionImage.image = image
    }


}

