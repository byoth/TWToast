//
//  TWToastWindow.swift
//  TWToast
//
//  Created by kimtaewan on 2017. 5. 18..
//  Copyright © 2017년 carq. All rights reserved.
//

import UIKit


final class TWToastWindow: UIWindow {
    static var shared: TWToastWindow = .init()
    
    fileprivate var baseViewController: UIViewController = .init()
    
//    override var frame: CGRect {
//        set { super.frame = UIScreen.main.bounds }
//        get { return UIScreen.main.bounds }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    fileprivate func setup() {
        baseViewController.view.backgroundColor = .clear
        
        self.windowLevel = UIWindowLevelAlert + 1
        self.rootViewController = baseViewController
        self.isUserInteractionEnabled = false
        self.isHidden = true
    }
    
    
}
