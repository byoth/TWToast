//
//  TWToastView.swift
//  TWToast
//
//  Created by kimtaewan on 2016. 2. 17..
//  Copyright © 2016년 carq. All rights reserved.
//

import Foundation
import UIKit


class TWToastView: UIView {
    let blurView = UIVisualEffectView()
    let messageLabel = UILabel()
    
    var labelInset: UIEdgeInsets =  TWToastConfig.labelInset {
        didSet {
            updateLabelConstraint()
        }
    }
    var messageFontSize: CGFloat = TWToastConfig.messageFontSize {
        didSet {
            updateLabelStyle()
        }
    }
    var messageTextColor: UIColor = TWToastConfig.messageTextColor {
        didSet{
            updateLabelStyle()
        }
    }
    
    var blurEffect: UIBlurEffectStyle = TWToastConfig.blurEffect {
        didSet {
            blurView.effect = UIBlurEffect(style: blurEffect)
        }
    }
    
    var message: String? {
        didSet{
            messageLabel.text = message
            messageLabel.sizeToFit()
            layoutIfNeeded()
            updateRadius()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        userInteractionEnabled = false
        clipsToBounds = true
        updateLabelStyle()
        setupBlurView()
        setupLabel()
    }
    
    func updateLabelStyle(){
        messageLabel.font = UIFont.systemFontOfSize(messageFontSize)
        messageLabel.textColor = messageTextColor
    }
    
    func updateLabelConstraint(){
        messageLabel.removeConstraints(messageLabel.constraints)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": messageLabel]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(\(labelInset.left))-[view]-(\(labelInset.right))-|", options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: bindings))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(\(labelInset.top))-[view]-(\(labelInset.bottom))-|", options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: bindings))
    }
    
    func setupLabel(){
        messageLabel.numberOfLines = 0
        addSubview(messageLabel)
        updateLabelConstraint()
    }
    
    func setupBlurView(){
        blurView.effect = UIBlurEffect(style: blurEffect)
        insertSubview(blurView, atIndex: 0)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": blurView]
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: bindings))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: bindings))
        
    }
    
    func updateRadius(){
        if let radius = TWToastConfig.cornerRadius {
            layer.cornerRadius =  radius
        } else {
            layer.cornerRadius =  CGRectGetHeight(blurView.bounds)/CGFloat(lineCount())/2
        }
    }
    
    func lineCount() -> Int{
        let size = messageLabel.sizeThatFits(CGSizeMake(messageLabel.bounds.size.width, CGFloat.max))
        return max(Int(size.height / messageLabel.font.lineHeight), 0)
    }
    
}
