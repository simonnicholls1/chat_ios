//
//  SubjectsModel.swift
//  chat-ios
//
//  Created by Simon on 05/03/2016.
//  Copyright © 2016 Lucky Egg Studios. All rights reserved.
//

import UIKit

class StudentModel {
    // MARK: Properties
    
    var id: Int
    var firstName: String
    var lastName: String
    var rating : Double
    
    init?(id: Int, firstName: String, lastName: String, rating: Double)
    {
        // Initialize stored properties.
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.rating = rating
        
        // Initialization should fail if there is no id
        if firstName.isEmpty {
            return nil
        }
    }
}


 