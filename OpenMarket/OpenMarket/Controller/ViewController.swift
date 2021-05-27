//
//  OpenMarket - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewTypeSegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        initSegmentControl()
    }
    
    func initSegmentControl() {
        viewTypeSegmentControl.setTitle("LIST", forSegmentAt: 0)
        viewTypeSegmentControl.setTitle("GRID", forSegmentAt: 1)
        viewTypeSegmentControl.tintColor = UIColor.white
        viewTypeSegmentControl.layer.borderColor = UIColor.systemBlue.cgColor
        viewTypeSegmentControl.backgroundColor = UIColor.systemBackground
        viewTypeSegmentControl.selectedSegmentTintColor = UIColor.systemBlue
        let selectedTextAttrubutes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        viewTypeSegmentControl.setTitleTextAttributes(selectedTextAttrubutes, for: .selected)
        let normalTextAttrubutes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        viewTypeSegmentControl.setTitleTextAttributes(normalTextAttrubutes, for: .normal)
        viewTypeSegmentControl.layer.borderWidth = 1
    }

}

