//
//  ChatViewController.swift
//  chat-ios
//
//  Created by Simon on 27/03/2016.
//  Copyright © 2016 Lucky Egg Studios. All rights reserved.
//

import UIKit;
import Quickblox;

class ChatViewController: UIViewController, QBChatDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        let user: QBUUser = QBUUser();
        //user.ID = 11186474;
        //user.password! = FBSDKAccessToken.currentAccessToken().tokenString;
        //user.password = "CAAIhQ87YCMYBAIiUNwSGj3M1elz0Hd4XHo0IlPzZAtqJMrg6WTlq3l4ZBaqvEOm4GBpy4yjIpaDJRtXp5QHAGykEDIzzQCJtqm3BS1QDOPBgacvoAVfABNPlemOcPo1XR6UGvRvGvZB2BuaTjhkLZARD7GXJwrP2DKCtCUp0w1wKF8mQNv9XGpdfjnmVv08ZD";
        user.ID = 9249445;
        user.password = "password";
        self.connectToChat(user);
        self.startChat();
    }
    
    func connectToChat(user: QBUUser)
    {
        QBChat.instance().connectWithUser(user) { (error: NSError?) -> Void in
            
            if (error != nil)
            {
                
                let alert = UIAlertView()
                alert.title = "Login Failed"
                alert.message = String(error)
                alert.addButtonWithTitle("OK")
                alert.show()
                NSLog("error: %@", error!);
            }
            
        }
    }
    
    func startChat()
    {
        let chatDialog: QBChatDialog = QBChatDialog(dialogID: nil, type: QBChatDialogType.Private)
        chatDialog.occupantIDs = [9249492]
        
        QBRequest.createDialog(chatDialog, successBlock: {(response: QBResponse?, createdDialog: QBChatDialog?) in
            
            self.sendMessage(createdDialog!);
            
            }, errorBlock: {(response: QBResponse!) in
                
                let alert = UIAlertView()
                alert.title = "Login Failed"
                alert.message = String(response.error)
                alert.addButtonWithTitle("OK")
                alert.show()
                NSLog("error: %@", response.error!);
                
        })
        
        
    }
    
    func sendMessage(chatDialog: QBChatDialog)
    {
        QBChat.instance().addDelegate(self)
        
        let privateChatDialog: QBChatDialog = chatDialog
        let message: QBChatMessage = QBChatMessage()
        message.text = "Hey there"
        
        let params : NSMutableDictionary = NSMutableDictionary()
        params["save_to_history"] = true
        message.customParameters = params
        
        privateChatDialog.sendMessage(message, completionBlock: { (error: NSError?) -> Void in
            
            if (error != nil)
            {
                
                let alert = UIAlertView()
                alert.title = "Login Failed"
                alert.message = String(error)
                alert.addButtonWithTitle("OK")
                alert.show()
                NSLog("error: %@", error!);
            }

            
        });
    }
    
    
    func chatDidReceiveMessage(message: QBChatMessage!) {
        
    }


}
