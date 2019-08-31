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
    
    
    var audioPlayer: AVAudioPlayer!
    var audioSession: AVAudioSession!

    // Constant
    let volumeSetting: Float = 0.1  // Max is 1.0
    let max: Float = 0.1            // Must be same as volumeSetting
    let fadeoutStep: Double = 10
    let timeInterval = 0.55
  
    // Sound File name definition
    let soundFileName = "testSound"
    let fileExtension = "wav"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        audioSession = AVAudioSession.sharedInstance()
        let currentMode = audioSession.mode
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback, mode: currentMode)
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
    }
    
    
    func soundOn() {
        let url = Bundle.main.url(forResource: soundFileName, withExtension: fileExtension)
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url!)
            
            // Buffer
            audioPlayer.prepareToPlay()
        } catch {
            print("url   ", url!)
            print(error)
        }
        
        audioPlayer.volume = volumeSetting
        audioPlayer.play()
    }
    
    func soundOff() {
        for i in 1...Int(fadeoutStep) {
            audioPlayer.volume = Float(max) - Float((Double(max)/fadeoutStep) * Double(i))
            Thread.sleep(forTimeInterval: timeInterval)
        }
        audioPlayer.stop()
    }
    
    @IBAction func soiundOnButtonTapped(_ sender: UIButton) {
        soundOn()
    }
    
    @IBAction func soundOffButtonTapped(_ sender: UIButton) {
        soundOff()
    }
    
}

