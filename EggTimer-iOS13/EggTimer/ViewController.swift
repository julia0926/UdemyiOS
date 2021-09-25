//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    let eggsTitle = ["Soft": 3, "Medium": 4, "Hard": 7]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer!
//
//    override func viewDidLoad() {
//            super.viewDidLoad()
//
//        progressBar.clipsToBounds = true
//        progressBar.layer.cornerRadius = 8
//        progressBar.clipsToBounds = true
//        progressBar.layer.sublayers![1].cornerRadius = 8// 뒤에 있는 회색 track
//        progressBar.subviews[1].clipsToBounds = true
//
//        }

    
    @IBAction func buttonClicked(_ sender: UIButton) {
        timer.invalidate()
        let title = sender.currentTitle!
        totalTime = eggsTitle[title]!
        
        //버튼 누를때 초기화
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = title
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }

    //update progress
    @objc func updateCounter() {
        //example functionality
        if secondsPassed < totalTime {
            secondsPassed += 1

            let persectProgress = Float(secondsPassed) / Float(totalTime)
            print(persectProgress)
            progressBar.progress = persectProgress
            
        }else{
            timer.invalidate()
            playSound()
            titleLabel.text = "Egg's are Ready!"
            
        }
    }
    
    func playSound() {
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
                    
        }

}
