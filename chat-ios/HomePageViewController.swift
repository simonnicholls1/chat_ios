//
//  HomePageViewController.swift
//  chat-ios
//
//  Created by Simon on 13/02/2016.
//  Copyright © 2016 Lucky Egg Studios. All rights reserved.
//

import UIKit
import Quickblox

class HomePageViewController: UIViewController {
    
    var activityIndicatorView: ActivityIndicatorView!
    var userToPass : QBUUser!
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var lastLoginLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicatorView = ActivityIndicatorView(title: "Signing Out...", center: self.view.center)
        
        userLabel.text = "User: " + userToPass.fullName!
        lastLoginLabel.text = "Last Login: " + String(userToPass.lastRequestAt)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logoutAction(sender: AnyObject) {
        
        activityIndicatorView.startAnimating()
        self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())

        QBRequest.logOutWithSuccessBlock({(response: QBResponse) -> Void in
            // logout successful
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.getViewActivityIndicator().removeFromSuperview()
        self.performSegueWithIdentifier("segueHomeLogin", sender: self)
            
            }, errorBlock: {(response: QBResponse) -> Void in
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.getViewActivityIndicator().removeFromSuperview()
                let alert = UIAlertView()
                alert.title = "Hey"
                alert.message = String(response.error)
                alert.addButtonWithTitle("OK")
                alert.show()
        })
        
    }
    
    
    
}
