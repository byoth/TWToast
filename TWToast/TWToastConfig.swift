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
    static var blockSameMessageInterval: Double = 400
    static var labelInset: UIEdgeInsets = UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24)
    static var messageFontSize: CGFloat = 16
    static var messageTextColor: UIColor = UIColor.white
    static var blurEffect: UIBlurEffectStyle = .dark
    static var alignBottomY: CGFloat = UIScreen.main.bounds.height/10
    static var windowHorizontalMargin: CGFloat = 16
    
    static var cornerRadius: CGFloat?
}
