//
//  OpenMarket - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let img = UIImage(systemName: "pencil.circle")
        let imgData = img?.pngData()
        let itemInfo = ItemRegistrationForm(title: "시간", descriptions: "시간은 금이라고 친구!", price: 0, currency: "KRW", stock: 0, discountedPrice: nil, images: [imgData!], password: "1234")
        
        let network = HTTPMethod()
//        network.get(id: 106)
        network.post(itemInfo: itemInfo)
    }


}

