//
//  HomePageViewController.swift
//  chat-ios
//
//  Created by Simon on 13/02/2016.
//  Copyright © 2016 Lucky Egg Studios. All rights reserved.
//

import UIKit
import Quickblox
import Foundation

class HomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var activityIndicatorView: ActivityIndicatorView!
    var userToPass : QBUUser!
    var subjectNames : [String] = []
    var subjects : [SubjectModel] = []
    var selectedSubject : SubjectModel!
    var test : QBCOCustomObject!
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var subjectsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.subjectsTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.activityIndicatorView = ActivityIndicatorView(title: "Signing Out...", center: self.view.center)
        
        //userLabel.text = "User: " + userToPass.fullName!
        userLabel.text = QMServicesManager.instance().currentUser().email
        
        //Get subjects
        retrieveSubjects()
    
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "segueSubjectsTutor") {
            let svc = segue.destinationViewController as! TutorViewController;
            print ("sending subject" + self.selectedSubject.name)
            svc.subjectToPass = self.selectedSubject!
            
        }
    }
    
    //delegate methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subjects.count

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
            let cell = self.subjectsTable.dequeueReusableCellWithIdentifier("subjectCell", forIndexPath: indexPath)
            
            let row = indexPath.row
            cell.textLabel?.text = self.subjects[row].name
            
            return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        print("You have selected: " + String(subjects[indexPath.row].name))
        self.selectedSubject = subjects[indexPath.row]
        self.performSegueWithIdentifier("segueSubjectsTutor", sender: self)

    }

    func retrieveSubjects() {
        
        QBRequest.objectsWithClassName("Subjects", successBlock: {(response: QBResponse, object: [AnyObject]?) -> Void in
                //Get all subjects
                for subjectRow in object!
                {
                    let subject = subjectRow as! QBCOCustomObject
                    //self.test = subjectRow as! QBCOCustomObject
                    
                    let currentSubject  = SubjectModel(id: subject.fields!["subject_id"] as! Int, name: subject.fields!["subject_name"] as! String)
                    
                    self.subjects.append(currentSubject!)
                    //let subjectName =(self.test.fields!["subject_name"] as! String)
                    //self.subjects.append((self.test.fields!["subject_name"] as! String))
                }
                // Update Table Data
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                //reload your tableView
                self.subjectsTable.reloadData()

                })
            
            
            }, errorBlock: {(response: QBResponse) -> Void in
                let alert = UIAlertView()
                alert.title = "Hey"
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
        self.performSegueWithIdentifier("segueHomeSplash", sender: self)
            
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
