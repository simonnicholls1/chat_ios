//
//  LoginViewController.swift
//  chat-ios
//
//  Created by Simon on 16/02/2016.
//  Copyright © 2016 Lucky Egg Studios. All rights reBserved.
//

import UIKit;
import Quickblox;

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate{
    
    var activityIndicatorView : ActivityIndicatorView!
    var userQB : QBUUser = QBUUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fbLoginButton: FBSDKLoginButton = FBSDKLoginButton();
        fbLoginButton.center = self.view.center;
        fbLoginButton.loginBehavior = FBSDKLoginBehavior.Web;
        //fbLoginButton.addTarget(self, action: "loginButtonClicked", forControlEvents: UIControlEvents.TouchUpInside);
        self.view.addSubview(fbLoginButton);
        
        fbLoginButton.delegate = self;
        
        self.activityIndicatorView = ActivityIndicatorView(title: "Signing In...", center: self.view.center)
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        //Navigation bar
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            NSLog("FB Token: " + FBSDKAccessToken.currentAccessToken().tokenString)
            //already logged in to fb log into QB
            qbLogin(FBSDKAccessToken.currentAccessToken().tokenString)
            self.performSegueWithIdentifier("segueLoginHome", sender: self)
            
        }
        
        if(QMServicesManager.instance().currentUser() != nil)
        {
            
            userQB = QMServicesManager.instance().currentUser()
            NSLog("User already logged in: " + userQB.fullName!)
            self.performSegueWithIdentifier("segueLoginHome", sender: self)
        }

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
    
    func loginButtonClicked(){
        let login = FBSDKLoginManager()
        login.loginBehavior = FBSDKLoginBehavior.Web
        login.logInWithReadPermissions(["public_profile", "email"], fromViewController:self, handler: { (result, error) -> Void in
            let token: FBSDKAccessToken = result.token
            if (error == nil){
                NSLog("Sign in Sucessfull" + token.tokenString)
                NSLog("Sign in Sucessfull" + token.appID)
                
                self.qbLogin(token.tokenString);
            }
            else{
                
                NSLog("Error in Sign in:" + error.description)
            }
        })
    }
    
    func qbLogin(accessToken: String){
        QBRequest.logInWithSocialProvider("facebook", accessToken: accessToken, accessTokenSecret: nil, successBlock: { (response: QBResponse, user: QBUUser?) -> Void in
            
            // ok
            self.userQB = user!
            self.performSegueWithIdentifier("segueLoginHome", sender: self)
            
            }) { (response: QBResponse) -> Void in
                let alert = UIAlertView()
                alert.title = "Login Failed"
                alert.message = String(response.error)
                alert.addButtonWithTitle("OK")
                alert.show()
                NSLog("error: %@", response.error!);
        }
    }

    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if ((error) != nil) {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // Navigate to other view
            self.qbLogin(result.token.tokenString);
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        NSLog("User Logged Out")
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}
