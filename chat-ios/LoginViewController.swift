//
//  LoginViewController.swift
//  chat-ios
//
//  Created by Simon on 16/02/2016.
//  Copyright © 2016 Lucky Egg Studios. All rights reserved.
//

import UIKit
import Quickblox

class LoginViewController: UIViewController {
    
    var activityIndicatorView : ActivityIndicatorView!
    var userQB : QBUUser = QBUUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(QMServicesManager.instance().currentUser() != nil)
        {
            userQB = QMServicesManager.instance().currentUser()
            self.performSegueWithIdentifier("segueLoginHome", sender: self)
        }
        self.activityIndicatorView = ActivityIndicatorView(title: "Signing In...", center: self.view.center)
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        //Navigation bar
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "segueLoginHome") {
            let svc = segue.destinationViewController as! HomePageViewController;
            
            svc.userToPass = self.userQB
            
        }
    }
    
    @IBOutlet weak var UserTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBAction func loginAction(sender: AnyObject) {
        
        let emailString : String = UserTextField.text!
        let passwordString : String = PasswordTextField.text!
        
        self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
        self.activityIndicatorView.startAnimating()
        
        QBRequest.logInWithUserEmail(emailString, password: passwordString, successBlock: {(response: QBResponse, user: QBUUser?) -> Void in
            // login successful
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.getViewActivityIndicator().removeFromSuperview()
            
            self.userQB = user!
            self.performSegueWithIdentifier("segueLoginHome", sender: self)
            
            }, errorBlock: {(response: QBResponse) -> Void in
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.getViewActivityIndicator().removeFromSuperview()
                
                let alert = UIAlertView()
                alert.title = "Login Failed"
                alert.message = String(response.error)
                alert.addButtonWithTitle("OK")
                alert.show()
        })

    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}
