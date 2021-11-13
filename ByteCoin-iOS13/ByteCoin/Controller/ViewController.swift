//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
    }
   
    
}
//MARK: - UIPickerViewDataSource
    
extension ViewController: UIPickerViewDataSource{
    //columns of number
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //rows of number
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}
    

//MARK: - UIPickerViewDelegate

extension ViewController: UIPickerViewDelegate{
    //한 줄의 타이틀을 리턴
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    //피커 아이템 선택했을 때
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}

//MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate{
    func didUpdateCoin(coin: String, type: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = coin
            self.currencyLabel.text = type
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
    
}
