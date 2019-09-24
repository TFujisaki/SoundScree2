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
    @IBOutlet weak var interruptNotice: UILabel!
    
    var audioPlayer: AVAudioPlayer!
    var audioSession: AVAudioSession!

    // Constant
    let volumeSetting: Float = 1.0     // Max is 1.0
    let max: Float = 1.00              // Must be same as volumeSetting
    let fadeoutStep: Double = 10
    let timeInterval = 0.55
  
    // Sound File name definition
    let soundFileName = "testSound"
    let fileExtension = "wav"
    
    // String Constants
    let offText = "フェードアウト"
    let alertTitle = "音量設定"
    let alertMessage = "音量は最大ですか？"
    let alertAciton = "OK"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForNotifications()
        audioSession = AVAudioSession.sharedInstance()
        
        var currentMode = audioSession.mode
        currentMode = .default        // Set mode
        
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback, mode: currentMode)
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
    }
    
    func soundOn() {
        if showAlert(title: alertTitle, message: alertMessage, btnText: alertAciton) {
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
    }
    
    func soundOff() {
        for i in 1...Int(fadeoutStep) {
            audioPlayer.volume = Float(max) - Float((Double(max)/fadeoutStep) * Double(i))
            Thread.sleep(forTimeInterval: timeInterval)
        }
        audioPlayer.stop()
        // soundOffButton.setTitle("tomeru", for: .normal)
    }
    
    @IBAction func soiundOnButtonTapped(_ sender: UIButton) {
        soundOn()
    }
    
    @IBAction func soundOffButtonTapped(_ sender: UIButton) {
        // Swift 3スタイル
        // まずキューを生成して、それを非同期スレッドで動かします。
        DispatchQueue(label: "SondOffThred").async {
            self.soundOff()
        }
        
        // メインスレッドに戻ってUIに絡む
        DispatchQueue.main.async {
            self.changeButtonTile()
        }
    }
    
    func changeButtonTile() {
        soundOffButton.setTitle(offText, for: .normal)
    }
    
    // 着信を知らせる　あまり意味がない。
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleInterruption),
                                               name: AVAudioSession.interruptionNotification,
                                               object: AVAudioSession.sharedInstance())
    }
    
    @objc func handleInterruption(_ notification: Notification) {
        print("interrupt occured")
        interruptNotice.text = "着信"
    }
    
    // Alertで処理を止めたい。今はやり方がわからない。
    func showAlert( title: String, message: String, btnText: String ) -> Bool {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: btnText, style: .default, handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
        return true
    }
    
}

