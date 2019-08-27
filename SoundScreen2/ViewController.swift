//
//  ViewController.swift
//  SoundScreen2
//
//  Created by 藤崎 達也 on 2019/08/23.
//  Copyright © 2019年 藤崎 達也. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var soundOnButton: UIButton!
    @IBOutlet weak var soundOffButton: UIButton!
    
    
    @IBOutlet weak var volumePicker: UIPickerView!
    
    let dataList = [
        "Maxmum", "Medium", "Minimum"
    ]
    
    var audioPlayer: AVAudioPlayer!

    // Constant
    let volumeSetting: Float = 1.0
  
    // Sound File name definition
    let soundFileName = "testSound"
    let fileExtension = "wav"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Delegate設定
        volumePicker.delegate = self
        volumePicker.dataSource = self
        
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
    
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    // UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return dataList[row]
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        
       // label.text = dataList[row]
        
    }
    

}

