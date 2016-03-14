//
//  TutorViewController.swift
//  chat-ios
//
//  Created by Simon on 13/03/2016.
//  Copyright © 2016 Lucky Egg Studios. All rights reserved.
//


import UIKit
import Quickblox
import Foundation

class TutorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var activityIndicatorView: ActivityIndicatorView!
    var subjectToPass : SubjectModel!
    var tutors : [TutorModel] = []
    var test : QBCOCustomObject!
    

    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var tutorsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.subjectsTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.activityIndicatorView = ActivityIndicatorView(title: "Signing Out...", center: self.view.center)
        
        //userLabel.text = "User: " + userToPass.fullName!
        subjectLabel.text = "Select a " + subjectToPass.name + " tutor:"
        //Get subjects
        retrieveTutors()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //delegate methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tutors.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tutorsTable.dequeueReusableCellWithIdentifier("tutorCell", forIndexPath: indexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = self.tutors[row].firstName + " " + self.tutors[row].lastName
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        print("You have selected: " + self.tutors[indexPath.row].firstName)
    }
    
    func retrieveTutors() {
        
        QBRequest.objectsWithClassName("Tutors", successBlock: {(response: QBResponse, object: [AnyObject]?) -> Void in
            //Get all subjects
            for tutorRow in object!
            {
                let tutor = tutorRow as! QBCOCustomObject
                //self.test = subjectRow as! QBCOCustomObject
                
                let currentTutor  = TutorModel(id: tutor.fields!["tutor_id"] as! Int, firstName: tutor.fields!["first_name"] as! String, lastName: tutor.fields!["last_name"] as! String, rating: tutor.fields!["rating"] as! Float, subjectsList: tutor.fields!["subjects_taught"] as! [Int])
                
                self.tutors.append(currentTutor!)
            }
            // Update Table Data
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                //reload your tableView
                self.tutorsTable.reloadData()
                
            })
            
            
            }, errorBlock: {(response: QBResponse) -> Void in
                let alert = UIAlertView()
                alert.title = "Hey"
                print("Error: " + String(response.error))
                alert.message = String(response.error)
                alert.addButtonWithTitle("OK")
                alert.show()
        })
        
    }
    
    
    @IBAction func logoutAction(sender: AnyObject) {
        
        activityIndicatorView.startAnimating()
        self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
        
        QBRequest.logOutWithSuccessBlock({(response: QBResponse) -> Void in
            // logout successful
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.getViewActivityIndicator().removeFromSuperview()
            //self.performSegueWithIdentifier("segueTutorsSplash", sender: self)
            
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

