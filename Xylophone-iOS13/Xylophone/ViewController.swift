//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func keyPressed(_ sender: UIButton) {
        
        //파라미터로 버튼의 title
        playSound(soundName: sender.currentTitle!)
        sender.alpha = 0.5

          //Code should execute after 0.2 second delay.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { //2초뒤에 실행 
            //Bring's sender's opacity back up to fully opaque.
            sender.alpha = 1.0 //투명했다가 다시 되돌려 놓는
        }
    }
    
    func playSound(soundName: String) { //파라미터로 넘겨서 버튼의 타이틀별로 소리 다름
        let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
}
