//
//  TWToast.swift
//  TWToast
//
//  Created by kimtaewan on 2016. 2. 17..
//  Copyright © 2016년 carq. All rights reserved.
//

import UIKit

public class TWToast: NSObject {
    static var _toastView: TWToastView?
    static var toastView: TWToastView {
        if _toastView == nil {
            _toastView = TWToastView()
        }
        return _toastView!
    }
    
    private static var currentToast: TWToast?
    private static var toastQueue = [TWToast]()
    private static var using = false
    
    private var message: String?
    private var duration: Double = 2.0
    private let createdAt = NSDate.timeIntervalSinceReferenceDate()
    
    public class func makeText(text: String, duration: Double = 2) -> TWToast {
        let toast = TWToast()
        toast.message = text
        toast.duration = duration
        
        return toast
    }
    
    public func show(){
        if blockToast(TWToast.currentToast) || blockToast(TWToast.toastQueue.last) {
            return
        }
        TWToast.toastQueue.append(self)
        TWToast.showToastQueue()
    }
    
    
    public class func clearAll(){
        toastQueue.removeAll()
        currentToast = nil
        if let toastView = _toastView {
            toastView.removeFromSuperview()
            _toastView = nil
        }
    }
    
}

private extension TWToast {
    
    private func blockToast(targetToast: TWToast?) -> Bool{
        if let toast = targetToast
            where self.createdAt < toast.createdAt + TWToastConfig.blockSameMessageInterval && self.message == toast.message {
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
    
    class func showToWindow(toast: TWToast, callback: (()->Void)){
        if let window = UIApplication.sharedApplication().windows.last {
            window.addSubview(toastView)
            toastView.center = window.center
            toastView.translatesAutoresizingMaskIntoConstraints = false
            
            let bindings = ["view": toastView]
            let visualConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(>=\(TWToastConfig.windowHorizontalMargin))-[view]-(>=\(TWToastConfig.windowHorizontalMargin))-|", options:NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bindings)
            
            window.addConstraints(visualConstraints)
            
            window.addConstraint( NSLayoutConstraint(item: toastView, attribute: .CenterX, relatedBy: .Equal, toItem: window, attribute: .CenterX, multiplier: 1, constant: 0))
            
            window.addConstraint(NSLayoutConstraint(item: toastView, attribute: .Bottom, relatedBy: .Equal, toItem: window, attribute: .Bottom, multiplier: 1, constant: -TWToastConfig.alignBottomY))
            
            toastView.message = toast.message
            
            
            toastView.alpha = 0
            UIView.animateWithDuration(0.5) { () -> Void in
                toastView.alpha = 1
            }
            
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(toast.duration * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                UIView.animateWithDuration(
                    0.4,
                    animations: { () -> Void in
                        toastView.alpha = 0
                    })
                    { (finish) -> Void in
                        toastView.message = ""
                        toastView.removeFromSuperview()
                        callback()
                }
            }
        }
        
    }
}
