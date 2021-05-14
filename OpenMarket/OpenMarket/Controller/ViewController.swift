//
//  OpenMarket - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    
    var segmentedController: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSegemetedController()
    }
    
    
    func setSegemetedController () {
        let items = ["List", "GRID"]
        segmentedController = UISegmentedControl(items: items)
        segmentedController.tintColor = UIColor.white
        segmentedController.layer.borderColor = UIColor.systemBlue.cgColor
        segmentedController.backgroundColor = UIColor.systemBackground
        segmentedController.selectedSegmentIndex = 0
        segmentedController.selectedSegmentTintColor = UIColor.systemBlue
        let selectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentedController.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        let normalTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        segmentedController.setTitleTextAttributes(normalTextAttributes, for: .normal)
        segmentedController.layer.borderWidth = 1
        for index in 0..<items.count {
            segmentedController.setWidth(80, forSegmentAt: index)
        }
        navigationItem.titleView = segmentedController
    
    }

}

