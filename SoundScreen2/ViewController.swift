//
//  ViewController.swift
//  SoundScreen2
//
//  Created by 藤崎 達也 on 2019/08/23.
//  Copyright © 2019年 藤崎 達也. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var soundOnButton: UIButton!
    @IBOutlet weak var soundOffButton: UIButton!
    
    // let motionManager = CMMotionManager()
    var audioPlayer: AVAudioPlayer!

    // Constant
    let volumeSetting: Float = 1.0
  
    // Sound File name definition
    let soundFileName = "testSound"
    let fileExtension = "wav"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func soundOn() {
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
    }
    
    func soundOff() {
        audioPlayer.stop()
    }
    
    
    @IBAction func soiundOnButtonTapped(_ sender: UIButton) {
        soundOn()
    }
    
    @IBAction func soundOffButtonTapped(_ sender: UIButton) {
        soundOff()
    }

}

