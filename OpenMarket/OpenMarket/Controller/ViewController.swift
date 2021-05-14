//
//  OpenMarket - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var firstView: UIView!
    @IBOutlet var secondView: UIView!
    var segmentedController: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSegemetedController()
        secondView.isHidden = true
    }
    
    @objc func segmentedControllValueChanged(_ sender: UISegmentedControl!) {
        switch sender.selectedSegmentIndex {
        case 0:
            firstView.isHidden = false
            secondView.isHidden = true
        case 1:
            firstView.isHidden = true
            secondView.isHidden = false
        default:
            break
        }
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
        segmentedController.addTarget(self, action: #selector(segmentedControllValueChanged), for: .valueChanged)
        navigationItem.titleView = segmentedController
    }

}

