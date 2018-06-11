//
//  LXPageControl.swift
//  LXPageControl
//
//  Created by Leon Hoppe on 09.06.18.
//

import UIKit
import QuartzCore

@IBDesignable
public class LXPageControl: UIControl {
    
    //MARK: Properties
    public var leftBtn: UIButton = UIButton()
    public var rightBtn: UIButton = UIButton()
    public var delegate: LXPageControlDelegate?
    private var mainLayer: CAReplicatorLayer = CAReplicatorLayer()
    private var maskLayer: CAReplicatorLayer = CAReplicatorLayer()
    private var element: CALayer = CALayer()
    private var maskElement: CALayer = CALayer()
    private var indicator: CALayer = CALayer()
    private var backLayer: CALayer = CALayer()
    private var isAnimated: Bool = true
    
    
    @IBInspectable public var pages: Int = 3 {
        didSet {
            if (self.pages < 1) {
                self.pages = 1
            }
            self.updatePagesCount()
        }
    }
    
    @IBInspectable public var currentPage: Int = 0 {
        didSet {
            if (self.currentPage < 0) {
                self.currentPage = 0
            }
            else if (self.currentPage >= self.pages) {
                self.currentPage = self.pages - 1
            }
            self.updateIndicator()
        }
    }
    
    @IBInspectable public var elementWidth: CGFloat = 30 {
        didSet {
            if (self.fillWidthAutomatically) {
                let widthPlusSpacing = self.bounds.width - (CGFloat(self.pages - 1) * self.spacing)
                self.elementWidth = (widthPlusSpacing / CGFloat(self.pages))
            }
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var elementHeight: CGFloat = 5 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var spacing: CGFloat = 8 {
        didSet {
            if (self.spacing < 0) {
                self.spacing = 0
            }
            if (self.fillWidthAutomatically) {
                let widthPlusSpacing = self.bounds.width - (CGFloat(self.pages - 1) * self.spacing)
                self.elementWidth = (widthPlusSpacing / CGFloat(self.pages))
            }
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var inactiveColor: UIColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var activeColor: UIColor = UIColor.white {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            if (self.cornerRadius < 0)
            {
                self.cornerRadius = 0
            }
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable public var fillWidthAutomatically: Bool = false {
        didSet {
            if (self.fillWidthAutomatically) {
                let widthPlusSpacing = self.bounds.width - (CGFloat(self.pages - 1) * self.spacing)
                self.elementWidth = (widthPlusSpacing / CGFloat(self.pages))
            }
            self.setNeedsLayout()
        }
    }
    
    override public var intrinsicContentSize: CGSize {
        get {
            return self.sizeThatFits(CGSize.zero)
        }
    }
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initialConfiguration()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initialConfiguration()
    }
    
    //MARK: Functions
    private func initialConfiguration() {
        self.backgroundColor = UIColor.clear
        
        // Set layer hierarchy
        self.layer.addSublayer(self.mainLayer)
        self.layer.addSublayer(self.backLayer)
        self.mainLayer.addSublayer(self.element)
        self.backLayer.addSublayer(self.indicator)
        self.maskLayer.addSublayer(self.maskElement)
        
        self.backLayer.addSublayer(self.maskLayer)
        self.backLayer.mask = self.maskLayer
        
        
        // Set buttons
        self.leftBtn.addTarget(self, action: #selector(updateProgress(_:)), for: .touchUpInside)
        self.addSubview(leftBtn)
        
        self.rightBtn.addTarget(self, action: #selector(updateProgress(_:)), for: .touchUpInside)
        self.addSubview(rightBtn)
        
        // Set initial values for properties
        self.pages = 3
        self.currentPage = 0
        self.elementWidth = 30
        self.elementHeight = 5
        self.spacing = 8
        self.inactiveColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3)
        self.activeColor = UIColor.white
        self.cornerRadius = 0
        self.fillWidthAutomatically = false
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.mainLayer.frame = self.bounds
        self.mainLayer.instanceTransform = CATransform3DMakeTranslation(self.elementWidth + self.spacing, 0, 0)
        let maskWidth = CGFloat(self.pages) * (self.elementWidth + self.spacing)
        self.maskLayer.backgroundColor = UIColor.clear.cgColor
        self.maskLayer.frame = CGRect(x: 0, y: 0, width: maskWidth, height: self.elementHeight)
        self.maskLayer.instanceTransform = CATransform3DMakeTranslation(self.elementWidth + self.spacing, 0, 0)
        self.element.backgroundColor = self.inactiveColor.cgColor
        self.element.cornerRadius = self.cornerRadius
        self.element.frame = self.startFrame()
        self.backLayer.frame = self.startFrame()
        
        self.indicator.backgroundColor = self.activeColor.cgColor
        self.indicator.cornerRadius = self.cornerRadius
        self.updateIndicator()
        
        self.maskElement.backgroundColor = UIColor.white.cgColor
        self.maskElement.cornerRadius = self.cornerRadius
        self.maskElement.frame = CGRect(x: 0, y: 0, width: self.elementWidth, height: self.elementHeight)
        
        self.leftBtn.frame = CGRect(x: 0, y: 0, width: self.bounds.width/2, height: self.bounds.height)
        self.rightBtn.frame = CGRect(x: self.bounds.midX, y: 0, width: self.bounds.width/2, height: self.bounds.height)
    }
    
    private func startFrame() -> CGRect {
        let y = self.mainLayer.bounds.midY - (self.elementHeight / 2)
        
        if (self.fillWidthAutomatically == false) {
            let x = (self.bounds.width - ((CGFloat(self.pages) * self.elementWidth) + (CGFloat(self.pages - 1) * self.spacing))) / 2
            
            if (CGFloat(self.pages) * (self.elementWidth + self.spacing) > self.bounds.width) {
                self.elementWidth = (self.bounds.width / CGFloat(self.pages)) - self.spacing
            }
            
            return CGRect(x: x, y: y, width: self.elementWidth, height: self.elementHeight)
        } else {
            let x: CGFloat = 0.0
            
            if (CGFloat(self.pages) * self.elementWidth + (CGFloat(self.pages - 1)) * self.spacing < self.bounds.width) {
                let widthPlusSpacing = self.bounds.width - (CGFloat(self.pages - 1) * self.spacing)
                self.elementWidth = (widthPlusSpacing / CGFloat(self.pages))
            } else if (CGFloat(self.pages) * self.elementWidth + (CGFloat(self.pages - 1)) * self.spacing > self.bounds.width) {
                let widthPlusSpacing = self.bounds.width - (CGFloat(self.pages - 1) * self.spacing)
                self.elementWidth = (widthPlusSpacing / CGFloat(self.pages))
            }
            
            return CGRect(x: x, y: y, width: self.elementWidth, height: self.elementHeight)
        }
    }
    
    private func updatePagesCount() {
        self.mainLayer.instanceCount = self.pages
        self.maskLayer.instanceCount = self.pages
        self.setNeedsLayout()
    }
    
    private func updateIndicator() {
        let state = self.currentPage
        if (self.isAnimated) {
            self.indicator.frame = CGRect(x: 0, y: 0, width: self.elementWidth, height: self.elementHeight)
            self.indicator.frame.origin.x = (CGFloat(state)) * (self.elementWidth + self.spacing)
        } else {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            self.indicator.frame = CGRect(x: 0, y: 0, width: self.elementWidth, height: self.elementHeight)
            self.indicator.frame.origin.x = (CGFloat(state)) * (self.elementWidth + self.spacing)
            CATransaction.commit()
        }
        self.delegate?.pageControl(self, changeProgress: self.currentPage)
    }
    
    @objc private func updateProgress(_ with: UIButton) {
        switch with {
        case self.leftBtn:
            self.currentPage -= 1
            self.delegate?.pageControl(self, didPressedOn: with)
            
        case self.rightBtn:
            self.currentPage += 1
            self.delegate?.pageControl(self, didPressedOn: with)
            
        default:
            break
        }
    }
    
    public func set(progress: Int, animated: Bool) {
        self.isAnimated = animated
        self.currentPage = progress
    }
    
    override public func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: (CGFloat(self.pages) * (self.elementWidth + self.spacing)), height: self.elementHeight)
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.backgroundColor = UIColor.clear
    }
}

