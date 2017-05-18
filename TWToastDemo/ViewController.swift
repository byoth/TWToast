//
//  ViewController.swift
//  TWToast
//
//  Created by kimtaewan on 2016. 2. 17..
//  Copyright © 2016년 carq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        TWToastConfig.blurEffect = .extraLight
    }
    
    

    @IBAction func didTapToast(_ sender: Any) {
        TWToast.makeText(textView.text ?? "plz text").show()
    }
    
    @IBAction func didTapBackground(_ sender: Any) {
        textView.endEditing(true)
    }
    
}

