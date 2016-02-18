//
//  ViewController.swift
//  TWToast
//
//  Created by kimtaewan on 2016. 2. 17..
//  Copyright © 2016년 carq. All rights reserved.
//

import UIKit
import TWCheckButton

class ViewController: UIViewController {
    
    @IBOutlet var blurTypes: [UIButton]?
    @IBOutlet var textColors: [UIButton]?
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blurTypes?.tw_group_isRadio = true
        textColors?.tw_group_isRadio = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapToast(sender: AnyObject) {
        TWToast.makeText(textView.text ?? "plz text").show()
    }
    
    @IBAction func didTapBackground(sender: AnyObject) {
        textView.endEditing(true)
    }
    
    @IBAction func didTapButton(sender: UIButton) {
        sender.checked = true
        
        if let type = blurTypes?.tw_group_checked().first {
            switch type.name {
            case "extra_light": TWToastConfig.blurEffect = .ExtraLight
            case "light":       TWToastConfig.blurEffect = .Light
            case "darck":       TWToastConfig.blurEffect = .Dark
            default: break
            }
        }
        
        if let type = textColors?.tw_group_checked().first {
            switch type.name {
            case "white": TWToastConfig.messageTextColor = UIColor.whiteColor()
            case "black": TWToastConfig.messageTextColor = UIColor.blackColor()
            default: break
            }
        }
    }
}

