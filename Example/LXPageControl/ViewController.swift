//
//  ViewController.swift
//  LXPageControl
//
//  Created by leonx98 on 06/09/2018.
//  Copyright (c) 2018 leonx98. All rights reserved.
//

import UIKit
import LXPageControl

class ViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet var pageControl: LXPageControl!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageControl.delegate = self
    }

}

extension ViewController: LXPageControlDelegate {
    func pageControl(_ pageControl: LXPageControl, changeProgress to: Int) {
        print("PageControl did change Progress to: \(to)")
    }
    
    func pageControl(_ pageControl: LXPageControl, didPressedOn button: UIButton) {
        print("Pressed Button")
    }
}

