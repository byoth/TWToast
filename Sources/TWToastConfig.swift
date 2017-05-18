//
//  TWToastConfig.swift
//  TWToast
//
//  Created by kimtaewan on 2016. 2. 17..
//  Copyright © 2016년 carq. All rights reserved.
//

import Foundation
import UIKit

public struct TWToastConfig {
    static public var blockSameMessageInterval: Double = 400
    static public var labelInset: UIEdgeInsets = UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24)
    static public var messageFontSize: CGFloat = 16
    static public var messageTextColor: UIColor = UIColor.white
    static public var blurEffect: UIBlurEffectStyle = .dark
    static public var alignBottomY: CGFloat = UIScreen.main.bounds.height/10
    static public var windowHorizontalMargin: CGFloat = 16
    
    static public var cornerRadius: CGFloat?
}
