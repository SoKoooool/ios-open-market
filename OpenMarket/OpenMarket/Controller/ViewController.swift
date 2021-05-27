//
//  OpenMarket - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewTypeSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var gridView: UIView!
    
    let data: [Int] = [1,2,3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        initSegmentControl()
        gridView.isHidden = true
        
    }
    
    @IBAction func segmentedControllValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            listView.isHidden = false
            gridView.isHidden = true
        }
        else if sender.selectedSegmentIndex == 1 {
            listView.isHidden = true
            gridView.isHidden = false
        }
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

