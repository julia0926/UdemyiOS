//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let eggsTitle = ["Soft": 5, "Medium": 7, "Hard": 10]
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        let title = sender.currentTitle!
        let result = eggsTitle[title] //타입이 옵셔널임
        print(result!) //그러므로 출력할 때 ! 붙임
    }
    

}
