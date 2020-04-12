//
//  ViewController.swift
//  FIFOQueue
//
//  Created by 王海洋 on 2020/4/12.
//  Copyright © 2020 王海洋. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var fifoQueue: FIFOQueue = ["rose","jack","pony"]
        
        for index in 0..<fifoQueue.count {
            print("the \(index) element = \(fifoQueue.dequeue())")
        }
        
        // Do any additional setup after loading the view.
    }


}

