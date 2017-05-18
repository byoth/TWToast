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
}



extension TWToastView {
    
    func setup(){
        isUserInteractionEnabled = false
        clipsToBounds = true
        updateLabelStyle()
        setupBlurView()
        setupLabel()
    }
    
    func updateLabelStyle(){
        messageLabel.font = UIFont.systemFont(ofSize: messageFontSize)
        messageLabel.textColor = messageTextColor
    }
    
    func updateLabelConstraint(){
        messageLabel.removeConstraints(messageLabel.constraints)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": messageLabel]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(\(labelInset.left))-[view]-(\(labelInset.right))-|", options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: bindings))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(\(labelInset.top))-[view]-(\(labelInset.bottom))-|", options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: bindings))
    }
    
    func setupLabel(){
        messageLabel.numberOfLines = 0
        addSubview(messageLabel)
        updateLabelConstraint()
    }
    
    func setupBlurView(){
        blurView.effect = UIBlurEffect(style: blurEffect)
        insertSubview(blurView, at: 0)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": blurView]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: bindings))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics:nil, views: bindings))
        
    }
    
    func updateRadius(){
        if let radius = TWToastConfig.cornerRadius {
            layer.cornerRadius =  radius
        } else {
            layer.cornerRadius =  blurView.bounds.height/CGFloat(lineCount())/2
        }
    }
    
    func lineCount() -> Int{
        let fitsSize = CGSize(width: messageLabel.bounds.size.width, height: CGFloat.greatestFiniteMagnitude)
        let size = messageLabel.sizeThatFits(fitsSize)
        return max(Int(size.height / messageLabel.font.lineHeight), 0)
    }
    
    
}
