//
//  ViewController.swift
//  TWToastExample
//
//  Created by kimtaewan on 2017. 5. 18..
//  Copyright © 2017년 taewan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonDidTap(_ sender: Any) {
        
        TWToast.makeText("toast!!!").show()
    }

}

