//
//  TWToast.swift
//  TWToast
//
//  Created by kimtaewan on 2016. 2. 17..
//  Copyright © 2016년 carq. All rights reserved.
//

import UIKit

open class TWToast: NSObject {
    static var _toastView: TWToastView?
    static var toastView: TWToastView {
        if _toastView == nil {
            _toastView = TWToastView()
        }
        return _toastView!
    }
    
    static var currentToast: TWToast?
    static var toastQueue = [TWToast]()
    static var using = false
    
    var message: String?
    var duration: Double = 12.0
    let createdAt = Date.timeIntervalSinceReferenceDate
    
    open class func makeText(_ text: String, duration: Double = 2) -> TWToast {
        let toast = TWToast()
        toast.message = text
        toast.duration = duration
        
        return toast
    }
    
    open func show(){
        if block(TWToast.currentToast) || block(TWToast.toastQueue.last) {
            return
        }
        TWToast.toastQueue.append(self)
        TWToast.showToastQueue()
    }
    
    
    open class func clearAll(){
        toastQueue.removeAll()
        currentToast = nil
        if let toastView = _toastView {
            toastView.removeFromSuperview()
            _toastView = nil
        }
    }
    
}

extension TWToast {
    
    func block(_ toast: TWToast?) -> Bool{
        guard let targetToast = toast else { return false }
        let isSameBeforeMessage = self.message == targetToast.message
        let isSimilarTime = self.createdAt < targetToast.createdAt + TWToastConfig.blockSameMessageInterval
        if isSimilarTime && isSameBeforeMessage {
            return true
        }
        return false
    }
    
    
    class func showToastQueue(){
        if toastQueue.count == 0 || using == true { return }
        using = true
        let toast = toastQueue.removeFirst()
        currentToast = toast
        TWToast.showToWindow(toast) { () -> Void in
            currentToast = nil
            using = false
            
            if toastQueue.count == 0 {
                _toastView = nil
                return
            }
            TWToast.showToastQueue()
        }
    }
    
    class func showToWindow(_ toast: TWToast, callback: @escaping (()->Void)) {
        let window = TWToastWindow.shared
        guard let view = window.rootViewController?.view else { return }
        
        TWToastWindow.shared.makeKeyAndVisible()
        TWToastWindow.shared.backgroundColor = .clear
        
        view.addSubview(toastView)
        toastView.center = view.center
        toastView.translatesAutoresizingMaskIntoConstraints = false
        
        let bindings = ["view": toastView]
        let visualConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=\(TWToastConfig.windowHorizontalMargin))-[view]-(>=\(TWToastConfig.windowHorizontalMargin))-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bindings)
        
        view.addConstraints(visualConstraints)
        
        view.addConstraint( NSLayoutConstraint(item: toastView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: toastView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -TWToastConfig.alignBottomY))
        
        toastView.message = toast.message
        
        toastView.alpha = 0
        UIView.animate(withDuration: 0.5) { () -> Void in
            toastView.alpha = 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration) {
            UIView.animate(withDuration: 0.4, animations: { _ in
                toastView.alpha = 0
            }) { _ in
                toastView.message = ""
                toastView.removeFromSuperview()
                window.isHidden = true
                callback()
            }
        }
        
    }
}
