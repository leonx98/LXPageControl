//
//  LXPageControlDelegate.swift
//  LXPageControl
//
//  Created by Leon Hoppe on 09.06.18.
//

import UIKit

public protocol LXPageControlDelegate {
    func pageControl(_ pageControl: LXPageControl, didPressedOn button: UIButton)
    func pageControl(_ pageControl: LXPageControl, changeProgress to: Int)
}
