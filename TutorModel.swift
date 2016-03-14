//
//  SubjectsModel.swift
//  chat-ios
//
//  Created by Simon on 05/03/2016.
//  Copyright © 2016 Lucky Egg Studios. All rights reserved.
//

import UIKit

class TutorModel {
    // MARK: Properties
    
    var id: Int
    var firstName: String
    var lastName: String
    var rating : Float
    var subjectsList : [Int]
    
    
    init?(id: Int, firstName: String, lastName: String, rating: Float, subjectsList: [Int])
    {
        // Initialize stored properties.
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.rating = rating
        self.subjectsList = subjectsList
        
        // Initialization should fail if there is no id
        if firstName.isEmpty {
            return nil
        }
    }
}


 