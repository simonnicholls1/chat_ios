//
//  ViewController.swift
//  chat-ios
//
//  Created by Simon on 02/02/2016.
//  Copyright © 2016 Lucky Egg Studios. All rights reserved.
//

import UIKit
import Quickblox

class SplashViewController: UIViewController {
    
    var activityIndicatorView : ActivityIndicatorView!
    var userQB : QBUUser = QBUUser()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        self.performSegueWithIdentifier("segueSplashLogin", sender: self)

    }
    @IBAction func registerAction(sender: AnyObject) {
        self.performSegueWithIdentifier("segueSplashRegister", sender: self)
    }



}

