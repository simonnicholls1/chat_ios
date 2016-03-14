//
//  RegisterViewController.swift
//  chat-ios
//
//  Created by Simon on 13/02/2016.
//  Copyright © 2016 Lucky Egg Studios. All rights reserved.
//

import UIKit
import Quickblox


class RegisterViewController: UIViewController {
    
    var userQB : QBUUser = QBUUser()
    var activityIndicatorView : ActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicatorView = ActivityIndicatorView(title: "Registering...", center: self.view.center)
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "segueRegisterSubjects") {
            let svc = segue.destinationViewController as! HomePageViewController;
            
            svc.userToPass = self.userQB
            
        }
    }

    @IBOutlet weak var emailTextBox: UITextField!
    
    @IBOutlet weak var passwordTextBox: UITextField!
    
    @IBOutlet weak var nameTextBox: UITextField!
    
    @IBAction func registerAction(sender: AnyObject) {
        let emailString : String = emailTextBox.text!
        let passwordString : String = passwordTextBox.text!
        let nameString : String = nameTextBox.text!
        
        quickbloxRegistration(emailString, password: passwordString, name: nameString)
    }
    
    func  quickbloxRegistration  (email: String, password: String, name: String) -> Void
    {
        let user: QBUUser = QBUUser()
        user.email = email
        user.password = password
        user.fullName = name
        
        //start spinner
        self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
        self.activityIndicatorView.startAnimating()
        
        // Registration/sign up of User
        QBRequest.signUp(user, successBlock: {(response: QBResponse, user: QBUUser?) -> Void in
            
            // Sign up was successful
            
            //Login
            QBRequest.logInWithUserEmail(email, password: password, successBlock: {(response: QBResponse, user: QBUUser?) -> Void in
                // login successful
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.getViewActivityIndicator().removeFromSuperview()
                self.userQB = user!
                self.performSegueWithIdentifier("segueRegisterSubjects", sender: self)
                
                }, errorBlock: {(response: QBResponse) -> Void in
                    self.activityIndicatorView.stopAnimating()
                    self.activityIndicatorView.getViewActivityIndicator().removeFromSuperview()
                    let alert = UIAlertView()
                    alert.title = "Error Signing In"
                    alert.message = String(response.error)
                    alert.addButtonWithTitle("OK")
                    alert.show()
            })


            
            }, errorBlock: {(response: QBResponse) -> Void in
                let alert = UIAlertView()
                alert.title = "Error Registering"
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
