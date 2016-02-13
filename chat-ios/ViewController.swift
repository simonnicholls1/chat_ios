//
//  ViewController.swift
//  chat-ios
//
//  Created by Simon on 02/02/2016.
//  Copyright © 2016 Lucky Egg Studios. All rights reserved.
//

import UIKit
import Quickblox

class ViewController: UIViewController {
    
    var activityIndicatorView : ActivityIndicatorView!
    var userQB : QBUUser = QBUUser()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicatorView = ActivityIndicatorView(title: "Signing In...", center: self.view.center)
        
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
    @IBAction func registerAction(sender: AnyObject) {
        self.performSegueWithIdentifier("segueLoginRegister", sender: self)
    }



}

