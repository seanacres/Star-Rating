//
//  ViewController.swift
//  Star Rating
//
//  Created by Sean Acres on 7/16/19.
//  Copyright © 2019 Sean Acres. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func updateRating(_ sender: CustomControl) {
        if sender.value == 1 {
            title = "User Rating: \(sender.value) star"
        } else {
            title = "User Rating: \(sender.value) stars"
        }
    }
}

